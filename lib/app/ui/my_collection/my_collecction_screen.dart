import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../resources/model/model.dart';
import '../../utils/app_utils.dart';
import '../ui.dart';

class MyCollectionScreen extends BaseScreen<MyCollectionController> {
  @override
  Widget? builder() {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 15),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return GetX<MyCollectionController>(builder: (_) {
      return Wrap(
        children: List.generate(
          _.favorites.length,
          (int index) {
            final BonsaiModel model = _.favorites[index];
            return GestureDetector(
              onTap: () {
                controller.putDataHome(model);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                width: (Get.width / 2) - 25,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      model.name ?? '',
                      style: AppTextStyles.normalBold.copyWith(
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Image.network(
                      model.listImage?.first ?? '',
                      width: Get.width,
                      height: 220.h,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppUtils.convertInt2DateTime(model.dateTime ?? 0),
                      style: AppTextStyles.mediumBold.copyWith(
                        color: AppColors.textC4,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
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
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 10,
        top: Get.mediaQuery.viewPadding.top + 10,
      ),
      child: Text(
        'My Collection',
        style: AppTextStyles.supperLargeBold.copyWith(
          fontSize: 25,
          color: AppColors.primaryDark,
        ),
      ),
    );
  }
}
