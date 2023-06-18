import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../resources/model/model.dart';
import '../../routes/app_pages.dart';
import '../ui.dart';

class RecentPostScreen extends BaseScreen<RecentPostController> {
  RecentPostScreen({super.key});

  @override
  Widget? builder() {
    return Scaffold(
      backgroundColor: AppColors.textC4,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: _buildList(),
        )
      ],
    );
  }

  Widget _buildList() {
    return GetX<RecentPostController>(
      builder: (_) {
        if (_.loadingCmm.value) {
          return Center(child: CircularProgressIndicator(color: AppColors.primary));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          child: Column(
            children: List.generate(
              _.recentPost.length,
              (int index) {
                final PostModel model = _.recentPost[index];
                return WidgetItemPost(model: model);
              },
            ),
          ),
        );
      },
    );
  }

  Container _buildHeader() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 4,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ]),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
              size: 20,
            ),
          ),
          Text(
            'Recent posts',
            style: AppTextStyles.supperLargeBold.copyWith(
              fontSize: 25,
              color: AppColors.primaryDark,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.CREATE_POST);
            },
            child: Image.asset(
              'assets/images/png/ic_create.png',
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
