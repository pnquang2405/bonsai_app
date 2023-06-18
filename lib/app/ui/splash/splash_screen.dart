import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_text_styles.dart';
import '../ui.dart';

class SplashScreen extends BaseScreen<SplashController> {
  @override
  Widget? builder() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('splash_getting'.tr, style: AppTextStyles.normalBoldBlack,),
      ),
    );
  }
}

