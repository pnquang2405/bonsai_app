import 'package:get/get.dart';
import '../ui.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SearchMainController>(SearchMainController());
  }
}
