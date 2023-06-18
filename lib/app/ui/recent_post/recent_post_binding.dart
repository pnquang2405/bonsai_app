import 'package:get/get.dart';

import '../ui.dart';

class RecentPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RecentPostController>(RecentPostController());
  }
}
