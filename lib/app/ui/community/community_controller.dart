import 'package:get/get.dart';

import '../../resources/model/model.dart';
import '../ui.dart';

class CommunityController extends BaseController {
  RxList<PostModel> community = <PostModel>[].obs;
  RxBool loadingCmm = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadingCmm(true);
    await getListCommunity();
    loadingCmm(false);
  }

  Future<void> getListCommunity() async {
    final NetworkState<List<PostModel>> networkState = await otherRepository.getListCommunity();
    if (networkState.isSuccess && networkState.data != null) {
      community.addAll(networkState.data!);
    }
  }
}
