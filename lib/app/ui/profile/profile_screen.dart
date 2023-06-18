import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../routes/app_pages.dart';
import '../../utils/utils.dart';
import '../ui.dart';
import 'change_password_screen.dart';

class ProfileScreen extends BaseScreen<ProfileController> {
  @override
  Widget? builder() {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50 + Get.mediaQuery.viewPadding.top),
            _buildAvatar(),
            const SizedBox(height: 20),
            Text(
              '${AppPrefs.user?.data?.name}',
              style: AppTextStyles.large.copyWith(color: AppColors.primaryDark),
            ),
            const SizedBox(height: 20),
            _buildEditLogout(),
            const SizedBox(height: 30),
            _buildItemDs(
              'assets/images/png/ic_recent.png',
              'Recent posts',
              () {
                Get.toNamed(Routes.RECENT_POST);
              },
            ),
            _buildItemDs(
              'assets/images/png/ic_change_pass.png',
              'Change password',
              () {
                Get.dialog(const ChangePasswordScreen());
              },
            ),
            _buildItemDs(
              'assets/images/png/ic_fogot_pass.png',
              'Forgot password?',
              () {
                Get.dialog(const ForgotPasswordScreen());
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItemDs(String image, String title, VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(height: 5),
          Row(
            children: [
              Image.asset(
                image,
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 15),
              Text(
                title,
                style: AppTextStyles.normal.copyWith(color: AppColors.primaryDark),
              )
            ],
          ).paddingSymmetric(horizontal: 15),
          const SizedBox(height: 6),
          Container(
            height: 0.6,
            width: Get.width,
            color: AppColors.textA6,
          )
        ],
      ),
    );
  }

  Widget _buildEditLogout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Get.dialog(const EditProfileScreen());
          },
          child: Column(
            children: [
              Image.asset(
                'assets/images/png/ic_user_green.png',
                width: 40,
                height: 40,
              ),
              Text(
                'Edit profile',
                style: AppTextStyles.medium.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => controller.checkLogout(),
          child: Column(
            children: [
              Image.asset(
                'assets/images/png/ic_logout.png',
                width: 40,
                height: 40,
              ),
              Text(
                'Log out',
                style: AppTextStyles.medium.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildAvatar() {
    return Align(
      child: GestureDetector(
        onTap: () async {
          // final dynamic _ = await Get.bottomSheet(const DialogUploadImage());
          //
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/svg/img_oval.svg',
              width: 200,
              height: 200,
            ),
            Column(
              children: [
                Container(
                  width: 80 * 2,
                  height: 80 * 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black54),
                    image: DecorationImage(
                      image: NetworkImage(AppPrefs.user?.data?.avatar ?? ''),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.circular(20),
                  //   child: Image.network(
                  //     AppPrefs.user?.data?.avatar ?? '',
                  //     width: 57 * 2,
                  //     height: 57 * 2,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
