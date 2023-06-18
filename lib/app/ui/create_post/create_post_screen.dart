import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../utils/app_pref.dart';
import '../ui.dart';

class CreatePostScreen extends BaseScreen<CreatePostController> {
  @override
  Widget? builder() {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildAvatar(),
          const SizedBox(height: 30),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildCameraButton(),
                _buildPhotosSelected(),
              ],
            ),
          ),
          const SizedBox(height: 15),
          _buildFieldPlant(),
          const SizedBox(height: 20),
          _buildRecognition(),
          const SizedBox(height: 15),
          _buildFiledDes(),
          const SizedBox(height: 20)
          // Text(
          //   "Tap to add text..",
          //   style: AppTextStyles.medium.copyWith(color: AppColors.textC4),
          // )
        ],
      ),
    );
  }

  TextFormField _buildFiledDes() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.multiline,
      autocorrect: false,
      controller: controller.descriptionController,
      enableSuggestions: false,
      maxLength: 1000,
      maxLines: 10,
      decoration: InputDecoration(
          counterStyle: AppTextStyles.small.copyWith(color: AppColors.textC4),
          border: InputBorder.none,
          hintText: 'Tap to add text..',
          fillColor: Colors.transparent,
          hintStyle: AppTextStyles.medium.copyWith(color: AppColors.textC4),
          filled: true,
          contentPadding: const EdgeInsets.only(right: 20)),
      style: AppTextStyles.small,
      // controller: widget.textEditingController,
    );
  }

  Widget _buildRecognition() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Automatic recognition",
          style: AppTextStyles.normal.copyWith(color: AppColors.primary),
        ),
        GetX<CreatePostController>(
          builder: (_) => Transform.scale(
            scale: 0.6,
            child: CupertinoSwitch(
              activeColor: AppColors.primary,
              value: _.isSwitch.value,
              onChanged: (bool value) async {
                _.isSwitch.value = !_.isSwitch.value;
              },
            ),
          ),
        ),
      ],
    );
  }

  DottedBorder _buildFieldPlant() {
    return DottedBorder(
      color: AppColors.primary,
      borderType: BorderType.RRect,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: Get.width,
        height: 70,
        child: Row(
          children: [
            const SizedBox(width: 10),
            Image.asset(
              'assets/images/png/ic_plus.png',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                controller: controller.plantNameController,
                autocorrect: false,
                enableSuggestions: false,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Add Plant name',
                  border: InputBorder.none,
                  hintStyle: AppTextStyles.medium.copyWith(color: AppColors.textC4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GetX<CreatePostController> _buildPhotosSelected() {
    return GetX<CreatePostController>(builder: (_) {
      return Row(
        children: _.photos
            .map(
              (File element) => GestureDetector(
                onTap: () => controller.removedPhoto(_.photos.indexOf(element)),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.file(
                        element,
                        width: 75,
                        height: 85,
                        fit: BoxFit.cover,
                      ).paddingOnly(right: 15),
                    ),
                    Positioned(
                      left: 5,
                      top: 8,
                      child: Image.asset(
                        'assets/images/png/ic_del.png',
                        fit: BoxFit.fill,
                        width: 25,
                        height: 25,
                      ),
                    )
                  ],
                ),
              ),
            )
            .toList(),
      );
    });
  }

  Padding _buildCameraButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: controller.addPhotos,
        child: DottedBorder(
          color: AppColors.primary,
          borderType: BorderType.RRect,
          // padding: const EdgeInsets.all(0),
          child: Container(
            width: 80,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Image.asset(
                'assets/images/png/ic_camera_dot.png',
                width: 40,
                height: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Align(
      child: GestureDetector(
        onTap: controller.addFirstPhotos,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            GetX<CreatePostController>(builder: (_) {
              if (_.avatar.value.path != '') {
                return Image.file(
                  _.avatar.value,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                );
              }
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: controller.addFirstPhotos,
                child: DottedBorder(
                  color: AppColors.primary,
                  borderType: BorderType.RRect,
                  // padding: const EdgeInsets.all(0),
                  child: Image.asset(
                    'assets/images/png/ic_camera_dot.png',
                    width: 250,
                    height: 250,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 2,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ]),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.primaryDark,
            ),
          ),
          Text(
            'Create post',
            style: AppTextStyles.supperLargeBold.copyWith(
              fontSize: 25,
              color: AppColors.primaryDark,
            ),
          ),
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                controller.createPost();
              },
              child: Text(
                "Post",
                style: AppTextStyles.supperLargeBold.copyWith(color: AppColors.primary),
              )),
        ],
      ),
    );
  }
}
