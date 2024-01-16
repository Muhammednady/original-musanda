import 'package:get/get.dart';

import '../controllers/musaneda_controller.dart';

class MusanedaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MusanedaController>(
      () => MusanedaController(),
    );
  }
}
