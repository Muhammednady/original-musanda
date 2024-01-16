// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/app/modules/main_home_page/controllers/main_home_page_controller.dart';
import 'package:musaneda/app/modules/order/controllers/order_controller.dart';
import 'package:musaneda/hyperpay/src/extensions/brands_ext.dart';

import '../../../../components/formatters.dart';
import '../../../../config/myColor.dart';
import '../../../../hyperpay/src/enums/brand_type.dart';
import '../../../../hyperpay/src/models/card_info.dart';
import '../../custom_payment/controllers/custom_payment_controller.dart';

class PaymentsView extends GetView<MainHomePageController> {
  final bool isFake;

  const PaymentsView({super.key, this.isFake = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.primary,
        title: Text('payment'.tr),
        centerTitle: true,
      ),
      body: GetX(
        init: controller,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                Container(
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
                  // margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width / 3,
                            child: Text(
                              "service".tr,
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 1.7,
                            child: Text(
                              "( ${controller.getServiceModel.name!.tr} ) ${controller.getServiceModel.packages!.first.name!.tr}",
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 14,
                              ),
                              // textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width / 3,
                            child: Text(
                              "package_price".tr,
                              style: TextStyle(
                                color: MYColor.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 1.7,
                            child: Text(
                              "${controller.getServiceModel.packages!.first.price} ${"sar".tr}",
                              style: TextStyle(
                                color: MYColor.grey,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width / 3,
                            child: Text(
                              "duration".tr,
                              style: TextStyle(
                                color: MYColor.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 1.7,
                            child: Text(
                              "${controller.getDuration} ${"month".tr}",
                              style: TextStyle(
                                color: MYColor.grey,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: controller.finalDiscount != 0,
                        child: const Divider(),
                      ),
                      Visibility(
                        visible: controller.finalDiscount != 0,
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.width / 3,
                              child: Text(
                                "price_before_discount".tr,
                                style: TextStyle(
                                  color: MYColor.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 1.7,
                              child: Text(
                                "${controller.beforeDiscount} ${"sar".tr}",
                                style: TextStyle(
                                  color: MYColor.grey,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: controller.finalDiscount != 0,
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.width / 3,
                              child: Text(
                                "discount".tr,
                                style: TextStyle(
                                  color: MYColor.success,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 1.7,
                              child: Text(
                                "${controller.finalDiscount} ${"sar".tr}",
                                style: TextStyle(
                                  color: MYColor.success,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: controller.finalDiscount != 0,
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.width / 3,
                              child: Text(
                                "price_after_discount".tr,
                                style: TextStyle(
                                  color: MYColor.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 1.7,
                              child: Text(
                                "${controller.finalPrice} ${"sar".tr}",
                                style: TextStyle(
                                  color: MYColor.grey,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width / 3,
                            child: Text(
                              "final_price".tr,
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 1.7,
                            child: Text(
                              "${controller.finalPrice} ${"sar".tr}",
                              style: TextStyle(
                                color: MYColor.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
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
                  visible: OrderController.I.selectedPayment.value == 1,
                  replacement: InkWell(
                    onTap: () {
                      OrderController.I.setPayment = 1;
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
                const SizedBox(height: 10),
                Visibility(
                  visible: OrderController.I.selectedPayment.value == 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myCreditCardButton(context),
                  ),
                ),
                SizedBox(height: Platform.isIOS ? 10 : 0),
                Platform.isIOS
                    ? InkWell(
                        onTap: () {
                          OrderController.I.setPayment = 2;
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: double.infinity,
                          height: 86.62,
                          decoration: BoxDecoration(
                            color: MYColor.white,
                            borderRadius: BorderRadius.circular(10),
                            border: OrderController.I.selectedPayment.value == 2
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
                                      width: 40,
                                      height: 25,
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
                Platform.isIOS
                    ? Visibility(
                        visible: OrderController.I.selectedPayment.value == 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: myApplePayButton(context),
                        ),
                      )
                    : const SizedBox(),
                // const SizedBox(height: 10),
                // InkWell(
                //   onTap: () {
                //     OrderController.I.setPayment = 3;
                //   },
                //   borderRadius: BorderRadius.circular(10),
                //   child: Container(
                //     width: double.infinity,
                //     height: 86.62,
                //     decoration: BoxDecoration(
                //       color: MYColor.white,
                //       borderRadius: BorderRadius.circular(10),
                //       border: OrderController.I.selectedPayment.value == 3
                //           ? Border.all(color: MYColor.sadad, width: 1)
                //           : null,
                //       boxShadow: const [
                //         BoxShadow(
                //           color: Colors.black12,
                //           blurRadius: 5,
                //           offset: Offset(0, 1),
                //         ),
                //       ],
                //     ),
                //     margin: const EdgeInsets.all(5),
                //     child: Padding(
                //       padding: const EdgeInsets.only(left: 20, right: 20),
                //       child: Row(
                //         children: [
                //           Container(
                //             height: 50,
                //             width: 50,
                //             decoration: BoxDecoration(
                //               color: MYColor.white,
                //               borderRadius: BorderRadius.circular(10),
                //               boxShadow: const [
                //                 BoxShadow(
                //                   color: Colors.black12,
                //                   blurRadius: 5,
                //                   offset: Offset(0, 1),
                //                 ),
                //               ],
                //             ),
                //             margin: const EdgeInsets.all(5),
                //             child: Center(
                //               child: SvgPicture.asset(
                //                 "assets/images/SADAD.svg",
                //                 width: 38,
                //                 height: 13.56,
                //               ),
                //             ),
                //           ),
                //           const SizedBox(width: 10),
                //           Text(
                //             "sadad".tr,
                //             style: TextStyle(
                //               color: MYColor.black,
                //               fontSize: 15,
                //               fontFamily: 'montserrat_medium',
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // Visibility(
                //   visible: OrderController.I.selectedPayment.value == 3,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: mySadadButton(context),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }

  myFormData(BuildContext context) {
    return GetBuilder(
      init: CustomPaymentController.I,
      builder: (_) {
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
                  border: OrderController.I.selectedPayment.value == 1
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
                      controller:
                          CustomPaymentController.I.cardHolderController,
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
                          focusNode:
                              CustomPaymentController.I.cardNumberFocusNode,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.phone,
                          controller:
                              CustomPaymentController.I.cardNumberController,
                          decoration: myINPUTDecoration(
                            hint: "card_number".tr,
                            prefixIcon: CustomPaymentController
                                        .I.brandType.value ==
                                    BrandType.none
                                ? CupertinoIcons.creditcard
                                : 'assets/images/${CustomPaymentController.I.brandType.value.name.toUpperCase()}.png',
                          ),
                          onChanged: (value) {
                            CustomPaymentController.I.setBrandType =
                                value.detectBrand;
                          },
                          onEditingComplete: () {
                            CustomPaymentController.I.cardNumberFocusNode
                                .unfocus();
                            FocusScope.of(context).requestFocus(
                                CustomPaymentController
                                    .I.cardExpiryDateFocusNode);
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(
                              CustomPaymentController
                                  .I.brandType.value.maxLength,
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
                            focusNode: CustomPaymentController
                                .I.cardExpiryDateFocusNode,
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
                                CustomPaymentController
                                    .I.cardExpiryDateFocusNode
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
                            focusNode:
                                CustomPaymentController.I.cardCvvFocusNode,
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
                            controller:
                                CustomPaymentController.I.cardCvvController,
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
      },
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

  ///My Credit Card Button
  Widget myCreditCardButton(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Container(
        height: 50,
        width: Get.width - 10,
        decoration: BoxDecoration(
          color: MYColor.accent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(1),
        child: Obx(
          () => CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 45,
            onPressed: () {
              if (CustomPaymentController.I.formOrderKey.currentState!
                  .validate()) {
                CustomPaymentController.I.pay(controller.finalPrice, true);
              }
            },
            color: MYColor.white,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "pay_with_credit_card".tr,
                    style: TextStyle(
                      color: MYColor.buttons,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'montserrat_regular',
                    ),
                  ),
                  CustomPaymentController.I.brandType.value == BrandType.none
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
                ],
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
      width: Get.width - 10,
      decoration: BoxDecoration(
        color: MYColor.accent,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(1),
      child: CupertinoButton(
        onPressed: () {
          // CustomPaymentController.I.applePay(1.00, true);
          CustomPaymentController.I.applePay(controller.finalPrice, isFake);
        },
        color: MYColor.black,
        padding: EdgeInsets.zero,
        child: SvgPicture.asset(
          "assets/images/old_apple_pay.svg",
          width: 45,
          height: 25,
          color: MYColor.white,
        ),
      ),
    );
  }

  ///My Sadad Button
  // Widget mySadadButton(BuildContext context) {
  //   return Container(
  //     height: 50,
  //     decoration: BoxDecoration(
  //       color: MYColor.accent,
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     padding: const EdgeInsets.all(1),
  //     child: CupertinoButton(
  //       onPressed: () {
  //         // controller.onSadadPay(
  //         //   context: context,
  //         //   musanedaID: Get.arguments.id,
  //         // );
  //       },
  //       color: MYColor.sadad,
  //       padding: EdgeInsets.zero,
  //       child: SvgPicture.asset(
  //         "assets/images/SADAD.svg",
  //         width: 50,
  //         height: 30,
  //         color: MYColor.white,
  //       ),
  //     ),
  //   );
  // }
}
