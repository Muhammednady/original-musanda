// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/config/myColor.dart';

import '../../../../components/myComplaintCard.dart';
import '../controllers/complaint_controller.dart';
import 'create_complaint_view.dart';

class ComplaintView extends GetView<ComplaintController> {
  const ComplaintView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary,
        title: Text('tickets'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const CreateComplaintView());
            },
            icon: SvgPicture.asset(
              'assets/images/icon/plus.svg',
              color: MYColor.white,
              height: 20.31,
              width: 19.5,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Stack(
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
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: MYColor.accent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TabBar(
                  indicatorColor: MYColor.buttons,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: MYColor.white,
                  unselectedLabelColor: MYColor.black,
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: MYColor.buttons,
                    fontFamily: 'montserrat_regular',
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 15,
                    color: MYColor.black,
                    fontFamily: 'montserrat_regular',
                  ),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: MYColor.buttons,
                  ),
                  tabs: [
                    Tab(text: "high".tr),
                    Tab(text: "medium".tr),
                    Tab(text: "low".tr),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
              child: GetX(
                init: controller,
                builder: (ctx) {
                  return TabBarView(
                    children: [
                      controller.listHigh.isEmpty
                          ? Center(
                              child: Text(
                                "no_tickets_found".tr,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.listHigh.length,
                              itemBuilder: (ctx, i) {
                                return MyComplaintCard(
                                  title: controller.listHigh[i].title!,
                                  // status: controller.listHigh[i].status!,
                                  status: i % 2 == 0 ? "open" : "closed",
                                  contractID: controller
                                      .listHigh[i].contract!.id
                                      .toString(),
                                  type: controller.listHigh[i].type == 1
                                      ? "complaint".tr
                                      : controller.listHigh[i].type == 2
                                          ? "suggestion".tr
                                          : "question".tr,
                                  date: "2021-01-01",
                                  description:
                                      controller.listHigh[i].description!,
                                );
                              },
                            ),
                      controller.listMedium.isEmpty
                          ? Center(
                              child: Text(
                                "no_tickets_found".tr,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.listMedium.length,
                              itemBuilder: (ctx, i) {
                                return MyComplaintCard(
                                  title: controller.listMedium[i].title!,
                                  // status: controller.listMedium[i].status!,
                                  status: i % 2 == 0 ? "open" : "closed",
                                  contractID: controller
                                      .listMedium[i].contract!.id
                                      .toString(),
                                  type: controller.listMedium[i].type == 1
                                      ? "complaint".tr
                                      : controller.listMedium[i].type == 2
                                          ? "suggestion".tr
                                          : "question".tr,
                                  date: "20/12/2021",
                                  description:
                                      controller.listMedium[i].description!,
                                );
                              },
                            ),
                      controller.listLow.isEmpty
                          ? Center(
                              child: Text(
                                "no_tickets_found".tr,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.listLow.length,
                              itemBuilder: (ctx, i) {
                                return MyComplaintCard(
                                  title: controller.listLow[i].title!,
                                  // status: controller.listLow[i].status!,
                                  status: i % 2 == 0 ? "open" : "closed",
                                  contractID: controller.listLow[i].contract!.id
                                      .toString(),
                                  type: controller.listLow[i].type == 1
                                      ? "complaint".tr
                                      : controller.listLow[i].type == 2
                                          ? "suggestion".tr
                                          : "question".tr,
                                  date: "20/12/2021",
                                  description:
                                      controller.listLow[i].description!,
                                );
                              },
                            ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
