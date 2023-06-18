import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../resources/model/model.dart';
import '../../resources/repository/auth_repository.dart';
import '../../utils/app_utils.dart';
import '../../utils/utils.dart';
import '../ui.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> saveEditProfile() async {
    final NetworkState<UserModel> networkState = await AuthRepository().editProfile(
        tokenID: AppPrefs.user?.data?.tokenID,
        name: nameController.text,
        email: emailController.text);
    if (networkState.isSuccess && networkState.data != null) {
      if (networkState.data?.status == 0) {
        AppPrefs.user = networkState.data;
        AppPrefs.user?.data?.name = nameController.text;
        AppPrefs.user?.data?.email = nameController.text;
        AppUtils.toast(networkState.data?.message ?? ' ');
        Get.back();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    emailController.text = AppPrefs.user?.data?.email ?? '';
    nameController.text = AppPrefs.user?.data?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: Column(
          children: [
            const WidgetAppBar(
              title: 'Edit Profile',
            ),
            Expanded(child: _buildBody())
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _inputLabel(
              textEdit: nameController,
              hint: 'Name',
              icon: 'assets/images/png/ic_card_green.png',
              validator: AppValid.validateFullName(),
            ),
            _inputLabel(
              textEdit: emailController,
              hint: 'Email',
              icon: 'assets/images/png/ic_mail_green.png',
              validator: AppValid.validateEmail(),
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

  Widget _inputLabel(
      {String? hint,
      String? icon,
      TextEditingController? textEdit,
      String? Function(String? value)? validator,
      VoidCallback? onSuffixIcon}) {
    return TextFormField(
      obscureText: false,
      style: AppTextStyles.medium,
      controller: textEdit,
      validator: validator,
      decoration: InputDecoration(
        hintStyle: AppTextStyles.medium.copyWith(color: AppColors.textC4),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textC4)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textC4)),
        isDense: true,
        contentPadding: const EdgeInsets.all(20.0),
        // contentPadding: const EdgeInsets.only(bottom: -10.0, right: 20),
        prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset(
              icon!,
              width: 30,
              height: 30,
            )),
        prefixIconConstraints: const BoxConstraints(minHeight: 24, minWidth: 24),
      ),
    );
  }
}

class WidgetAppBar extends StatelessWidget {
  const WidgetAppBar({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 15),
      margin: EdgeInsets.only(bottom: 15),
      alignment: Alignment.center,
      width: Get.width,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.primaryDark,
                  size: 20,
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          Align(
            alignment: const Alignment(0.0, 2.0),
            child: Text(
              title,
              style: AppTextStyles.supperLargeBold.copyWith(
                fontSize: 25,
                color: AppColors.primaryDark,
              ),
            ),
          )
        ],
      ),
    );
  }
}
