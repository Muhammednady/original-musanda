import 'dart:convert';

import 'package:get/get.dart';
import 'package:musaneda/app/modules/technical_support/messages_model.dart';
import 'package:musaneda/config/constance.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';

class TechnicalSupportProvider extends GetConnect {
  final channelId = "e63c2083-7f88-4546-bf08-165ae2bb53a3";
  final webhook = "6fe9eac2-a73d-4bb2-9a8b-3ef594397871";
  final apiUrl = "https://chat-api.keytime.sa/webhooks";
  final apiKey = "Bearer y8PJgaoGamg0R1Ed1ku0SbirhdlWGDMwKQI5mKgw";

  Future<List<dynamic>> sendMessage(messageText, theID, theName) async {
    try {
      final res = await post(
        '$apiUrl/$webhook',
        {
          "channel": {
            "id": "e63c2083-7f88-4546-bf08-165ae2bb53a3",
          },
          "contact": {
            "id": "8772cf4e-1a0f-45f8-bb74-2c504bed8$theID",
            "name": theName
          },
          "message": {
            "id": const Uuid().v1(),
            "text": messageText,
            "type": "text",
          },
          "timestamp":
              DateTime.now().millisecondsSinceEpoch.toString().substring(0, 10),
          "type": "message"
        },
        headers: {
          "Authorization": apiKey,
        },
      );
      Pretty.instance.logger.d(messageText);
      if (res.statusCode == 200) {
        return res.body;
      } else {
        Pretty.instance.logger.w(res.body);
        return Future.error(
          "fetchMessage(): Technical Support Provider Error sending message",
        );
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      Pretty.instance.logger.e(e);
      return Future.error(e);
    }
  }

  Future<List<MessagesModel>> fetchMessage() async {
    try {
      final res = await get(
        '$apiUrl/$webhook',
        headers: {
          "Authorization": apiKey,
        },
      );
      Pretty.instance.logger.d(res.body);
      if (res.statusCode == 200) {
        List messages = jsonDecode(res.body);
        return messages.map((e) => MessagesModel.fromJson(e)).toList();
      } else {
        Pretty.instance.logger.w(res.body);
        return Future.error(
          "fetchMessage(): Technical Support Provider Error fetching message",
        );
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      Pretty.instance.logger.e(e);
      return Future.error(e);
    }
  }
}
