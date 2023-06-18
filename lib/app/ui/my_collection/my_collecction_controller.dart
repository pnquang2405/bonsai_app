import '../../resources/resources.dart';
import '../ui.dart';

class MyCollectionController extends BaseController {
  RxList<BonsaiModel> favorites = <BonsaiModel>[].obs;
  RxBool loadingCmm = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    loadingCmm(true);
    await getMyCollection();
    loadingCmm(false);
  }

  Future<void> getMyCollection() async {
    final NetworkState<List<BonsaiModel>> networkState = await otherRepository.getMyCollection();
    if (networkState.isSuccess && networkState.data != null) {
      favorites.value = networkState.data!;
    }
  }

  void putDataHome(BonsaiModel model) {
    Get.find<HomeController>().bonsaiModel.value = model;
    Get.find<NavigationController>().changePage(2);
  }
}
