import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/myColor.dart';
import '../controllers/message_controller.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.transparent,
        title: const Text("تركي"),
      ),
      body: Obx(
        () {
          return Center(
            child: Text(
              controller.testTest.value,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
          );
        },
      ),
    );
  }
}
