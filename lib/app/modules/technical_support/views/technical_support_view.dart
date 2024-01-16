import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/routes/app_pages.dart';
import 'package:musaneda/config/myColor.dart';

import '../controllers/technical_support_controller.dart';

class TechnicalSupportView extends GetView<TechnicalSupportController> {
  const TechnicalSupportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: MYColor.primary,
          title: Obx(() {
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.MESSAGE);
              },
              child: Text(
                controller.isTyping.value == true
                    ? 'typing'.tr
                    : 'technical_support'.tr,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            );
          }),
        ),
      ),
      body: Stack(
        children: [
          GetBuilder(
            init: controller,
            builder: (_) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 80, top: 20),
                child: ListView.builder(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  itemCount: controller.messages.length,
                  itemBuilder: (ctx, i) {
                    return _buildMessage(
                      message: controller.messages[i].text,
                      isMe: controller.messages[i].sender == 'client',
                      image: controller.messages[i].file,
                    );
                  },
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () {
                    return Visibility(
                      visible: controller.theFilePath.value.isNotEmpty,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: MemoryImage(
                                base64Decode(controller.theFilePath.value),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: InkWell(
                          onTap: () {
                            controller.uploadFile();
                          },
                          child: Card(
                            elevation: 0.1,
                            color: MYColor.primary,
                            shape: const CircleBorder(
                              side: BorderSide.none,
                            ),
                            child: const Center(
                              child: Icon(
                                CupertinoIcons.add_circled,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          controller: controller.messageController,
                          onChanged: (value) {
                            controller.socket.emit('typing', {
                              'sender': 'me',
                              'receiver': 'admin',
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'type_message'.tr,
                          ),
                          scrollPadding: EdgeInsets.zero,
                          selectionHeightStyle: BoxHeightStyle.max,
                          minLines: 1,
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: InkWell(
                          onTap: () {
                            controller.sendMessage();
                          },
                          child: const Card(
                            color: Colors.green,
                            shape: CircleBorder(
                              side: BorderSide.none,
                            ),
                            elevation: 0.1,
                            child: Center(
                              child: Icon(
                                CupertinoIcons.arrow_up,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage({message, isMe, image = ''}) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: image.isNotEmpty,
              child: Container(
                height: 200,
                width: 200,
                margin: const EdgeInsets.only(left: 8, right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: MemoryImage(
                      base64Decode(image),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              decoration: BoxDecoration(
                color: isMe ? MYColor.primary : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(25),
                  topRight: const Radius.circular(25),
                  bottomRight: isMe
                      ? const Radius.circular(25)
                      : const Radius.circular(0),
                  bottomLeft: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Visibility(
                visible: message.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 300,
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
