// ignore_for_file: always_specify_types, strict_raw_type

import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/resources.dart';

class AppPrefs {
  AppPrefs._();

  static final GetStorage _box = GetStorage('AppPref');

  static final BehaviorSubject<dynamic> _userBehavior = BehaviorSubject<dynamic>();

  static Future<void> initListener() async {
    await GetStorage.init('AppPref');
    _box.listenKey('user', (user) {
      _userBehavior.add(user);
    });
  }

  static set appMode(String? data) => _box.write('appMode', data);

  static String? get appMode => _box.read('appMode');

  static set accessToken(String? data) => _box.write('accessToken', data);

  static String? get accessToken => _box.read('accessToken');

  static set user(UserModel? user) {
    if (user != null) {
      _box.write('user', jsonEncode(user.toJson()));
    } else {
      _box.remove('user');
    }
  }

  static UserModel? get user {
    final _ = _box.read('user');
    if (_ != null) {
      return UserModel.fromJson(jsonDecode(_ as String));
    }
    return null;
  }

  static set isLiked(bool? like) {
    if (user != null) {
      _box.write('isLiked', jsonEncode(like));
    } else {
      _box.remove('isLiked');
    }
  }

  static bool? get isLiked {
    final _ = _box.read('isLiked');
    if (_ != null) {
      return jsonDecode(_ as String) as bool;
    }
    return null;
  }

  static set dataStory(BonsaiModel? model) {
    if (user != null) {
      _box.write('dataStory', jsonEncode(model));
    } else {
      _box.remove('dataStory');
    }
  }

  static BonsaiModel? get dataStory {
    final _ = _box.read('dataStory');
    if (_ != null) {
      return BonsaiModel.fromJson(jsonDecode(_ as String));
    }
    return null;
  }

  // static set user(Apps? _user) {
  //   _box.write('user', _user);
  // }
  //
  // static Apps? get user {
  //   final _ = _box.read('user');
  //   if (_ == null) return null;
  //   return _ is Apps ? _ : Apps.fromJson(_box.read('user'));
  // }

  static Stream get watchUser => _userBehavior.stream;
}
