import 'package:get/get.dart';
import '../ui.dart';

class PostDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PostDetailController>(PostDetailController());
  }
}
