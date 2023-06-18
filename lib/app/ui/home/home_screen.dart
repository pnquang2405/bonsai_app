import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../utils/app_pref.dart';
import '../ui.dart';

class HomeScreen extends BaseScreen<HomeController> {
  @override
  Widget? builder() {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return GetX<HomeController>(builder: (_) {
      if (_.bonsaiModel.value.idBonsai == null) {
        return ValueListenableBuilder(
          valueListenable: cameras,
          builder: (BuildContext context, List<CameraDescription>? cameraPre, Widget? child) {
            return CameraApp(
              cameras: cameraPre ?? [],
              onPost: controller.onPost,
            );
          },
        );
      } else {
        return SizedBox(
          width: Get.width,
          child: SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: ClipPathClipper(),
                      child: Container(
                          width: Get.width,
                          color: AppColors.bezierCurves,
                          height: Get.height / 2.6.h,
                          child: (_.bonsaiModel.value.listImage?.isNotEmpty ?? false)
                              ? PageView.builder(
                                  controller: controller.pageController,
                                  onPageChanged: (int index) {
                                    if (index != _.currentStory.value) {
                                      _.currentStory.value = index;
                                    }
                                  },
                                  itemCount: _.bonsaiModel.value.listImage?.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Image.network(
                                      _.bonsaiModel.value.listImage![index],
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : const SizedBox()),
                    ),
                    Container(
                      height: 5,
                      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                      width: Get.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              if (index != _.currentStory.value) {
                                _.currentStory.value = index;
                                controller.pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 100),
                                  curve: Curves.bounceInOut,
                                );
                              }
                            },
                            child: Obx(
                              () => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      _.currentStory.value == index ? Colors.white : Colors.white54,
                                ),
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                width: Get.width / 4.6,
                              ),
                            ),
                          );
                        },
                        itemCount: _.bonsaiModel.value.listImage?.length,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: Get.height / 2.6.h, right: 18, left: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width / 4.5),
                        child: Column(
                          children: [
                            Text(
                              _.bonsaiModel.value.title ?? '',
                              style: AppTextStyles.supperLargeBold,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              _.bonsaiModel.value.describeLite ?? '',
                              style: AppTextStyles.medium,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _.bonsaiModel.value.name ?? '',
                            style: AppTextStyles.mediumBold,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${_.bonsaiModel.value.fee}',
                            style: AppTextStyles.medium,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Description",
                        style: AppTextStyles.mediumBold,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _.bonsaiModel.value.describe1 ?? '',
                        style: AppTextStyles.medium.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          _.bonsaiModel.value.describe2 ?? '',
                          style: AppTextStyles.medium.copyWith(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Get.height / 2.94.h),
                  child: LikeButton(
                    isLiked: _.bonsaiModel.value.isLike ?? false,
                    size: 80,
                    circleColor: CircleColor(
                      start: AppColors.primary,
                      end: AppColors.primary,
                    ),
                    onTap: (bool value) async {
                      _.bonsaiModel.value.isLike = !value;
                      controller.likePost();
                      return !value;
                    },
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: AppColors.primary,
                      dotSecondaryColor: AppColors.primary,
                    ),
                    likeBuilder: (bool isLiked) {
                      return SvgPicture.asset(isLiked ? AppImages.iconLike : AppImages.iconUnLike);
                    },
                    // likeCount: 665,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}

class ClipPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;

    final Path path = Path();
    //(0,0) 1.Point
    path.lineTo(0, height); //2.Point
    path.quadraticBezierTo(
      width * 0.5, //3.Point --> width * 0.5, height - 100,
      height - 100,
      width, //4.Point --> width, height
      height,
    );
    path.lineTo(width, 0); //5.Point
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
