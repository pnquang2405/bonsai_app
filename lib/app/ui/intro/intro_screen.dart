import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import '../../../main.dart';
import '../../constants/constants.dart';
import '../ui.dart';

class IntroScreen extends BaseScreen<IntroController> {
  IntroScreen({super.key});

  @override
  Widget? builder() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IntroSlider(
        renderSkipBtn: Text('Skip', style: AppTextStyles.large),
        renderNextBtn: Text('Next', style: AppTextStyles.large),
        renderDoneBtn: Text('Done', style: AppTextStyles.large),
        indicatorConfig: const IndicatorConfig(
            spaceBetweenIndicator: 18,
            sizeIndicator: 9,
            colorIndicator: Colors.black12,
            colorActiveIndicator: Colors.black),
        navigationBarConfig: NavigationBarConfig(
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.white,
        ),
        key: UniqueKey(),
        listContentConfig: [
          ContentConfig(
              marginTitle: EdgeInsets.zero,
              marginDescription: EdgeInsets.zero,
              widgetTitle: const SizedBox(),
              centerWidget: _buildItemIdentify()),
          ContentConfig(
            marginTitle: EdgeInsets.zero,
            marginDescription: EdgeInsets.zero,
            widgetTitle: const SizedBox(),
            centerWidget: _buildItemLearn(),
          ),
          ContentConfig(
            marginTitle: EdgeInsets.zero,
            marginDescription: EdgeInsets.zero,
            widgetTitle: const SizedBox(),
            centerWidget: _buildItemOurCMM(),
          ),
        ],
        onDonePress: controller.onDonePress,
      ),
    );
  }

  Widget _buildItemIdentify() {
    return _WidgetItemPage(
      title: 'identify_plants'.tr,
      des: 'des_identify'.tr,
      positionPadding: controller.positionPadding,
      centerPage: <Widget>[
        SvgPicture.asset(
          AppImages.svg('img_stroke_0'),
          width: Get.width,
        ),
        Positioned(
          top: controller.positionPadding + 80.h,
          child: Row(
            children: [
              Image.asset(
                AppImages.imgPhotographer,
                width: 333,
                height: 400,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
        Positioned(
          top: controller.positionPadding / 0.95.w,
          right: 0,
          left: 400.h,
          child: Image.asset(
            AppImages.imgTree,
            width: 320.h,
            height: 320.h,
          ),
        ),
      ],
    );
  }

  Widget _buildItemLearn() {
    return _WidgetItemPage(
      title: 'learn_plants'.tr,
      des: 'des_learn'.tr,
      positionPadding: controller.positionPadding,
      centerPage: <Widget>[
        SvgPicture.asset(
          AppImages.svg('img_stroke_1'),
          width: Get.width,
        ),
        Positioned(
          top: controller.positionPadding + 5,
          child: Image.asset(
            AppImages.imgLearnBook,
            width: Get.width,
          ),
        )
      ],
    );
  }

  Widget _buildItemOurCMM() {
    return _WidgetItemPage(
      title: 'title_our_community'.tr,
      des: 'des_our_community'.tr,
      positionPadding: controller.positionPadding,
      centerPage: <Widget>[
        SvgPicture.asset(
          AppImages.svg('img_stroke_2'),
          width: Get.width,
        ),
        Positioned(
          top: controller.positionPadding,
          child: Image.asset(
            AppImages.imgPlanters,
            width: Get.width,
          ),
        )
      ],
    );
  }
}

class _WidgetItemPage extends StatelessWidget {
  const _WidgetItemPage({
    super.key,
    required this.centerPage,
    required this.title,
    required this.des,
    required this.positionPadding,
  });

  final List<Widget> centerPage;
  final String title;
  final String des;
  final double positionPadding;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: Stack(
          clipBehavior: Clip.none,
          children: centerPage
            ..add(
              _description(),
            ),
        ),
      ),
    );
  }

  Widget _description() {
    return Positioned(
      bottom: positionPadding,
      right: 0,
      left: 0,
      child: Column(
        children: [
          Text(
            title,
            style: AppTextStyles.largeBold.copyWith(fontSize: 25),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Text(
              des,
              style: AppTextStyles.large.copyWith(color: Colors.black45),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
