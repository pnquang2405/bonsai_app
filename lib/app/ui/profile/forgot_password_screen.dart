import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../resources/model/model.dart';
import '../../resources/repository/auth_repository.dart';
import '../../utils/app_utils.dart';
import '../../utils/utils.dart';
import '../ui.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> forgotPassword() async {
    final NetworkState<UserModel> networkState = await AuthRepository().forgotPassword(
      tokenID: AppPrefs.user?.data?.tokenID,
      email: emailController.text,
    );
    if (networkState.isSuccess && networkState.data != null) {
      if (networkState.data?.status == 0) {
        AppUtils.toast(networkState.data?.message ?? ' ');
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: Column(
          children: [
            const WidgetAppBar(
              title: 'Forgot password',
            ),
            Expanded(child: _buildBody())
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _inputLabel(
              text: 'Email:',
              textEdit: emailController,
              validator: AppValid.validateEmail(),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (formKey.currentState?.validate() ?? false) {
                  forgotPassword();
                }
              },
              child: Container(
                width: Get.width,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xff1EAE86),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Save',
                  style: AppTextStyles.large.copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputLabel({
    String? text,
    TextEditingController? textEdit,
    String? Function(String? value)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text!,
          style: AppTextStyles.normal.copyWith(color: AppColors.primaryDark),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: false,
          style: AppTextStyles.medium,
          controller: textEdit,
          validator: validator,
          decoration: InputDecoration(
            hintStyle: AppTextStyles.medium.copyWith(color: AppColors.textC4),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.2, color: AppColors.primary), //<-- SEE HERE
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.2, color: AppColors.primary), //<-- SEE HERE
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.2, color: AppColors.primary), //<-- SEE HERE
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.2, color: AppColors.primary), //<-- SEE HERE
            ),
            isDense: true,
            contentPadding: const EdgeInsets.all(12.0),
            // contentPadding: const EdgeInsets.only(bottom: -10.0, right: 20),
          ),
        ),
      ],
    );
  }
}
