import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../resources/model/model.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_pref.dart';
import '../ui.dart';

class ProfileController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    getMyInfo();
  }

  Future<void> getMyInfo() async {
    final NetworkState<UserModel> networkState = await authRepository.getMyInfo(
      tokenId: AppPrefs.user?.data?.tokenID,
    );
    if (networkState.isSuccess && networkState.data != null) {
      if (networkState.data?.status == 0) {
        AppPrefs.user = networkState.data;
      }
    }
  }

  Future<void> logOut() async {
    final NetworkState<UserModel> networkState = await authRepository.signOut();
    if (networkState.isSuccess && networkState.data != null) {
      if (networkState.data?.status == 0) {}
    }
  }

  Future<void> checkLogout() async {
    final AlertDialog alert = AlertDialog(
      title: Text(
        "Đăng xuất",
        style: AppTextStyles.supperLargeBold.copyWith(color: AppColors.primaryDark),
      ),
      content: Text(
        "Bạn chắc chắn muốn đăng xuất",
        style: AppTextStyles.medium.copyWith(color: AppColors.primaryDark),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: Text(
            "Hủy",
            style: AppTextStyles.medium,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: Text(
            "Xác nhận",
            style: AppTextStyles.medium,
          ),
        ),
      ],
    );
    Get.dialog(alert).then((dynamic value) {
      if (value == true) {
        AppPrefs.user = null;
        logOut();
        Get.offAllNamed(Routes.SIGN_IN);
      }
    });
  }
}
