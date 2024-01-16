import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../message_model.dart';

class MessageController extends GetxController {
  final show = false.obs;
  FocusNode focusNode = FocusNode();
  final sendButton = false.obs;
  RxList<MessageModel> messages = RxList<MessageModel>();
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  late io.Socket socket;

  final testTest = "إختبار الدردشة هنا.".obs;

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        show.value = false;
        update();
      }
    });
    connect(1);
  }

  void connect(int sourceChatID) {
    log("connecting.............");
    socket = io.io(
      // "http://127.0.0.1:8000/api/v1/webhooks",
      "http://127.0.0.1:6001/webhooks",
      <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": true,
      },
    );
    socket.connect();

    socket.emit("signin", sourceChatID);

    socket.onConnect(
      (data) {
        log("connected.............");
        socket.on(
          "message",
          (msg) {
            setMessage("destination", msg["message"]);
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
        );
      },
    );
    update();
  }

  void setMessage(String type, msg) {
    MessageModel messageModel = MessageModel(
      type: type,
      message: msg,
      time: DateTime.now().toString().substring(10, 16),
    );
    messages.add(messageModel);
    update();
  }

  void sendMessage() {
    setMessage("source", "message");
    socket.emit(
      "message",
      {
        "message": "message",
        "sourceId": 1,
        "targetId": 2,
      },
    );
    update();
  }
}

class TheClass {
  TheClass._();
  int theID = 1;
  String theChannel = "musaneda-message-services";
}
