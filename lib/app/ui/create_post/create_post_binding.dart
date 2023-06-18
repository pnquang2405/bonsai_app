import 'package:get/get.dart';
import '../ui.dart';

class CreatePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CreatePostController>(CreatePostController());
  }
}
