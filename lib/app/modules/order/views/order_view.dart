// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/controllers/language_controller.dart';
import 'package:musaneda/app/modules/profile/controllers/profile_controller.dart';
import 'package:musaneda/components/myCupertinoButton.dart';
import 'package:musaneda/components/myStepper.dart';
import 'package:musaneda/config/myColor.dart';
import 'package:musaneda/hyperpay/src/extensions/brands_ext.dart';

import '../../../../components/formatters.dart';
import '../../../../components/myDropdown.dart';
import '../../../../hyperpay/src/enums/brand_type.dart';
import '../../../../hyperpay/src/models/card_info.dart';
import '../../custom_payment/controllers/custom_payment_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/musaneda_model.dart';
import '../../locations/views/create_location_view.dart';
import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.transparent,
        iconTheme: IconThemeData(color: MYColor.black),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(
          'service_request'.tr,
          style: TextStyle(
            color: MYColor.buttons,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: controller,
        builder: (ctx) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: MyStepper(
                  child: const ['1', '2', '3', '4'],
                  titles: [
                    "your_data".tr,
                    "package".tr,
                    "summary".tr,
                    "payment".tr
                  ],
                  width: MediaQuery.of(context).size.width,
                  curStep: controller.currentStep.value,
                  color: MYColor.buttons,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 130, left: 20, right: 20),
                child: _buildStepperBody(context),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: MYColor.background,
          boxShadow: [
            BoxShadow(
              color: MYColor.buttons.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.only(bottom: 10),
        child: GetBuilder(
          init: controller,
          builder: (ctx) {
            return FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    myPreviousButton(context),
                    controller.selectedPayment.value == 1
                        ? myCreditCardButton(context)
                        : controller.selectedPayment.value == 2
                            ? Platform.isIOS
                                ? myApplePayButton(context)
                                : const SizedBox()
                            : controller.selectedPayment.value == 3
                                ? mySadadButton(context)
                                : myConfirmButton(context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStepperBody(BuildContext context) {
    switch (controller.currentStep.value) {
      case 1:
        return myPersonalData(context);
      case 2:
        return myPackage(context);
      case 3:
        return mySummary(context);
      case 4:
        return myPayment(context);
      default:
        return Container();
    }
  }

  Widget myPersonalData(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Column(
        key: ValueKey<int>(controller.currentStep.value),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Text(
              'city'.tr,
              style: TextStyle(
                color: MYColor.texts,
                fontSize: 14,
                fontFamily: 'montserrat_regular',
              ),
            ),
          ),
          Obx(
            () => myDropdown(
              context: context,
              value: controller.selectedCity.value,
              onChanged: (value) {
                controller.setCity = value;
              },
              items: HomeController.I.listCities.map(
                (item) {
                  return DropdownMenuItem(
                    value: item.id,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        LanguageController.I.getLocale == 'en'
                            ? "${item.name?.en}"
                            : "${item.name?.ar}",
                        style: TextStyle(
                          color: MYColor.greyDeep,
                          fontSize: 12,
                          fontFamily: 'montserrat_regular',
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Text(
              'location'.tr,
              style: TextStyle(
                color: MYColor.texts,
                fontSize: 14,
                fontFamily: 'montserrat_regular',
              ),
            ),
          ),
          Obx(
            () => myDropdown(
              context: context,
              value: controller.selectedLocation.value,
              onChanged: (value) {
                if (value == 0) {
                  Get.to(
                    () => const CreateLocationView(
                      action: 'create',
                      page: 'order',
                    ),
                  );
                }
                controller.setLocation = value;
              },
              items: controller.listLocations.map(
                (item) {
                  return DropdownMenuItem(
                    value: item.id,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        item.title!,
                        style: TextStyle(
                          color: MYColor.greyDeep,
                          fontSize: 12,
                          fontFamily: 'montserrat_regular',
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Text(
              'pick_up_branch'.tr,
              style: TextStyle(
                color: MYColor.texts,
                fontSize: 14,
                fontFamily: 'montserrat_regular',
              ),
            ),
          ),
          Obx(() {
            return myDropdown(
              context: context,
              value: controller.selectedBranch.value,
              onChanged: (value) {
                controller.setBranch = value;
              },
              items: controller.listBranches.map((item) {
                return DropdownMenuItem(
                  value: item.id,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      LanguageController.I.getLocale == 'en'
                          ? "${item.name?.en}"
                          : "${item.name?.ar}",
                      style: TextStyle(
                        color: MYColor.greyDeep,
                        fontSize: 12,
                        fontFamily: 'montserrat_regular',
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
          const SizedBox(height: 20),
          // Row(
          //   children: [
          //     Obx(
          //       () => Checkbox(
          //         value: controller.rentEnded.value,
          //         fillColor: MaterialStateProperty.all(MYColor.buttons),
          //         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //         onChanged: (d) {
          //           controller.setIsChecked = d!;
          //         },
          //       ),
          //     ),
          //     Text(
          //       'rent_ended'.tr,
          //       style: TextStyle(
          //         color: MYColor.black,
          //         fontSize: 14,
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

  Widget myPackage(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Stack(
        key: ValueKey<int>(controller.currentStep.value),
        children: [
          Text(
            "choose_your_package".tr,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'montserrat_medium',
              color: MYColor.buttons,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: GetBuilder(
              init: controller,
              builder: (ctx) {
                if (controller.listPackages.isEmpty) {
                  return Center(
                    child: Text("the_packages_is_empty".tr),
                  );
                }
                return ListView.builder(
                  itemCount: controller.listPackages.length,
                  itemBuilder: (ctx, i) {
                    var package = controller.listPackages[i];

                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () {
                          controller.setPackage = package;
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 138,
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
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 5,
                                  right: 5,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "${LanguageController.I.getLocale == "en" ? package.name!.en : package.name!.ar}",
                                        style: TextStyle(
                                          color: MYColor.black,
                                          fontSize: 14,
                                          fontFamily: 'montserrat_regular',
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      // width: 80,
                                      height: 29,
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: MYColor.success.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${'discount'.tr} ${package.discount} ",
                                          style: TextStyle(
                                            color: MYColor.success,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    SvgPicture.asset(
                                      controller.selectedPackage.value ==
                                              package.id
                                          ? "assets/images/icon/check.svg"
                                          : "assets/images/icon/uncheck.svg",
                                      width: 30,
                                      height: 30,
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
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          "${package.duration} ${'month'.tr}",
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
                                          "${package.price} ${'sar'.tr}",
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
                                          "tax".tr,
                                          style: TextStyle(
                                            color: MYColor.black,
                                            fontSize: 12,
                                            fontFamily: 'montserrat_regular',
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "${package.tax} ${'sar'.tr}",
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
                              ),
                            ],
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
    );
  }

  Widget mySummary(BuildContext context) {
    MusanedaData musanedaData = Get.arguments;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Stack(
        key: ValueKey<int>(controller.currentStep.value),
        children: [
          InkWell(
            onTap: () {
              // controller.payWithSadad(context: context, musanedaID: 1);
            },
            child: Text(
              "summary".tr,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'montserrat_medium',
                color: MYColor.buttons,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 138,
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
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "musaneda_details".tr,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 14,
                                  fontFamily: 'montserrat_regular',
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
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "full_name".tr,
                                    style: TextStyle(
                                      color: MYColor.black,
                                      fontSize: 12,
                                      fontFamily: 'montserrat_regular',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    LanguageController.I.getLocale == 'en'
                                        ? "${musanedaData.name!.en}".length > 15
                                            ? "${"${musanedaData.name!.en}".substring(0, 15)}..."
                                            : "${musanedaData.name!.en}"
                                        : "${musanedaData.name!.ar}".length > 15
                                            ? "${"${musanedaData.name!.ar}".substring(0, 15)}..."
                                            : "${musanedaData.name!.ar}",
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
                                    "education".tr,
                                    style: TextStyle(
                                      color: MYColor.black,
                                      fontSize: 12,
                                      fontFamily: 'montserrat_regular',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    LanguageController.I.getLocale == 'en'
                                        ? "${musanedaData.education!.name!.ar}"
                                        : "${musanedaData.education!.name!.ar}",
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
                                    "nationality".tr,
                                    style: TextStyle(
                                      color: MYColor.black,
                                      fontSize: 12,
                                      fontFamily: 'montserrat_regular',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    LanguageController.I.getLocale == 'en'
                                        ? "${musanedaData.nationality!.name!.en}"
                                        : "${musanedaData.nationality!.name!.ar}",
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
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 138,
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
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "client_details".tr,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 14,
                                  fontFamily: 'montserrat_regular',
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
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: GetBuilder(
                            init: ProfileController.I,
                            builder: (ctx) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "full_name".tr,
                                      style: TextStyle(
                                        color: MYColor.black,
                                        fontSize: 12,
                                        fontFamily: 'montserrat_regular',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "${ProfileController.I.profile.name}"
                                                  .length >
                                              15
                                          ? "${"${ProfileController.I.profile.name}".substring(0, 15)}..."
                                          : "${ProfileController.I.profile.name}",
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
                                      "phone_number".tr,
                                      style: TextStyle(
                                        color: MYColor.black,
                                        fontSize: 12,
                                        fontFamily: 'montserrat_regular',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "${ProfileController.I.profile.phone}",
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
                                      "duration".tr,
                                      style: TextStyle(
                                        color: MYColor.black,
                                        fontSize: 12,
                                        fontFamily: 'montserrat_regular',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "${controller.packagesData.duration} ${"month".tr}",
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 138,
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
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "price_details".tr,
                                style: TextStyle(
                                  color: MYColor.black,
                                  fontSize: 14,
                                  fontFamily: 'montserrat_regular',
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: 72,
                                height: 29,
                                decoration: BoxDecoration(
                                  color: MYColor.success.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    "${controller.packagesData.total} ${"sar".tr}",
                                    style: TextStyle(
                                      color: MYColor.success,
                                      fontSize: 12,
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
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "cost".tr,
                                    style: TextStyle(
                                      color: MYColor.black,
                                      fontSize: 12,
                                      fontFamily: 'montserrat_regular',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${controller.packagesData.price} ${"sar".tr}",
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
                                    "discount".tr,
                                    style: TextStyle(
                                      color: MYColor.black,
                                      fontSize: 12,
                                      fontFamily: 'montserrat_regular',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${controller.packagesData.discount} ${"sar".tr}",
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
                                    "tax".tr,
                                    style: TextStyle(
                                      color: MYColor.black,
                                      fontSize: 12,
                                      fontFamily: 'montserrat_regular',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${controller.packagesData.tax} ${"sar".tr}",
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget myPayment(BuildContext context) {
    return GetX(
      init: controller,
      builder: (ctx) => ListView(
        children: [
          Container(
            height: 138,
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
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "total_amount".tr,
                        style: TextStyle(
                          color: MYColor.black,
                          fontSize: 14,
                          fontFamily: 'montserrat_regular',
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 72,
                        height: 29,
                        decoration: BoxDecoration(
                          color: MYColor.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "${controller.packagesData.total} ${"sar".tr}",
                            style: TextStyle(
                              color: MYColor.success,
                              fontSize: 12,
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
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "cost".tr,
                            style: TextStyle(
                              color: MYColor.black,
                              fontSize: 12,
                              fontFamily: 'montserrat_regular',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${controller.packagesData.price} ${"sar".tr}",
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
                            "discount".tr,
                            style: TextStyle(
                              color: MYColor.black,
                              fontSize: 12,
                              fontFamily: 'montserrat_regular',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${controller.packagesData.discount} ${"sar".tr}",
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
                            "tax".tr,
                            style: TextStyle(
                              color: MYColor.black,
                              fontSize: 12,
                              fontFamily: 'montserrat_regular',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${controller.packagesData.tax} ${"sar".tr}",
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
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "payment_method".tr,
            style: TextStyle(
              color: MYColor.buttons,
              fontSize: 16,
              fontFamily: 'montserrat_medium',
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: controller.selectedPayment.value == 1,
            replacement: InkWell(
              onTap: () {
                controller.setPayment = 1;
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: double.infinity,
                height: 86.62,
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
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
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/images/VISA.svg",
                            width: 26.45,
                            height: 18.71,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "credit_card".tr,
                        style: TextStyle(
                          color: MYColor.black,
                          fontSize: 15,
                          fontFamily: 'montserrat_medium',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            child: myFormData(context),
          ),
          SizedBox(height: Platform.isIOS ? 10 : 0),
          Platform.isIOS
              ? InkWell(
                  onTap: () {
                    controller.setPayment = 2;
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: double.infinity,
                    height: 86.62,
                    decoration: BoxDecoration(
                      color: MYColor.white,
                      borderRadius: BorderRadius.circular(10),
                      border: controller.selectedPayment.value == 2
                          ? Border.all(color: MYColor.black, width: 1)
                          : null,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
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
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/images/APPLEPAY.svg",
                                width: 38,
                                height: 15.6,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Apple Pay",
                            style: TextStyle(
                              color: MYColor.black,
                              fontSize: 15,
                              fontFamily: 'montserrat_medium',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              controller.setPayment = 3;
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: double.infinity,
              height: 86.62,
              decoration: BoxDecoration(
                color: MYColor.white,
                borderRadius: BorderRadius.circular(10),
                border: controller.selectedPayment.value == 3
                    ? Border.all(color: MYColor.sadad, width: 1)
                    : null,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              margin: const EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
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
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/images/SADAD.svg",
                          width: 38,
                          height: 13.56,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "sadad".tr,
                      style: TextStyle(
                        color: MYColor.black,
                        fontSize: 15,
                        fontFamily: 'montserrat_medium',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  myINPUTDecoration({String? hint, dynamic prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
      suffixStyle: const TextStyle(
        color: Colors.black,
      ),
      fillColor: MYColor.accent,
      filled: true,
      errorStyle: TextStyle(
        fontSize: 12,
        locale: Get.deviceLocale,
      ),
      hintText: hint,
      // labelText: label,
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
      hintStyle: TextStyle(
        color: MYColor.greyDeep,
        fontSize: 14,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),

      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon is IconData
          ? Icon(
              prefixIcon,
              color: MYColor.buttons,
            )
          : Container(
              padding: const EdgeInsets.all(6),
              width: 10,
              child: Image.asset(prefixIcon),
            ),
    );
  }

  myFormData(BuildContext context) {
    return Form(
      key: CustomPaymentController.I.formOrderKey,
      autovalidateMode: CustomPaymentController.I.autoValidateMode,
      child: Builder(
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MYColor.white,
              borderRadius: BorderRadius.circular(10),
              border: controller.selectedPayment.value == 1
                  ? Border.all(color: MYColor.buttons, width: 1)
                  : null,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
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
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/images/VISA.svg",
                          width: 26.45,
                          height: 18.71,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "credit_card".tr,
                      style: TextStyle(
                        color: MYColor.black,
                        fontSize: 15,
                        fontFamily: 'montserrat_medium',
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 30,
                      child: Image.asset(
                        "assets/images/MASTERCARD.png",
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 30,
                      child: Image.asset(
                        "assets/images/MADA.png",
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 30,
                      child: Image.asset(
                        "assets/images/VISA.png",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  focusNode: CustomPaymentController.I.cardNumberFocus,
                  controller: CustomPaymentController.I.cardHolderController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: myINPUTDecoration(
                    hint: "card_holder_name".tr,
                    prefixIcon: CupertinoIcons.person,
                  ),
                ),
                const SizedBox(height: 10),
                GetX(
                  init: controller,
                  builder: (ctx) {
                    return TextFormField(
                      focusNode: CustomPaymentController.I.cardNumberFocusNode,
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.phone,
                      controller:
                          CustomPaymentController.I.cardNumberController,
                      decoration: myINPUTDecoration(
                        hint: "card_number".tr,
                        prefixIcon: CustomPaymentController.I.brandType.value ==
                                BrandType.none
                            ? CupertinoIcons.creditcard
                            : 'assets/images/${CustomPaymentController.I.brandType.value.name.toUpperCase()}.png',
                      ),
                      onChanged: (value) {
                        CustomPaymentController.I.setBrandType =
                            value.detectBrand;
                      },
                      onEditingComplete: () {
                        CustomPaymentController.I.cardNumberFocusNode.unfocus();
                        FocusScope.of(context).requestFocus(
                            CustomPaymentController.I.cardExpiryDateFocusNode);
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(
                          CustomPaymentController.I.brandType.value.maxLength,
                        ),
                        CardNumberInputFormatter()
                      ],
                      validator: (number) {
                        return CustomPaymentController.I.brandType.value
                            .validateNumber(number ?? "");
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width / 2.5,
                      child: TextFormField(
                        focusNode:
                            CustomPaymentController.I.cardExpiryDateFocusNode,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        controller:
                            CustomPaymentController.I.cardExpiryController,
                        decoration: myINPUTDecoration(
                          hint: "expiry_date".tr,
                          prefixIcon: CupertinoIcons.calendar,
                        ),
                        onChanged: (value) {
                          if (value.length == 5) {
                            CustomPaymentController.I.cardExpiryDateFocusNode
                                .unfocus();
                            FocusScope.of(context).requestFocus(
                                CustomPaymentController.I.cardCvvFocusNode);
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          CardMonthInputFormatter(),
                        ],
                        validator: (String? date) {
                          return CardInfo.validateDate(date ?? "");
                        },
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 2.5,
                      child: TextFormField(
                        focusNode: CustomPaymentController.I.cardCvvFocusNode,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: false,
                          decimal: false,
                        ),
                        onChanged: (value) {
                          if (value.length == 3) {
                            CustomPaymentController.I.cardCvvFocusNode
                                .unfocus();
                          }
                        },
                        controller: CustomPaymentController.I.cardCvvController,
                        decoration: myINPUTDecoration(
                          hint: "cvv".tr,
                          prefixIcon: CupertinoIcons.lock,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        validator: (String? cvv) {
                          return CardInfo.validateCVV(cvv ?? "");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ///My Previous button
  Widget myPreviousButton(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Visibility(
        key: ValueKey<bool>(controller.currentStep.value != 1),
        visible: controller.currentStep.value != 1,
        child: Container(
          height: 50,
          width: 166,
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: MyCupertinoButton(
            fun: () => controller.decrement(),
            text: "previous".tr,
            btnColor: MYColor.accent,
            txtColor: MYColor.black,
          ),
        ),
      ),
    );
  }

  ///My Credit Card Button
  Widget myCreditCardButton(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Container(
        key: ValueKey<bool>(controller.currentStep.value != 4),
        height: 50,
        width: controller.currentStep.value == 1 ? 166 * 2 : 166,
        decoration: BoxDecoration(
          color: MYColor.accent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(1),
        child: Obx(
          () => CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 45,
            onPressed: () => CustomPaymentController.I.pay(
              controller.packagesData.total,
              false,
            ),
            color: MYColor.white,
            borderRadius: BorderRadius.circular(10),
            child: CustomPaymentController.I.brandType.value == BrandType.none
                ? Icon(
                    CupertinoIcons.creditcard,
                    color: MYColor.buttons,
                    size: 30,
                  )
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/${CustomPaymentController.I.brandType.value.name.toUpperCase()}.png',
                      fit: BoxFit.contain,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  ///My Apple Pay Button
  Widget myApplePayButton(BuildContext context) {
    return Container(
      height: 50,
      width: controller.currentStep.value == 1 ? 166 * 2 : 166,
      decoration: BoxDecoration(
        color: MYColor.accent,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(1),
      child: CupertinoButton(
        onPressed: () => CustomPaymentController.I
            .applePay(controller.packagesData.total, false),
        color: MYColor.black,
        padding: EdgeInsets.zero,
        child: SvgPicture.asset(
          "assets/images/APPLEPAY.svg",
          width: 45,
          height: 25,
          color: MYColor.white,
        ),
      ),
    );
  }

  ///My Sadad Button
  Widget mySadadButton(BuildContext context) {
    return Container(
      height: 50,
      width: controller.currentStep.value == 1 ? 166 * 2 : 166,
      decoration: BoxDecoration(
        color: MYColor.accent,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(1),
      child: CupertinoButton(
        onPressed: () {
          controller.onSadadPay(
            context: context,
            musanedaID: Get.arguments.id,
          );
        },
        color: MYColor.sadad,
        padding: EdgeInsets.zero,
        child: SvgPicture.asset(
          "assets/images/SADAD.svg",
          width: 50,
          height: 30,
          color: MYColor.white,
        ),
      ),
    );
  }

  ///My Next | Confirm Button
  Widget myConfirmButton(BuildContext context) {
    MusanedaData musanedaData = Get.arguments;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Container(
        key: ValueKey<bool>(controller.currentStep.value != 4),
        height: 50,
        width: controller.currentStep.value == 1 ? 166 * 2 : 166,
        decoration: BoxDecoration(
          color: MYColor.accent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(1),
        child: MyCupertinoButton(
          fun: () {
            if (controller.currentStep.value == 4) {
              controller.setMusanedaID = musanedaData;
              controller.checkOrder(isDone: false);
            } else {
              controller.increment();
            }
          },
          text: controller.currentStep.value == 4 ? "confirm".tr : "next".tr,
          btnColor: MYColor.buttons,
          txtColor: MYColor.white,
        ),
      ),
    );
  }
}
