import 'package:flutter/cupertino.dart';
import '../../resources/resources.dart';
import '../ui.dart';

class SearchMainController extends BaseController {
  final TextEditingController searchController = TextEditingController();
  RxList<BonsaiModel> searchData = <BonsaiModel>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  void removeTextField() {
    // changeScreenType(false);
    searchController.clear();
  }

  void onSubmit(String value) {
    getMyCollection();
  }

  void putDataHome(BonsaiModel model) {
    Get.find<HomeController>().bonsaiModel.value = model;
    Get.find<NavigationController>().changePage(2);
  }

  Future<void> getMyCollection() async {
    final NetworkState<List<BonsaiModel>> networkState = await otherRepository.getSearchBonsai(
      searchText: searchController.text,
    );
    if (networkState.isSuccess && networkState.data != null) {
      searchData.clear();
      searchData.addAll(networkState.data!);
    }
  }
}
