import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musaneda/app/modules/login/login_model.dart';
import 'package:musaneda/app/modules/technical_support/providers/technical_support_provider.dart';
import 'package:musaneda/components/mySnackbar.dart';
import 'package:musaneda/config/constance.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../messages_model.dart';

class TechnicalSupportController extends GetxController {
  var box = GetStorage();

  io.Socket socket = io.io(
    'https://kdamat.fnrco.com.sa/api/v1/webhooks',
    <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    },
  );

  @override
  void onInit() {
    super.onInit();
    socket.connect();
    onConnect();
    fetchMessage();
  }

  var isTyping = false.obs;

  onConnect() {
    socket.on('connect', (data) {
      LoginData user = LoginData.fromJson(box.read('LOGIN_MODEL'));
      socket.emit('join', user.toJson());
      log('connect');
    });

    socket.on('disconnect', (data) {
      log('disconnect');
    });

    socket.on('event_message', (data) {
      MessagesModel messagesModel = MessagesModel.fromJson(data);
      messages.add(messagesModel);
      scrollDown();
      update();
    });

    socket.on('typing', (data) {
      isTyping.value = true;
    });

    socket.on('stop_typing', (data) {
      isTyping.value = false;
    });
  }

  ScrollController scrollController = ScrollController();
  final messageController = TextEditingController();

  List<MessagesModel> messages = [
    MessagesModel(
      text: "مرحبا بك في خدمة الدعم الفني",
      type: "text",
      sender: "client",
    ),
    MessagesModel(
      text: "ماذا يمكنني ان افعل لك ؟",
      type: "text",
      sender: "server",
    ),
  ];

  Future<void> fetchMessage() async {
    try {
      TechnicalSupportProvider().fetchMessage().then((value) {
        for (var message in value) {
          messages.add(message);
        }
        scrollDown();
        update();
      });
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      Pretty.instance.logger.e(e);
      throw Future.error(e);
    }
    update();
  }

  Future<void> sendMessage() async {
    socket.emit('stop_typing', 'stop_typing');

    if (messageController.text.isNotEmpty || theFilePath.value.isNotEmpty) {
      MessagesModel msg = MessagesModel(
        text: messageController.text.trim(),
        type: "text",
        file: theFilePath.value,
        sender: "client",
      );
      messages.add(msg);
      TechnicalSupportProvider()
          .sendMessage(msg.text, Constance.instance.id, Constance.instance.name)
          .then((value) {
        Pretty.instance.logger.d(value);
      });
      messageController.clear();
      theFilePath.value = "";
      scrollDown();
    }
    update();
  }

  Map jsonRespondMessage = {
    "contextInfo": {
      "conversation": {
        "id": "1332b4ee-1c01-4ceb-a5c7-0390b1ff0e67",
        "label": null,
        "labels": [],
        "owner": "shawky@fnrco.com.sa",
        "team": null
      },
      "originator": "shawky@fnrco.com.sa"
    },
    "direction": "sent",
    "from": "e63c2083-7f88-4546-bf08-165ae2bb53a3@chat.eazy.im",
    "message": {
      "body": "Test from Keytime",
      "id": "2cfe3b77-d978-4342-a14e-4df353bff466",
      "type": "text"
    },
    "timestamp": 1690697838,
    "to": {
      "jid": "8772cf4e-1a0f-45f8-bb74-2c504bed8589@chat.eazy.im",
      "locale": null,
      "name": "عاصم شرف الدين محمد عبدالقادر",
      "picture": null
    },
    "type": "message",
    "version": 2
  };

  void scrollDown() {
    if (scrollController.position.maxScrollExtent > 0) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInCirc,
      );
    }
    update();
  }

  var theFilePath = "".obs;

  Future<String> imageToBase64(File image) async {
    List<int> imageBytes = await image.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  Future<void> uploadFile() async {
    try {
      await FilePicker.platform.clearTemporaryFiles();

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        theFilePath.value = await imageToBase64(file);
      } else {
        mySnackBar(
          title: "error".tr,
          message: "msg_your_should_upload_file".tr,
          color: Colors.red,
          icon: Icons.error,
        );
      }
      update();
    } on PlatformException catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      if (kDebugMode) {
        print("Unsupported operation: $e");
      }
    }

    update();
  }

  Future<void> sendTyping() async {
    socket.emit('typing', 'typing');
  }

  Future<void> stopTyping() async {
    socket.emit('stop_typing', 'stop_typing');
  }

  @override
  void onClose() {
    super.onClose();
    socket.disconnect();
  }
}
