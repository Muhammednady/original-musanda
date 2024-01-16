import 'package:get/get.dart';

import '../controllers/contract_controller.dart';

class ContractBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContractController>(
      () => ContractController(),
    );
  }
}
