import 'package:dio/dio.dart';
import '../../constants/constants.dart';
import '../../utils/app_clients.dart';
import '../../utils/app_pref.dart';
import '../resources.dart';

class OtherRepository {
  factory OtherRepository() {
    _instance ??= OtherRepository._();
    return _instance!;
  }
  OtherRepository._();

  static OtherRepository? _instance;

  Future<NetworkState<BonsaiModel>> getViewInfoBonsai({String? imageScan, String? idToken}) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<BonsaiModel>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.viewInfoBonsai;
      final Map<String, dynamic> params = {
        'imageScan': imageScan,
        'tokenID': idToken,
      };
      final Response<dynamic> response = await AppClients().post(api, data: params);
      return NetworkState<BonsaiModel>(
        status: AppEndpoint.SUCCESS,
        data: BonsaiModel.fromJson(response.data['data']),
      );
    } on DioError catch (e) {
      return NetworkState<BonsaiModel>.withError(e);
    }
  }

  Future<NetworkState<LikeModel>> likePost({bool? isLike, String? idToken, int? idPost}) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<LikeModel>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.likePost;
      final Map<String, dynamic> params = {
        'isLike': isLike,
        'tokenID': idToken,
        'idPost': idPost,
      };
      final Response<dynamic> response = await AppClients().post(api, data: params);
      return NetworkState<LikeModel>(
        status: AppEndpoint.SUCCESS,
        data: LikeModel.fromJson(response.data),
      );
    } on DioError catch (e) {
      return NetworkState<LikeModel>.withError(e);
    }
  }

  Future<NetworkState<LikeModel>> likeCollection({
    bool? isLike,
    int? idPost,
  }) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<LikeModel>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.likeCollection;
      final Map<String, dynamic> params = {
        'isLike': isLike,
        'tokenID': AppPrefs.user?.data?.tokenID,
        'idPost': idPost,
      };
      final Response<dynamic> response = await AppClients().post(api, data: params);
      return NetworkState<LikeModel>(
        status: AppEndpoint.SUCCESS,
        data: LikeModel.fromJson(response.data),
      );
    } on DioError catch (e) {
      return NetworkState<LikeModel>.withError(e);
    }
  }

  Future<NetworkState<List<PostModel>>> getListCommunity() async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<List<PostModel>>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.getCommunity;
      final Map<String, dynamic> params = {
        'tokenID': AppPrefs.user?.data?.tokenID,
      };
      final Response<dynamic> response = await AppClients().post(api, data: params);
      return NetworkState<List<PostModel>>(
        status: AppEndpoint.SUCCESS,
        data: ((response.data['data']['listPost']) as List)
            .map((dynamic e) => PostModel.fromJson(e))
            .toList(),
      );
    } on DioError catch (e) {
      return NetworkState<List<PostModel>>.withError(e);
    }
  }

  Future<NetworkState<List<PostModel>>> getRecentPost() async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<List<PostModel>>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.getRecentPost;
      final Map<String, dynamic> params = {
        'tokenID': AppPrefs.user?.data?.tokenID,
      };
      final Response<dynamic> response = await AppClients().post(api, data: params);
      return NetworkState<List<PostModel>>(
        status: AppEndpoint.SUCCESS,
        data: ((response.data['data']['listPost']) as List)
            .map((dynamic e) => PostModel.fromJson(e))
            .toList(),
      );
    } on DioError catch (e) {
      return NetworkState<List<PostModel>>.withError(e);
    }
  }

  Future<NetworkState<List<BonsaiModel>>> getMyCollection() async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<List<BonsaiModel>>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.getMyCollection;
      final Map<String, dynamic> params = {
        'tokenID': AppPrefs.user?.data?.tokenID,
      };
      final Response<dynamic> response = await AppClients().post(api, data: params);
      return NetworkState<List<BonsaiModel>>(
        status: AppEndpoint.SUCCESS,
        data: ((response.data['data']['listFavorites']) as List)
            .map((dynamic e) => BonsaiModel.fromJson(e))
            .toList(),
      );
    } on DioError catch (e) {
      return NetworkState<List<BonsaiModel>>.withError(e);
    }
  }

  Future<NetworkState<List<BonsaiModel>>> getSearchBonsai({String? searchText}) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<List<BonsaiModel>>.withDisconnect();
    }
    try {
      final Map<String, dynamic> params = {
        'tokenID': AppPrefs.user?.data?.tokenID,
        'searchText': searchText
      };
      const String api = AppEndpoint.searchBonsai;
      final Response<dynamic> response = await AppClients().post(api, data: params);
      return NetworkState<List<BonsaiModel>>(
        status: AppEndpoint.SUCCESS,
        data: ((response.data['data']['searchResults']) as List)
            .map((dynamic e) => BonsaiModel.fromJson(e))
            .toList(),
      );
    } on DioError catch (e) {
      return NetworkState<List<BonsaiModel>>.withError(e);
    }
  }

  Future<NetworkState<PostStatus>> createPost(Map<String, dynamic> map) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<PostStatus>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.createPost;
      final Response<dynamic> response = await AppClients().post(api, data: map);
      return NetworkState<PostStatus>(
        status: AppEndpoint.SUCCESS,
        data: PostStatus.fromJson(response.data),
      );
    } on DioError catch (e) {
      return NetworkState<PostStatus>.withError(e);
    }
  }

  Future<NetworkState<PostDetailModel>> viewPostDetail(Map<String, dynamic> map) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<PostDetailModel>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.viewDetailPost;
      final Response<dynamic> response = await AppClients().post(api, data: map);
      return NetworkState<PostDetailModel>(
        status: AppEndpoint.SUCCESS,
        data: PostDetailModel.fromJson(response.data),
      );
    } on DioError catch (e) {
      return NetworkState<PostDetailModel>.withError(e);
    }
  }

  Future<NetworkState<LikeModel>> sendCommentToPost(
      {String? idToken, int? idPost, String? content}) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<LikeModel>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.sendCommentToPost;
      final Map<String, dynamic> params = {
        'idToken': idToken,
        'idPost': idPost,
        'content': content
      };
      final Response<dynamic> response = await AppClients().post(api, data: params);
      return NetworkState<LikeModel>(
        status: AppEndpoint.SUCCESS,
        data: LikeModel.fromJson(response.data),
      );
    } on DioError catch (e) {
      return NetworkState<LikeModel>.withError(e);
    }
  }
}
