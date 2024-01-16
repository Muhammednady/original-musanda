import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/home/name_language_model.dart';
import 'package:musaneda/app/routes/app_pages.dart';

import '../../../../config/myColor.dart';
import '../../locations/views/create_location_view.dart';
import '../../order/controllers/order_controller.dart';
import '../../order/packages_model.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/main_home_page_controller.dart';
import 'contract_details_view.dart';

class MainHomePageView extends GetView<MainHomePageController> {
  const MainHomePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) => Scaffold(
        key: const ValueKey("mainHomePage"),
        appBar: _appBar(context),
        body: _body(context),
        bottomNavigationBar: Obx(
          () {
            return Container(
              height: 85,
              decoration: BoxDecoration(
                color: MYColor.transparent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                border: Border.fromBorderSide(
                  BorderSide(
                    color: MYColor.accent,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      controller.setTap = 0;
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 60,
                      width: Get.width / 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: SvgPicture.asset(
                              controller.getTap == 0
                                  ? "assets/images/bar/home_red.svg"
                                  : "assets/images/bar/home_black.svg",
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "home".tr,
                            style: TextStyle(
                              color: controller.getTap == 0
                                  ? MYColor.buttons
                                  : MYColor.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      controller.setTap = 1;
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 60,
                      width: Get.width / 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: SvgPicture.asset(
                              controller.getTap == 1
                                  ? "assets/images/bar/contracts_red.svg"
                                  : "assets/images/bar/contracts_black.svg",
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "contract".tr,
                            style: TextStyle(
                              color: controller.getTap == 1
                                  ? MYColor.buttons
                                  : MYColor.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      controller.setTap = 2;
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 60,
                      width: Get.width / 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: SvgPicture.asset(
                              controller.getTap == 2
                                  ? 'assets/images/bar/profile_red.svg'
                                  : 'assets/images/bar/profile_black.svg',
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "personal".tr,
                            style: TextStyle(
                              color: controller.getTap == 2
                                  ? MYColor.buttons
                                  : MYColor.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _body(BuildContext context) {
    switch (controller.getTap) {
      case 0:
        return _home(context);
      case 1:
        return _contract(context);
      case 2:
        return _personal(context);
      default:
        return _home(context);
    }
  }

  _home(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Stack(
          children: [
            Stack(
              children: [
                Container(
                  height: 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: MYColor.primary.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: 110,
                    width: double.infinity,
                    child: GetBuilder(
                      init: controller,
                      builder: (_) => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.services.length,
                        itemBuilder: (ctx, i) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    HapticFeedback.mediumImpact();
                                    controller.setSelectedService =
                                        controller.services[i];
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: MYColor.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow:
                                          controller.getSelectedService ==
                                                  controller.services[i].id
                                              ? [
                                                  BoxShadow(
                                                    color: MYColor.primary,
                                                    blurRadius: 0,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ]
                                              : [],
                                    ),
                                    child: SizedBox(
                                      width: Get.width / 5,
                                      height: 80,
                                      child: SvgPicture.asset(
                                        "${controller.services[i].image}",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${controller.services[i].name}",
                                  style: TextStyle(
                                    color: MYColor.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  /// _list of _packages here
                  Expanded(
                    child: GetBuilder(
                      init: controller,
                      builder: (_) {
                        return ListView.builder(
                          itemCount: controller.services
                              .where(
                                  (e) => e.id == controller.getSelectedService)
                              .first
                              .packages!
                              .length,
                          itemBuilder: (ctx, i) {
                            var package = controller.services
                                .where((e) =>
                                    e.id == controller.getSelectedService)
                                .first
                                .packages![i];

                            var service = controller.services
                                .where((e) =>
                                    e.id == controller.getSelectedService)
                                .first;

                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: InkWell(
                                onTap: () {
                                  HapticFeedback.mediumImpact();
                                  controller.setServiceModel = service;
                                  OrderController.I.setPackage = PackagesData(
                                    id: package.id,
                                    name: NameLanguage(
                                      en: package.name,
                                      ar: package.name,
                                    ),
                                    price: package.price,
                                    discount: package.price,
                                    tax: package.price,
                                    total: package.price,
                                  );

                                  Get.to(
                                    () => const CreateLocationView(
                                      action: 'create',
                                      page: 'main_home_page',
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Image.asset(
                                            "${package.image}",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: Get.width / 2,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${package.name}",
                                                      style: TextStyle(
                                                        color: MYColor.black,
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'montserrat_regular',
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      "${'service'.tr} : ${service.name}",
                                                      style: TextStyle(
                                                        color: MYColor.black,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'montserrat_regular',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width / 5,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'price'.tr,
                                                      style: TextStyle(
                                                        color: MYColor.black,
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'montserrat_regular',
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      "${package.price} ${'sar'.tr}",
                                                      style: TextStyle(
                                                        color: MYColor.black,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'montserrat_regular',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  _contract(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                  Tab(text: "paid_contract".tr),
                  Tab(text: "unpaid_contract".tr),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: TabBarView(
              children: [
                _paidContract(context),
                _unpaidContract(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  _personal(BuildContext context) {
    return const ProfileView(isReal: true);
  }

  _appBar(BuildContext context) {
    switch (controller.getTap) {
      case 0:
        return AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: Text(
            'home'.tr,
            style: TextStyle(
              color: MYColor.buttons,
            ),
          ),
          centerTitle: true,
          backgroundColor: MYColor.transparent,
          iconTheme: IconThemeData(
            color: MYColor.buttons,
            size: 20,
          ),
          actions: [
            IconButton(
              tooltip: "Technical support",
              splashRadius: 20,
              onPressed: () {
                Get.toNamed(Routes.TECHNICAL_SUPPORT);
              },
              icon: Icon(
                CupertinoIcons.chat_bubble_text,
                color: MYColor.buttons,
                size: 30,
              ),
            ),
            const SizedBox(width: 10),
          ],
        );
      case 1:
        return AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: Text(
            'home'.tr,
            style: TextStyle(
              color: MYColor.buttons,
            ),
          ),
          centerTitle: true,
          backgroundColor: MYColor.transparent,
          iconTheme: IconThemeData(
            color: MYColor.buttons,
            size: 20,
          ),
        );
      case 2:
        return null;
      default:
        return null;
    }
  }

  _paidContract(context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        if (controller.contracts.where((e) => e.isPaid! == true).isEmpty) {
          return Center(
            child: Text(
              "no_contracts_paid".tr,
              style: TextStyle(
                color: MYColor.black,
                fontSize: 14,
                fontFamily: 'montserrat_regular',
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount:
              controller.contracts.where((e) => e.isPaid! == true).length,
          itemBuilder: (ctx, i) {
            var obj = controller.contracts
                .where((e) => e.isPaid! == true)
                .toList()[i];
            return InkWell(
              onTap: () {
                MainHomePageController.I.setServiceModel = obj.service!;

                Get.to(
                  () => ContractDetailsView(
                    isPaid: obj.isPaid!,
                    contractModel: obj,
                  ),
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 143,
                width: double.infinity,
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
                margin: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '#C-${obj.number?.substring(0, 10)} - ${obj.service!.packages!.first.name} ',
                            style: TextStyle(
                              color: MYColor.black,
                              fontSize: 12,
                              fontFamily: 'montserrat_regular',
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 29,
                              width: 90,
                              decoration: BoxDecoration(
                                color: MYColor.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  obj.isPaid! ? "paid".tr : "unpaid".tr,
                                  style: TextStyle(
                                    color: MYColor.success,
                                    fontSize: 12,
                                    fontFamily: 'montserrat_regular',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "assets/images/icon/contract.svg",
                              width: 18.75,
                              height: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: MYColor.buttons,
                      thickness: 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "duration".tr,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 12,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${obj.duration!.duration} ${"month".tr}',
                                style: TextStyle(
                                  color: MYColor.buttons,
                                  fontSize: 14,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "price".tr,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 12,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${obj.price} ${"sar".tr}',
                                style: TextStyle(
                                  color: MYColor.buttons,
                                  fontSize: 14,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "service".tr,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 12,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${obj.service!.name}",
                                style: TextStyle(
                                  color: MYColor.buttons,
                                  fontSize: 14,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  _unpaidContract(context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        if (controller.contracts.where((e) => e.isPaid! == false).isEmpty) {
          return Center(
            child: Text(
              "no_contracts_unpaid".tr,
              style: TextStyle(
                color: MYColor.black,
                fontSize: 14,
                fontFamily: 'montserrat_regular',
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount:
              controller.contracts.where((e) => e.isPaid! == false).length,
          itemBuilder: (ctx, i) {
            var obj = controller.contracts
                .where((e) => e.isPaid! == false)
                .toList()[i];
            return InkWell(
              onTap: () {
                MainHomePageController.I.setServiceModel = obj.service!;
                Get.to(
                  () => ContractDetailsView(
                    isPaid: false,
                    contractModel: obj,
                  ),
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 143,
                width: double.infinity,
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
                margin: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '#${obj.number!.substring(0, 10)} - ${obj.service!.packages!.first.name!.tr} ',
                            style: TextStyle(
                              color: MYColor.black,
                              fontSize: 12,
                              fontFamily: 'montserrat_regular',
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 29,
                              width: 90,
                              decoration: BoxDecoration(
                                color: MYColor.warning.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  "unpaid".tr,
                                  style: TextStyle(
                                    color: MYColor.warning,
                                    fontSize: 12,
                                    fontFamily: 'montserrat_regular',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: MYColor.buttons,
                      thickness: 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "duration".tr,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 12,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${obj.duration!.duration} ${"month".tr}',
                                style: TextStyle(
                                  color: MYColor.buttons,
                                  fontSize: 14,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "price".tr,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 12,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${obj.price} ${"sar".tr}',
                                style: TextStyle(
                                  color: MYColor.buttons,
                                  fontSize: 14,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "service".tr,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 12,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                obj.service!.name!.tr,
                                style: TextStyle(
                                  color: MYColor.buttons,
                                  fontSize: 14,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
