import 'package:get/get.dart';

import '../ui.dart';

class MyCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MyCollectionController>(MyCollectionController());
  }
}
