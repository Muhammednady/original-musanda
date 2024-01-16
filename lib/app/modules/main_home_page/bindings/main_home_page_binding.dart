import 'package:get/get.dart';

import '../controllers/main_home_page_controller.dart';

class MainHomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainHomePageController>(
      () => MainHomePageController(),
    );
  }
}
