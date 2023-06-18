import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../resources/model/model.dart';
import '../../resources/repository/auth_repository.dart';
import '../../utils/app_utils.dart';
import '../../utils/utils.dart';
import '../ui.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> saveEditProfile() async {
    final NetworkState<UserModel> networkState = await AuthRepository().changePassword(
        tokenID: AppPrefs.user?.data?.tokenID,
        password: confirmPasswordController.text,
        oldPassword: oldPasswordController.text);
    if (networkState.isSuccess && networkState.data != null) {
      if (networkState.data?.status == 0) {
        AppPrefs.user = networkState.data;
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
              title: 'Change password',
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
              text: 'Old password:',
              textEdit: oldPasswordController,
              validator: AppValid.validatePassword(),
            ),
            const SizedBox(
              height: 15,
            ),
            _inputLabel(
              text: 'New password:',
              textEdit: newPasswordController,
              validator: AppValid.validatePassword(),
            ),
            const SizedBox(
              height: 15,
            ),
            _inputLabel(
              text: 'Confirm password:',
              textEdit: confirmPasswordController,
              validator: AppValid.validatePasswordConfirm(newPasswordController),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (formKey.currentState?.validate() ?? false) {
                  saveEditProfile();
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
          obscureText: true,
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
