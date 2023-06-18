import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import '../../resources/resources.dart';
import '../../utils/app_pref.dart';
import '../../utils/app_utils.dart';
import '../ui.dart';

class HomeController extends BaseController {
  Rx<BonsaiModel> bonsaiModel = BonsaiModel().obs;
  RxBool isShowCamera = true.obs;
  RxBool isLiked = false.obs;
  final RxInt currentStory = 0.obs;
  final PageController pageController = PageController();
  @override
  Future<void> onInit() async {
    super.onInit();
    // muốn lưu lại data home thì mở ra
    // if (AppPrefs.dataStory != null) {
    //   bonsaiModel.value = AppPrefs.dataStory!;
    // }
  }

  Future<void> onPost(String value) async {
    setLoading(true);
    final String image = await AppUtils.uploadFilesNetwork(value);
    await viewInfoBonsai(image);
    isShowCamera.value = false;
    setLoading(false);
  }

  Future<void> viewInfoBonsai(String imageScan) async {
    final NetworkState<BonsaiModel> networkState = await otherRepository.getViewInfoBonsai(
      idToken: AppPrefs.user?.data?.tokenID,
      imageScan: imageScan,
    );
    if (networkState.isSuccess && networkState.data != null) {
      bonsaiModel.value = networkState.data!;
      AppPrefs.dataStory = networkState.data;
    }
  }

  Future<void> likePost() async {
    final NetworkState<LikeModel> networkState = await otherRepository.likeCollection(
      isLike: bonsaiModel.value.isLike,
      idPost: bonsaiModel.value.idBonsai,
    );
    if (networkState.isSuccess && networkState.data != null) {
      AppPrefs.dataStory = bonsaiModel.value;
      Get.find<MyCollectionController>().getMyCollection();
    }
  }
}
