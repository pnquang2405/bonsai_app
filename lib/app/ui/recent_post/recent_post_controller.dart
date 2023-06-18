import 'package:get/get.dart';

import '../../resources/model/model.dart';
import '../ui.dart';

class RecentPostController extends BaseController {
  RxList<PostModel> recentPost = <PostModel>[].obs;
  RxBool loadingCmm = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadingCmm(true);
    await getRecentPost();
    loadingCmm(false);
  }

  Future<void> getRecentPost() async {
    final NetworkState<List<PostModel>> networkState = await otherRepository.getRecentPost();
    if (networkState.isSuccess && networkState.data != null) {
      recentPost.addAll(networkState.data!);
    }
  }
}
