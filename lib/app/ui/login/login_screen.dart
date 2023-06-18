import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../utils/app_valid.dart';
import '../ui.dart';

class LoginScreen extends BaseScreen<LoginController> {
  LoginScreen({super.key});

  @override
  Widget? builder() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(height: 50),
          _buildTitleType(),
          _showListInput(),
          _buildRemember(),
          _buildButton(),
          const Expanded(child: SizedBox()),
          SvgPicture.asset(
            AppImages.imgFooter,
            width: Get.width,
          )
        ],
      ),
    );
  }

  Widget _buildButton() {
    return GetX<LoginController>(
      builder: (_) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: controller.checkAuth,
        child: Container(
          alignment: Alignment.center,
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primary,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          width: Get.width,
          child: Text(
            _.screenTypeSign.value == ScreenSign.signIn ? 'Login' : 'Register',
            style: AppTextStyles.medium.copyWith(color: AppColors.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleType() {
    return GetX<LoginController>(
      builder: (_) => Column(
        children: [
          Text(
            _.screenTypeSign.value == ScreenSign.signIn ? 'Login' : 'Register',
            style: AppTextStyles.supperLargeBold.copyWith(color: AppColors.darkBlue),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildItemSelect(
                  'Login',
                  _.screenTypeSign.value == ScreenSign.signIn,
                  () => controller.changeScreen(
                        ScreenSign.signIn,
                      )),
              _buildItemSelect(
                  'Register',
                  _.screenTypeSign.value == ScreenSign.signUp,
                  () => controller.changeScreen(
                        ScreenSign.signUp,
                      )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemSelect(String title, bool isSelect, VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: AppTextStyles.normal.copyWith(
              color: isSelect ? AppColors.green : AppColors.textC4,
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: isSelect,
            child: Container(
              width: 40,
              height: 0.8,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  Widget _showListInput() {
    return GetX<LoginController>(
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 35,
              ),
              _inputLabel(
                  textEdit: controller.emailController,
                  hint: 'Email address',
                  icon: AppImages.iconMail,
                  validator: AppValid.validateEmail()),
              const SizedBox(
                height: 20,
              ),
              _inputLabel(
                  textEdit: controller.passwordController,
                  hint: 'Password',
                  icon: AppImages.iconLock,
                  isShowPassword: _.isEyesPassword.value,
                  validator: AppValid.validatePassword(),
                  onSuffixIcon: () {
                    controller.isEyesPassword.value = !_.isEyesPassword.value;
                  }),
              const SizedBox(
                height: 20,
              ),
              if (_.screenTypeSign.value == ScreenSign.signUp)
                _inputLabel(
                    textEdit: controller.confirmPasswordController,
                    hint: 'Confirm password',
                    icon: AppImages.iconLock,
                    validator: AppValid.validatePasswordConfirm(controller.passwordController),
                    isShowPassword: _.isEyesConfirmPassword.value,
                    onSuffixIcon: () {
                      controller.isEyesConfirmPassword.value = !_.isEyesConfirmPassword.value;
                    }),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRemember() {
    return GetX<LoginController>(builder: (_) {
      return Visibility(
        visible: _.screenTypeSign.value == ScreenSign.signIn,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => controller.changeRemember(),
                    child: Row(
                      children: [
                        Icon(
                          _.isRemember.value ? Icons.check_box : Icons.check_box_outline_blank,
                          size: 23,
                          color: !_.isRemember.value ? AppColors.textC4 : AppColors.primary,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('Remember password'.tr,
                            style: AppTextStyles.small.copyWith(color: AppColors.textA8))
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.dialog(const ForgotPasswordScreen());
                    },
                    child: Text(
                      'Forget password',
                      style: AppTextStyles.small.copyWith(color: AppColors.primary),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40)
          ],
        ),
      );
    });
  }

  Widget _inputLabel(
      {String? hint,
      String? icon,
      TextEditingController? textEdit,
      bool isShowPassword = false,
      String? Function(String? value)? validator,
      VoidCallback? onSuffixIcon}) {
    return TextFormField(
      obscureText: isShowPassword,
      style: AppTextStyles.medium,
      controller: textEdit,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.medium.copyWith(color: AppColors.textC4),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textC4)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textC4)),
        isDense: true,
        contentPadding: const EdgeInsets.all(20.0),
        // contentPadding: const EdgeInsets.only(bottom: -10.0, right: 20),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SvgPicture.asset(
            icon!,
            width: 15,
            height: 15,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minHeight: 24, minWidth: 24),
        suffixIcon: !icon.contains(AppImages.iconLock)
            ? const SizedBox()
            : IconButton(
                icon: isShowPassword
                    ? Icon(
                        Icons.visibility_off,
                        size: 20,
                        color: AppColors.textC4,
                      )
                    : Icon(
                        Icons.visibility,
                        size: 20,
                        color: AppColors.textC4,
                      ),
                onPressed: onSuffixIcon,
              ),
      ),
    );
  }
}

class WidgetInputRoundedTextField extends StatelessWidget {
  const WidgetInputRoundedTextField(
      {super.key,
      this.controller,
      this.maxLine = 1,
      this.hintText = '',
      this.onChange,
      this.color,
      this.enabledBorderColor = true,
      this.fontSize = 13,
      this.inputFormatters = const [],
      this.autoValidate = false,
      this.readOnly = false,
      this.textCapitalization,
      this.initFocusNode,
      this.nextFocusNode,
      this.fontWeight,
      this.validation,
      this.onTap,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.contentPadding = const EdgeInsets.only(
        left: 10,
        bottom: 5,
        right: 10,
      ),
      this.onEditingComplete,
      this.fillColor = const Color(0xffF8F8F8),
      this.textHintColor = const Color(0xFFCCCCCC),
      this.prefixIcon,
      this.suffixIcon});

  final TextEditingController? controller;
  final String? hintText;
  final double? fontSize;
  final List<TextInputFormatter> inputFormatters;
  final bool? autoValidate;
  final bool? readOnly;
  final FocusNode? initFocusNode;
  final FocusNode? nextFocusNode;
  final String? Function(String?)? validation;
  final VoidCallback? onTap;
  final Function(String)? onChange;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final EdgeInsets? contentPadding;
  final Function()? onEditingComplete;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? textHintColor;
  final bool? enabledBorderColor;
  final Color? color;
  final FontWeight? fontWeight;
  final TextCapitalization? textCapitalization;
  final int? maxLine;

  InputDecoration get _inputDecoration => InputDecoration(
        contentPadding: contentPadding,
        hintText: '$hintText',
        hintStyle: TextStyle(
          color: textHintColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: enabledBorderColor!
              ? BorderSide(color: AppColors.text, width: 1)
              : const BorderSide(color: Colors.transparent, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Color(0xffD12A46), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: AppColors.primary, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: AppColors.primary, width: 1),
        ),
        fillColor: fillColor,
        filled: true,
        isDense: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChange,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
      maxLines: maxLine ?? 1,
      onTap: onTap ?? () {},
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validation,
      readOnly: readOnly!,
      focusNode: initFocusNode ?? FocusNode(),
      inputFormatters: inputFormatters,
      onFieldSubmitted: _onFieldSubmitted(context),
      decoration: _inputDecoration,
      onEditingComplete: onEditingComplete,
    );
  }

  Function(String) _onFieldSubmitted(BuildContext context) {
    return (value) {
      if (initFocusNode != null) {
        initFocusNode?.unfocus();
      }
      if (nextFocusNode != null) {
        FocusScope.of(context).requestFocus(nextFocusNode);
      }
    };
  }
}
