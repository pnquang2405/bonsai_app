import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart' as camera;

double get viewPaddingTop => Get.mediaQuery.viewPadding.top;

const String APP_NAME = 'BONSAI SCAN';

final ValueNotifier<List<camera.CameraDescription>?> cameras = ValueNotifier([]);

/// FLAVOR = dev => development
/// FLAVOR = prod => product
const String FLAVOR = String.fromEnvironment('FLAVOR');

enum AppLocale {
  vi(Locale('vi', 'VN')),
  en(Locale('en', 'US')),
  ja(Locale('ja', 'JP'));

  const AppLocale(this._locale);
  final Locale _locale;
  Locale get value => _locale;
}
