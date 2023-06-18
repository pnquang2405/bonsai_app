import 'package:get/get.dart';

import '../ui.dart';

class CommunityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CommunityController>(CommunityController());
  }
}
