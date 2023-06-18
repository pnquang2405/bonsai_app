import 'package:get/get.dart';

import '../ui.dart';

class IntroBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IntroController>(IntroController());
  }
}
