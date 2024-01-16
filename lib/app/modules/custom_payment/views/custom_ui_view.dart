// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musaneda/hyperpay/src/extensions/brands_ext.dart';

import '../../../../components/formatters.dart';
import '../../../../components/myCupertinoButton.dart';
import '../../../../config/myColor.dart';
import '../../../../hyperpay/src/enums/brand_type.dart';
import '../../../../hyperpay/src/models/card_info.dart';
import '../controllers/custom_payment_controller.dart';

class CustomUiView extends GetView<CustomPaymentController> {
  const CustomUiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.transparent,
        title: const Text('Custom UI'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: MYColor.white,
            borderRadius: BorderRadius.circular(10),
            // border: controller.selectedPayment.value == 1
            //     ? Border.all(color: MYColor.buttons, width: 1)
            //     : null,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              GetX(
                init: controller,
                builder: (_) {
                  return TextFormField(
                    focusNode: controller.cardNumberFocus,
                    textDirection: TextDirection.ltr,
                    controller: controller.cardNumberController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: myINPUTDecoration(
                      hint: "card_number".tr,
                      prefixIcon: controller.brandType.value == BrandType.none
                          ? CupertinoIcons.creditcard
                          : 'assets/images/${controller.brandType.value.name.toUpperCase()}.png',
                    ),
                    onChanged: (value) {
                      controller.setBrandType = value.detectBrand;
                    },
                    onEditingComplete: () {
                      controller.cardNumberFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(
                        controller.cardExpiryDateFocusNode,
                      );
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                        controller.brandType.value.maxLength,
                      ),
                      CardNumberInputFormatter()
                    ],
                    validator: (number) {
                      return controller.brandType.value.validateNumber(
                        number ?? "",
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                focusNode: controller.cardHolderFocus,
                // textDirection: TextDirection.ltr,
                controller: controller.cardHolderController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: myINPUTDecoration(
                  hint: "card_holder_name".tr,
                  prefixIcon: CupertinoIcons.person,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Get.width / 2.5,
                    child: TextFormField(
                      focusNode: controller.cardExpiryDateFocusNode,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      controller: controller.cardExpiryController,
                      decoration: myINPUTDecoration(
                        hint: "expiry_date".tr,
                        prefixIcon: CupertinoIcons.calendar,
                      ),
                      onChanged: (value) {
                        if (value.length == 5) {
                          controller.cardExpiryDateFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(
                            controller.cardCvvFocusNode,
                          );
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
                      focusNode: controller.cardCvvFocusNode,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                        decimal: false,
                      ),
                      onChanged: (value) {
                        if (value.length == 3) {
                          controller.cardCvvFocusNode.unfocus();
                        }
                      },
                      controller: controller.cardCvvController,
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
              const SizedBox(height: 10),
              MyCupertinoButton(
                fun: () => controller.pay(200, true),
                text: "pay".tr,
                btnColor: MYColor.buttons,
                txtColor: MYColor.white,
              ),
              const SizedBox(height: 10),
              if (Platform.isIOS)
                CupertinoButton(
                  onPressed: () => controller.applePay(150, true),
                  color: MYColor.black,
                  padding: EdgeInsets.zero,
                  child: SvgPicture.asset(
                    "assets/images/APPLEPAY.svg",
                    width: 45,
                    height: 25,
                    color: MYColor.white,
                  ),
                ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'STCPAY Number',
                  hintText: "05xxxxxxxx",
                  counter: Offstage(),
                ),
                controller: controller.stcPayController,
                keyboardType: TextInputType.number,
                maxLength: 10,
              ),
              const SizedBox(height: 10),
              CupertinoButton(
                onPressed: () => controller.stcPay(100, true),
                child: const Text('STCPAY'),
              ),
              const SizedBox(height: 35),
              Text(
                controller.resultText,
                style: const TextStyle(color: Colors.green, fontSize: 20),
              ),
            ],
          ),
        ),
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
}
