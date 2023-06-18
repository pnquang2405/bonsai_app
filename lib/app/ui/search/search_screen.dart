import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../resources/model/model.dart';
import '../ui.dart';

class SearchScreen extends BaseScreen<SearchMainController> {
  SearchScreen({super.key});

  @override
  Widget? builder() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundMain,
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          Expanded(child: _buildBody()),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Text(
            'Search',
            style: AppTextStyles.supperLargeBold.copyWith(
              fontSize: 25,
              color: AppColors.primaryDark,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: WidgetSearchClear(
              controller: controller.searchController,
              hint: "Start typing plant's name",
              onSubmit: controller.onSubmit,
              onCancel: controller.removeTextField,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return GetX<SearchMainController>(
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: List.generate(
              _.searchData.length,
              (index) {
                final BonsaiModel model = _.searchData[index];
                return GestureDetector(
                  onTap: () {
                    controller.putDataHome(model);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0.1, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.network(
                          model.listImage?.first ?? '',
                          width: 65,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        model.name ?? '',
                        style: AppTextStyles.mediumBold.copyWith(color: AppColors.primary),
                      ),
                      subtitle: Text(
                        model.title ?? '',
                        style: AppTextStyles.medium,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
