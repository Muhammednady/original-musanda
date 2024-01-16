import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/myColor.dart';
import '../controllers/custom_payment_controller.dart';
import 'custom_ui_view.dart';
import 'ready_ui_view.dart';

class CustomPaymentView extends GetView<CustomPaymentController> {
  const CustomPaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MYColor.transparent,
        title: const Text('Hyperpay Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Hyperpay Flutter Demo",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              child: const Text('Ready UI'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReadyUiView(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              child: const Text('Custom UI'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomUiView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
