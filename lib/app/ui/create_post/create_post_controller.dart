import 'dart:io';
import 'package:flutter/cupertino.dart';
import '../../resources/model/model.dart';
import '../../utils/app_pref.dart';
import '../../utils/app_utils.dart';
import '../ui.dart';

class CreatePostController extends BaseController {
  Rx<File> avatar = File('').obs;
  RxList<File> photos = <File>[].obs;
  RxBool isSwitch = false.obs;
  TextEditingController plantNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Future<void> addPhotos() async {
    if (photos.length >= 3) {
      return AppUtils.toast('Số lượng ảnh tối đa là 3');
    }
    final dynamic _ = await Get.bottomSheet(const DialogUploadImage());
    if (_ != null) {
      photos.add(_ as File);
    }
  }

  Future<void> addFirstPhotos() async {
    final dynamic _ = await Get.bottomSheet(const DialogUploadImage());
    if (_ != null) {
      avatar.value = _ as File;
    }
  }

  Future<void> createPost() async {
    if (avatar.value.path == '') {
      return AppUtils.toast('Bạn chưa thêm ảnh đầu tiên');
    }
    final String? avatarUser = avatar.value.path == ''
        ? AppPrefs.user?.data?.avatar
        : await AppUtils.uploadFilesNetwork(avatar.value.path);
    setLoading(true);
    final NetworkState<PostStatus> networkState = await otherRepository.createPost({
      'avatarUser': avatarUser,
      'listImage': photos.isNotEmpty
          ? await Future.wait(
              photos
                  .map((File element) async => AppUtils.uploadFilesNetwork(element.path))
                  .toList(),
            )
          : [],
      'automaticRecognition': isSwitch.value,
      'name': plantNameController.text,
      'description': descriptionController.text,
      'tokenID': AppPrefs.user?.data?.tokenID,
    });

    setLoading(false);
    if (networkState.isSuccess && networkState.data != null) {
      if (networkState.data?.status == 0) {
        AppUtils.toast(networkState.data?.message ?? '');
        Get.back();
      }
    }
  }

  void removedPhoto(int index) {
    photos.removeAt(index);
  }
}
