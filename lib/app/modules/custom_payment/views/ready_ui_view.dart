import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/myColor.dart';
import '../controllers/custom_payment_controller.dart';

class ReadyUiView extends GetView<CustomPaymentController> {
  const ReadyUiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.transparent,
        title: const Text('READY UI'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    child: const Text('Credit Card'),
                    onPressed: () {
                      controller.checkoutPage(
                        "credit",
                        controller.liveVisaMasterEntityID,
                        120,
                        true,
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  CupertinoButton(
                    child: const Text('Mada'),
                    onPressed: () {
                      controller.checkoutPage(
                        "mada",
                        controller.liveMadaEntityID,
                        100,
                        true,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (Platform.isIOS)
                    CupertinoButton(
                      child: const Text('APPLEPAY'),
                      onPressed: () {
                        controller.checkoutPage(
                          "APPLEPAY",
                          controller.liveApplePayEntityID,
                          120,
                          true,
                        );
                      },
                    ),
                  const SizedBox(height: 35),
                  Text(
                    controller.resultText,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 20,
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
}
