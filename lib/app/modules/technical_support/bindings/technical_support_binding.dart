import 'package:get/get.dart';

import '../controllers/technical_support_controller.dart';

class TechnicalSupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TechnicalSupportController>(
      () => TechnicalSupportController(),
    );
  }
}
