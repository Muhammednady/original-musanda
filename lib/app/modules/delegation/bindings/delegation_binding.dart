import 'package:get/get.dart';

import '../controllers/delegation_controller.dart';

class DelegationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DelegationController>(
      () => DelegationController(),
    );
  }
}
