import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../resources/model/model.dart';
import '../../utils/app_pref.dart';
import '../../utils/app_utils.dart';
import '../ui.dart';

class PostDetailController extends BaseController {
  Rx<PostDetailModel> postDetailModel = PostDetailModel().obs;
  TextEditingController inputController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  PostModel? postModel;
  @override
  void onInit() {
    super.onInit();
    postModel = Get.arguments as PostModel;
    postDetailModel.value.data?.postInfo = postModel;
    getDetailPost();
  }

  Future<void> getDetailPost() async {
    final NetworkState<PostDetailModel> networkState = await otherRepository.viewPostDetail({
      'tokenId': AppPrefs.user?.data?.tokenID,
      'postId': postModel?.postId,
    });
    if (networkState.isSuccess && networkState.data != null) {
      postDetailModel.value = networkState.data!;
    }
  }

  Future<void> postComment() async {
    if (inputController.text.isEmpty) {
      return AppUtils.toast("Bạn chưa nhập bình luận");
    }
    final NetworkState<LikeModel> networkState = await otherRepository.sendCommentToPost(
        idToken: AppPrefs.user?.data?.tokenID,
        idPost: postModel?.postId,
        content: inputController.text
        // postId: postModel?.postId,
        );
    if (networkState.isSuccess && networkState.data != null) {
      if (networkState.data?.status == 0) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
        postDetailModel.value.data?.comment?.add(Comment(
          message: inputController.text,
          timeComment: DateTime.now().millisecondsSinceEpoch,
          avatar: AppPrefs.user?.data?.avatar ?? '',
          name: AppPrefs.user?.data?.name,
          userId: AppPrefs.user!.data!.userId!,
        ));
        postDetailModel.refresh();
        inputController.clear();
        AppUtils.toast(networkState.data?.message ?? '');
      }
    }
  }

  void onSubmit(String value) {}
}
