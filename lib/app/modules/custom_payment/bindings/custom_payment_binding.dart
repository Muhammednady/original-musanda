import 'package:get/get.dart';

import '../controllers/custom_payment_controller.dart';

class CustomPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomPaymentController>(
      () => CustomPaymentController(),
    );
  }
}
