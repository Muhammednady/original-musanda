import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';

import '../../../../config/myColor.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary,
        title: Text('notification'.tr),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: 40,
                width: Get.width,
                decoration: BoxDecoration(
                  color: MYColor.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: GetBuilder(
              init: controller,
              builder: (ctx) {
                if (controller.getNotify.isEmpty) {
                  return Center(
                    child: Text('no_notifications'.tr),
                  );
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.getNotify.length,
                        itemBuilder: (context, i) {
                          return Container(
                            height: 90,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: MYColor.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            margin: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 5,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: LanguageController.I.getLocale == 'ar'
                                      ? null
                                      : 0,
                                  left: LanguageController.I.getLocale == 'ar'
                                      ? 0
                                      : null,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.remove(
                                        controller.getNotify[i],
                                      );
                                    },
                                    child: Icon(
                                      CupertinoIcons.delete,
                                      color: MYColor.primary,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.showNotify(
                                          id: i,
                                          title: 'سداد فواتير',
                                          body:
                                              'قد قمت بسداد الفاتورة رقم 352404134024 حى الله من جانا.',
                                        );
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/images/${controller.getNotify[i].type}.svg',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.getNotify[i].title,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            controller.getNotify[i].dateTime,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 8,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            controller.getNotify[i].body
                                                        .length >
                                                    50
                                                ? '${controller.getNotify[i].body.substring(0, 50)}...'
                                                : controller.getNotify[i].body,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
