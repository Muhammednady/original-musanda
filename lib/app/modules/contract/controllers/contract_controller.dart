import 'package:get/get.dart';

class ContractController extends GetxController {
  void cancelContract(contractID) {
    Get.snackbar('Cancel Contract', 'Cancel Contract');
  }

  void renewContract(contractID) {
    Get.snackbar('Renew Contract', 'Renew Contract');
  }
}
