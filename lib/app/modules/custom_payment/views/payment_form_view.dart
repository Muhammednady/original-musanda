import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/myColor.dart';
import '../controllers/custom_payment_controller.dart';

class PaymentFormView extends GetView<CustomPaymentController> {
  const PaymentFormView({Key? key, required String type}) : super(key: key);
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
              const Text(
                "Checkout Page",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              TextFormField(
                focusNode: controller.cardNumberFocus,
                controller: controller.cardNumberController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: myINPUTDecoration(
                  hint: "card_holder_name".tr,
                  prefixIcon: CupertinoIcons.person,
                ),
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Card Number',
                  counter: Offstage(),
                ),
                controller: controller.cardNumberController,
                maxLength: 16,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Holder Name',
                  counter: Offstage(),
                ),
                controller: controller.cardHolderController,
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Expiry Month',
                        counter: Offstage(),
                      ),
                      controller: controller.cardExpiryController,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Expiry Year',
                        hintText: "ex : 2027",
                        counter: Offstage(),
                      ),
                      controller: controller.cardCvvController,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CVV',
                  counter: Offstage(),
                ),
                controller: controller.cardCvvController,
                keyboardType: TextInputType.number,
                maxLength: 3,
              ),
              CupertinoButton(
                onPressed: () => controller.pay(45000, true),
                child: const Text('PAY'),
              ),
              const SizedBox(height: 10),
              if (Platform.isIOS)
                CupertinoButton(
                  onPressed: () => controller.applePay(45000, true),
                  child: const Text('APPLEPAY'),
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
                onPressed: () => controller.stcPay(45000, true),
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
