import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import '../../constants/app_images.dart';
import '../../routes/app_pages.dart';
import '../../utils/utils.dart';
import '../ui.dart';

class IntroController extends BaseController {
  @override
  void onInit() async {
    super.onInit();
  }

  List<ContentConfig> listContentConfig = <ContentConfig>[].obs;
  double positionPadding = 300.h;

  void onDonePress() {
    if (AppPrefs.user != null) {
      Get.toNamed(Routes.NAVIGATION);
    } else {
      Get.toNamed(Routes.SIGN_IN);
    }
  }
}
