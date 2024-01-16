// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/home/views/taps/contract_tap.dart';
import 'package:musaneda/app/modules/home/views/taps/home_tap.dart';
import 'package:musaneda/app/modules/home/views/taps/services_tap.dart';
import 'package:musaneda/app/modules/login/controllers/login_controller.dart';
import 'package:musaneda/app/routes/app_pages.dart';
import 'package:musaneda/config/myColor.dart';

import '../../../../components/myFilterDialog.dart';
import '../../../controllers/language_controller.dart';
import '../../register/views/terms_and_conditions.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final _drawer = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      key: const ValueKey("mainPage"),
      init: controller,
      builder: (ctx) {
        return AdvancedDrawer(
          backdropColor: MYColor.primary,
          controller: _drawer,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          drawer: myDrawer(context),
          child: Scaffold(
            appBar: myAppBar(context),
            body: myHome(context),
            bottomNavigationBar: Container(
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
                              controller.tap.value == 0
                                  ? "assets/images/bar/home_red.svg"
                                  : "assets/images/bar/home_black.svg",
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "home".tr,
                            style: TextStyle(
                              color: controller.tap.value == 0
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
                      controller.setPrev();
                      controller.setTap = 1;
                      myFilterDialog(context);
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
                              controller.tap.value == 1
                                  ? "assets/images/bar/order_red.svg"
                                  : "assets/images/bar/order_black.svg",
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "add_order".tr,
                            style: TextStyle(
                              color: controller.tap.value == 1
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
                              controller.tap.value == 2
                                  ? "assets/images/bar/services_red.svg"
                                  : "assets/images/bar/services_black.svg",
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "services".tr,
                            style: TextStyle(
                              color: controller.tap.value == 2
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
                      controller.setTap = 3;
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
                              controller.tap.value == 3
                                  ? "assets/images/bar/contracts_red.svg"
                                  : "assets/images/bar/contracts_black.svg",
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "contract".tr,
                            style: TextStyle(
                              color: controller.tap.value == 3
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
            ),
          ),
        );
      },
    );
  }

  Widget myHome(context) {
    switch (controller.tap.value) {
      case 0:
        return homeTap(context);
      case 2:
        return servicesTap(context);
      case 3:
        return contractsTap(context);
      default:
        return homeTap(context);
    }
  }

  PreferredSizeWidget myAppBar(BuildContext context) {
    switch (controller.tap.value) {
      case 0:
        return myHomeAppBar(context);
      case 2:
        return AppBar(
          backgroundColor: MYColor.primary,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text(
            'services'.tr,
            style: TextStyle(
              color: MYColor.white,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.SEARCH);
              },
              icon: const Icon(CupertinoIcons.search),
              color: MYColor.white,
            ),
          ],
          leading: myDrawerIcon(context, MYColor.white),
        );
      case 3:
        return AppBar(
          backgroundColor: MYColor.primary,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text(
            'contract'.tr,
            style: TextStyle(
              color: MYColor.white,
            ),
          ),
          centerTitle: true,
          leading: myDrawerIcon(context, MYColor.white),
        );
      default:
        return myHomeAppBar(context);
    }
  }

  Widget myDrawerIcon(context, Color color) {
    return IconButton(
      onPressed: () {
        _drawer.showDrawer();
      },
      icon: ValueListenableBuilder<AdvancedDrawerValue>(
        valueListenable: _drawer,
        builder: (_, value, __) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: SvgPicture.asset(
              value.visible
                  ? 'assets/images/drawer/drawer.svg'
                  : 'assets/images/drawer/drawer.svg',
              key: ValueKey<bool>(value.visible),
              color: color,
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget myHomeAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: MYColor.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: Text(
        'home'.tr,
        style: TextStyle(
          color: MYColor.buttons,
        ),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: MYColor.buttons,
        size: 20,
      ),
      leading: myDrawerIcon(context, MYColor.buttons),
      actions: [
        IconButton(
          onPressed: () {
            Get.toNamed(Routes.SEARCH);
          },
          icon: const Icon(CupertinoIcons.search),
        ),
        IconButton(
          onPressed: () {
            Get.toNamed(Routes.NOTIFICATION);
          },
          icon: const Icon(CupertinoIcons.bell),
        ),
      ],
    );
  }

  void showLanguageDialog(context) {
    showModalBottomSheet(
      constraints: const BoxConstraints(
        maxHeight: 195,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (ctx) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "language".tr,
                style: TextStyle(
                  color: MYColor.primary,
                  fontFamily: 'montserrat_medium',
                  fontSize: 16,
                ),
              ),
            ),
            Obx(
              () => SizedBox(
                height: 120,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Divider(
                        color: MYColor.buttons.withOpacity(0.2),
                      ),
                    );
                  },
                  itemCount: LanguageController.I.lang.length,
                  itemBuilder: (ctx, i) {
                    // _drawer.hideDrawer();
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: InkWell(
                        onTap: () {
                          LanguageController.I.changeLocale(
                            LanguageController.I.lang[i],
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                LanguageController.I.lang[i] == 'english'
                                    ? "assets/images/en.png"
                                    : "assets/images/ar.png",
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              LanguageController.I.lang[i].tr,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const Spacer(),
                            LanguageController.I.getLocale.startsWith("a") ==
                                    LanguageController.I.lang[i].startsWith("a")
                                ? SvgPicture.asset(
                                    "assets/images/drawer/checked.svg",
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget myDrawer(context) {
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(
                top: 30,
                bottom: 20,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/images/drawer/user.svg',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 30,
              ),
              child: Text(
                "${LoginController.I.getName()}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.PROFILE);
              },
              leading: SvgPicture.asset(
                'assets/images/drawer/person.svg',
              ),
              title: Text('profile'.tr),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.DELEGATION);
              },
              leading: SvgPicture.asset(
                'assets/images/drawer/delegation.svg',
              ),
              title: Text('delegation'.tr),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.LOCATIONS);
              },
              leading: SvgPicture.asset(
                'assets/images/drawer/location.svg',
              ),
              title: Text('location'.tr),
            ),
            ListTile(
              onTap: () {
                showLanguageDialog(context);
              },
              leading: SvgPicture.asset(
                'assets/images/drawer/language.svg',
              ),
              title: Text('language'.tr),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.COMPLAINT);
              },
              leading: SvgPicture.asset(
                'assets/images/drawer/complain.svg',
              ),
              title: Text('tickets'.tr),
            ),
            // Technical support

            ListTile(
              onTap: () {
                Get.toNamed(Routes.TECHNICAL_SUPPORT);
              },
              leading: const Icon(CupertinoIcons.chat_bubble_2),
              title: Text('technical_support'.tr),
            ),
            ListTile(
              onTap: () => LoginController.I.logout(),
              leading: SvgPicture.asset(
                'assets/images/drawer/logout.svg',
              ),
              title: Text('logout'.tr),
            ),
            const Spacer(),

            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white54,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: InkWell(
                  onTap: () {
                    LanguageController.I.loadPrivacyPolicy();
                    termsAndConditions(LanguageController.I.privacyPolicy);
                  },
                  child: Text(
                    '${'service_terms'.tr} | ${'privacy_policy'.tr}',
                    style: const TextStyle(
                      fontFamily: 'mikhak_medium',
                    ),
                  ),
                ),
              ),
            ),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white54,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: GetBuilder(
                  init: controller,
                  builder: (controller) {
                    return Text(
                      controller.versions.value.toString(),
                      style: const TextStyle(
                        fontFamily: 'mikhak_medium',
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
