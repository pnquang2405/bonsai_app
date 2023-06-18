import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../resources/model/model.dart';
import '../../resources/resources.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_pref.dart';
import '../../utils/app_utils.dart';
import '../ui.dart';

enum ScreenSign { signIn, signUp }

class LoginController extends BaseController {
  RxBool isRemember = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<ScreenSign> screenTypeSign = ScreenSign.signIn.obs;

  RxBool isEyesPassword = true.obs;
  RxBool isEyesConfirmPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void changeScreen(ScreenSign type) {
    if (screenTypeSign.value != type) {
      isEyesPassword.value = true;
      isEyesConfirmPassword.value = true;
      formKey.currentState?.reset();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      screenTypeSign.value = type;
    }
  }

  Future<void> checkAuth() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }
    final NetworkState<UserModel> networkState;
    if (screenTypeSign.value == ScreenSign.signIn) {
      networkState = await authRepository.signIn(
        email: emailController.text,
        password: passwordController.text,
      );
    } else {
      networkState = await authRepository.signUp(
        email: emailController.text,
        password: passwordController.text,
      );
    }
    if (networkState.isSuccess && networkState.data != null) {
      AppUtils.toast(networkState.data?.message ?? '');
      if (isRemember.value) {
        AppPrefs.user = networkState.data;
      }
      Get.toNamed(Routes.NAVIGATION);
    }
  }

  void changeRemember() {
    isRemember.value = !isRemember.value;
  }
}
