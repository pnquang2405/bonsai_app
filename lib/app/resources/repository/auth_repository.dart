import 'package:dio/dio.dart';
import '../../constants/constants.dart';
import '../../utils/app_clients.dart';
import '../../utils/app_pref.dart';
import '../resources.dart';

class AuthRepository {
  factory AuthRepository() {
    _instance ??= AuthRepository._();
    return _instance!;
  }
  AuthRepository._();

  static AuthRepository? _instance;

// /Example
  Future<NetworkState<List<TestModel>>> testApi() async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<List<TestModel>>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.TEST_API;
      // Map<String, dynamic> params = {
      //   "os": Platform.isAndroid ? "android" : "ios"
      // };
      final Response<List<dynamic>> response = await AppClients().get(api);
      return NetworkState<List<TestModel>>(
        status: AppEndpoint.SUCCESS,
        data: response.data
            ?.map((dynamic e) => TestModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on DioError catch (e) {
      return NetworkState<List<TestModel>>.withError(e);
    }
  }

  Future<NetworkState<UserModel>> signIn({String? email, String? password}) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<UserModel>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.login;
      final Map<String, dynamic> params = {
        'email': email,
        'password': password,
      };
      final Response<dynamic> response = await AppClients().post(api, data: params);
      return NetworkState<UserModel>(
        status: AppEndpoint.SUCCESS,
        data: UserModel.fromJson(response.data as Map<String, dynamic>),
      );
    } on DioError catch (e) {
      return NetworkState<UserModel>.withError(e);
    }
  }

  Future<NetworkState<UserModel>> signUp({String? email, String? password}) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<UserModel>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.register;
      final Map<String, dynamic> params = {
        'email': email,
        'password': password,
      };
      final Response<dynamic> response = await AppClients().post(api, data: params);
      return NetworkState<UserModel>(
          status: AppEndpoint.SUCCESS, data: UserModel.fromJson(response.data));
    } on DioError catch (e) {
      return NetworkState<UserModel>.withError(e);
    }
  }

  Future<NetworkState<UserModel>> signOut() async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<UserModel>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.logout;
      final Map<String, dynamic> params = {
        'tokenID': AppPrefs.user?.data?.tokenID,
        'userId': AppPrefs.user?.data?.userId,
      };
      final Response<dynamic> response = await AppClients().post(api, data: params);
      return NetworkState<UserModel>(
          status: AppEndpoint.SUCCESS, data: UserModel.fromJson(response.data));
    } on DioError catch (e) {
      return NetworkState<UserModel>.withError(e);
    }
  }

  Future<NetworkState<UserModel>> getMyInfo({String? tokenId}) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<UserModel>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.getMyInfomation;
      final Map<String, dynamic> params = {
        'tokenID': tokenId,
      };
      final Response<dynamic> response = await AppClients().post(api, data: params);
      return NetworkState<UserModel>(
          status: AppEndpoint.SUCCESS, data: UserModel.fromJson(response.data));
    } on DioError catch (e) {
      return NetworkState<UserModel>.withError(e);
    }
  }

  Future<NetworkState<UserModel>> editProfile({
    String? tokenID,
    String? name,
    String? email,
  }) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<UserModel>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.editProfile;
      final Map<String, dynamic> params = {
        'tokenID': tokenID,
        'name': name,
        'email': email,
      };
      final Response<dynamic> response = await AppClients().post(api, data: params);
      return NetworkState<UserModel>(
          status: AppEndpoint.SUCCESS, data: UserModel.fromJson(response.data));
    } on DioError catch (e) {
      return NetworkState<UserModel>.withError(e);
    }
  }

  Future<NetworkState<UserModel>> changePassword({
    String? tokenID,
    String? password,
    String? oldPassword,
  }) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<UserModel>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.changePassword;
      final Map<String, dynamic> params = {
        'tokenID': tokenID,
        'password': password,
        'oldPassword': oldPassword
      };
      final Response<dynamic> response = await AppClients().post(api, data: params);
      return NetworkState<UserModel>(
          status: AppEndpoint.SUCCESS, data: UserModel.fromJson(response.data));
    } on DioError catch (e) {
      return NetworkState<UserModel>.withError(e);
    }
  }

  Future<NetworkState<UserModel>> forgotPassword({
    String? tokenID,
    String? email,
  }) async {
    final bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) {
      return NetworkState<UserModel>.withDisconnect();
    }
    try {
      const String api = AppEndpoint.forgotPassword;
      final Map<String, dynamic> params = {
        'tokenID': tokenID,
        'email': email,
      };
      final Response<dynamic> response = await AppClients().post(api, data: params);
      return NetworkState<UserModel>(
          status: AppEndpoint.SUCCESS, data: UserModel.fromJson(response.data));
    } on DioError catch (e) {
      return NetworkState<UserModel>.withError(e);
    }
  }
}
