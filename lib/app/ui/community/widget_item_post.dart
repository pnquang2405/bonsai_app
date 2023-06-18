import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../constants/constants.dart';
import '../../extensions/extensions.dart';
import '../../resources/model/model.dart';
import '../../resources/repository/other_repository.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_utils.dart';
import '../../utils/utils.dart';
import '../ui.dart';

class WidgetItemPost extends StatefulWidget {
  const WidgetItemPost({super.key, required this.model});
  final PostModel model;
  @override
  State<WidgetItemPost> createState() => _WidgetItemPostState();
}

class _WidgetItemPostState extends State<WidgetItemPost> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.POST_DETAIL, arguments: widget.model);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(),
              minVerticalPadding: 0.0,
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.network(
                    widget.model.avatarUser ?? '',
                    fit: BoxFit.fill,
                    width: 35 * 2,
                    height: 35 * 2,
                  ),
                ),
              ),
              title: Text(
                widget.model.nameUser ?? '',
                style: AppTextStyles.mediumBold.copyWith(color: AppColors.primary),
              ),
              subtitle: Text(
                AppUtils.timeAgo(widget.model.timePost ?? 0),
                style: AppTextStyles.medium.copyWith(color: AppColors.textC4),
              ),
            ),
            ReadMoreText(
              '${widget.model.describe} ',
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              trimCollapsedText: '  See more',
              trimExpandedText: ' See less',
              moreStyle: AppTextStyles.medium.copyWith(color: AppColors.textC4),
              lessStyle: AppTextStyles.medium.copyWith(color: AppColors.textC4),
            ),
            const SizedBox(height: 10),
            Image.network(
              widget.model.listImage?.first ?? '',
              width: Get.width,
              height: Get.width,
            ),
            const SizedBox(height: 15),
            WidgetLikeButton(model: widget.model)
          ],
        ),
      ),
    );
  }
}

class WidgetLikeButton extends StatefulWidget {
  const WidgetLikeButton({Key? key, required this.model}) : super(key: key);
  final PostModel model;

  @override
  State<WidgetLikeButton> createState() => _WidgetLikeButtonState();
}

class _WidgetLikeButtonState extends State<WidgetLikeButton> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLiked = widget.model.isLike ?? false;
    });
  }

  Future<void> likePost() async {
    final NetworkState<LikeModel> networkState = await OtherRepository().likePost(
        idToken: AppPrefs.user?.data?.tokenID, isLike: isLiked, idPost: widget.model.postId);
    if (networkState.isSuccess && networkState.data != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildLiked(widget.model)),
        const SizedBox(width: 30),
        Expanded(
          child: _buildComment(widget.model),
        )
      ],
    );
  }

  Column _buildComment(PostModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            "${model.numComment ?? ''} comment",
            style: AppTextStyles.medium.copyWith(
              color: AppColors.textC4,
            ),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.POST_DETAIL, arguments: widget.model);
          },
          child: Container(
            width: 160,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(color: AppColors.primary, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/png/ic_comment_cmm.png',
                  width: 18,
                  height: 18,
                ),
                const SizedBox(width: 10),
                Text(
                  'Comment',
                  style: AppTextStyles.mediumBold.copyWith(color: AppColors.primary),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLiked(PostModel model) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLiked = !isLiked;
        });
        likePost();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "${model.numLike ?? ''} like",
              style: AppTextStyles.medium.copyWith(
                color: AppColors.textC4,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 160,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            decoration: BoxDecoration(
              color: isLiked ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primary, width: 1.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/png/ic_like_cmm.png',
                  width: 18,
                  height: 18,
                ),
                const SizedBox(width: 10),
                Text(
                  isLiked ? 'Liked' : 'Like',
                  style: AppTextStyles.mediumBold.copyWith(
                    color: isLiked ? Colors.white : AppColors.primary,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
