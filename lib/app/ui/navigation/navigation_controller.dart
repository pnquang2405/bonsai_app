import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../resources/resources.dart';
import '../../utils/utils.dart';
import '../ui.dart';

class NavigationController extends BaseController {
  RxList<TestModel> raw = <TestModel>[].obs;
  final PageController pageController = PageController();
  RxInt count = 0.obs;
  final RxInt currentPage = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    // Timer.periodic(const Duration(seconds: 1), (Timer timer) {
    //   count.value++;
    //   count.refresh();
    // });
    // await fetchTestApi();
  }

  Future<void> fetchTestApi() async {
    final NetworkState<List<TestModel>> networkState = await AuthRepository().testApi();
    if (networkState.isSuccess) {
      raw.assignAll(networkState.data!.toList());
      raw.refresh();
    }
  }

  void changePage(int val) {
    if (val != currentPage.value) {
      currentPage.value = val;
    }
  }
}
