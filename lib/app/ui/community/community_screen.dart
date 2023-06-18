import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../resources/model/model.dart';
import '../../routes/app_pages.dart';
import '../ui.dart';

class CommunityScreen extends BaseScreen<HomeController> {
  CommunityScreen({super.key});

  @override
  Widget? builder() {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
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

  GetX<CommunityController> _buildList() {
    return GetX<CommunityController>(
      builder: (_) {
        if (_.loadingCmm.value) {
          return Center(child: CircularProgressIndicator(color: AppColors.primary));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          child: Column(
            children: List.generate(
              _.community.length,
              (int index) {
                final PostModel model = _.community[index];
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
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 10,
        top: Get.mediaQuery.viewPadding.top + 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/png/ic_bell.png',
            width: 50,
            height: 50,
          ),
          Text(
            "Community",
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
