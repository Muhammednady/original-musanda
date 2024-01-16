import 'package:get/get.dart';

import '../controllers/transfer_sponsorship_controller.dart';

class TransferSponsorshipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferSponsorshipController>(
      () => TransferSponsorshipController(),
    );
  }
}
