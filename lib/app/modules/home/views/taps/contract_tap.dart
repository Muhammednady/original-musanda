import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/routes/app_pages.dart';

import '../../../../../components/myContractCard.dart';
import '../../../../../config/myColor.dart';
import '../../../../controllers/language_controller.dart';
import '../../controllers/home_controller.dart';

Widget contractsTap(context) {
  HomeController ctrHome = HomeController.I;
  return DefaultTabController(
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
                Tab(text: "all_contracts".tr),
                Tab(text: "active".tr),
                Tab(text: "expired".tr),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: GetX(
            init: ctrHome,
            builder: (ctx) {
              if (ctrHome.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return TabBarView(
                children: [
                  ctrHome.listContracts.isEmpty
                      ? Center(child: Text("no_contracts".tr))
                      : ListView.builder(
                          itemCount: ctrHome.listContracts.length,
                          itemBuilder: (ctx, i) {
                            var list = ctrHome.listContracts[i];

                            return MyContractCard(
                              title: LanguageController.I.getLocale == 'ar'
                                  ? "${list.package?.name?.ar}"
                                  : "${list.package?.name?.en}",
                              price: list.package!.price!,
                              duration: list.package!.duration!,
                              tax: list.package!.discount!,
                              status: "${list.status}",
                              onTap: () {
                                Get.toNamed(
                                  Routes.CONTRACT,
                                  arguments: list,
                                );
                              },
                            );
                          },
                        ),
                  ctrHome.listActive.isEmpty
                      ? Center(child: Text('no_active_contracts'.tr))
                      : ListView.builder(
                          itemCount: ctrHome.listActive.length,
                          itemBuilder: (ctx, i) {
                            var active = ctrHome.listActive[i];
                            return MyContractCard(
                              title: LanguageController.I.getLocale == 'ar'
                                  ? "${active.package?.name?.ar}"
                                  : "${active.package?.name?.en}",
                              price: active.package!.price!,
                              duration: active.package!.duration!,
                              tax: active.package!.discount!,
                              status: "${active.status}",
                              onTap: () {
                                Get.toNamed(
                                  Routes.CONTRACT,
                                  arguments: HomeController.I.listFinished[i],
                                );
                              },
                            );
                          },
                        ),
                  ctrHome.listFinished.isEmpty
                      ? Center(child: Text('no_expired_contracts'.tr))
                      : ListView.builder(
                          itemCount: ctrHome.listFinished.length,
                          itemBuilder: (ctx, i) {
                            var finished = ctrHome.listFinished[i];

                            return MyContractCard(
                              title: LanguageController.I.getLocale == 'ar'
                                  ? "${finished.package?.name?.ar}"
                                  : "${finished.package?.name?.en}",
                              price: finished.package!.price!,
                              duration: finished.package!.duration!,
                              tax: finished.package!.discount!,
                              status: "${finished.status}",
                              onTap: () {
                                Get.toNamed(
                                  Routes.CONTRACT,
                                  arguments: ctrHome.listFinished[i],
                                );
                              },
                            );
                          },
                        ),
                ],
              );
            },
          ),
        )
      ],
    ),
  );
}
