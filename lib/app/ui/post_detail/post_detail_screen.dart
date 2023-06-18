import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import '../../constants/constants.dart';
import '../../resources/model/model.dart';
import '../../utils/app_pref.dart';
import '../../utils/app_utils.dart';
import '../ui.dart';

class PostDetailScreen extends BaseScreen<PostDetailController> {
  PostDetailScreen({super.key});

  @override
  Widget? builder() {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: GetX<PostDetailController>(builder: (_) {
                return Column(
                  children: [
                    _buildAvatar(_.postModel?.listImage?.first ?? ''),
                    _buildBody(_),
                  ],
                );
              }),
            ),
          ),
          _buildTextField()
        ],
      ),
    );
  }

  Widget _buildBody(PostDetailController _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          if (_.postDetailModel.value.data?.postInfo != null) _buildInfo(_),
          ReadMoreText(
            '${_.postDetailModel.value.data?.postInfo?.describe ?? ''} ',
            trimLines: 2,
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' See more',
            trimExpandedText: ' See less',
            moreStyle: AppTextStyles.medium.copyWith(color: AppColors.textC4),
            lessStyle: AppTextStyles.medium.copyWith(color: AppColors.textC4),
          ),
          const SizedBox(height: 15),
          if (_.postDetailModel.value.data?.postInfo != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: WidgetLikeButton(model: _.postDetailModel.value.data!.postInfo!),
            ),
          const SizedBox(height: 15),
          if (_.postDetailModel.value.data?.comment?.isNotEmpty ?? false) _buildListComment(_)
        ],
      ),
    );
  }

  ListTile _buildInfo(PostDetailController _) {
    return ListTile(
      contentPadding: EdgeInsets.only(),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: ClipOval(
          child: Image.network(
            _.postDetailModel.value.data?.postInfo?.avatarUser ?? '',
            fit: BoxFit.fill,
            width: 35 * 2,
            height: 35 * 2,
          ),
        ),
      ),
      title: Text(
        _.postDetailModel.value.data?.postInfo?.nameUser ?? '',
        style: AppTextStyles.mediumBold.copyWith(color: AppColors.primary),
      ),
      subtitle: Text(
        AppUtils.timeAgo(_.postDetailModel.value.data?.postInfo?.timePost ?? 0),
        style: AppTextStyles.medium.copyWith(color: AppColors.textC4),
      ),
    );
  }

  Widget _buildListComment(PostDetailController _) {
    return Column(
      children: List.generate(_.postDetailModel.value.data?.comment?.length ?? 0, (int index) {
        final Comment? model = _.postDetailModel.value.data?.comment![index];
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.network(
                      AppPrefs.user?.data?.avatar ?? '',
                      width: 35,
                      height: 35,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model?.name ?? '',
                      style: AppTextStyles.mediumBold.copyWith(color: AppColors.primary),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      model?.message ?? '',
                      style: AppTextStyles.medium.copyWith(color: AppColors.textC4),
                    ),
                  ],
                ))
              ],
            ));
      }),
    );
  }

  Widget _buildAvatar(String avatar) {
    return Container(
      padding: EdgeInsets.only(
        top: Get.mediaQuery.viewPadding.top + 10,
      ),
      color: AppColors.backgroundMain,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Image.network(
              avatar,
              width: 180 * 2,
              height: 180 * 2,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return ValueListenableBuilder(
      valueListenable: controller.inputController,
      builder: (BuildContext context, TextEditingValue value, Widget? child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.network(
                    AppPrefs.user?.data?.avatar ?? '',
                    width: 35,
                    height: 35,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  enabled: true,
                  controller: controller.inputController,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter comment...',
                    hintStyle: AppTextStyles.small.copyWith(color: AppColors.textC4),
                    contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5, color: AppColors.textC4), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5, color: AppColors.textC4), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () => controller.postComment(),
                  child: Image.asset(
                    'assets/images/png/ic_send.png',
                    width: 23,
                    height: 23,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
