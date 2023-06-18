// ignore_for_file: depend_on_referenced_packages
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path/path.dart';
import 'package:timeago/timeago.dart';
import '../constants/constants.dart';
import 'utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class AppUtils {
  AppUtils._();

  static void toast(String? message, {Duration? duration}) {
    if (message != null) {
      showOverlayNotification((BuildContext context) {
        return SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primary,
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.normalBold.copyWith(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        );
      }, duration: duration ?? const Duration(milliseconds: 2000));
    }
  }

  static const List<String> _themes = <String>['dark', 'light'];

  static T valueByMode<T>({List<String> themes = _themes, required List<T> values}) {
    try {
      for (int i = 0; i < themes.length; i++) {
        if (AppPrefs.appMode == themes[i]) {
          if (i < values.length)
            return values[i];
          else
            values.first;
        }
      }
      return values.first;
    } catch (e) {
      return values.first;
    }
  }

  static String pathMediaToUrl(String? url) {
    if (url == null || url.startsWith('http')) {
      return url ?? '';
    }
    return "${"AppEndpoint.BASE_UPLOAD_URL"}$url";
  }

  static String convertDateTime2String(DateTime? dateTime, {String format = 'yy-MM-dd'}) {
    if (dateTime == null) {
      return '';
    }
    return DateFormat(format).format(dateTime);
  }

  static String convertInt2DateTime(int? sinceEpoch, {String format = 'dd/MM/yy'}) {
    if (sinceEpoch == null) {
      return '';
    }
    DateTime? dateTime = DateTime.fromMillisecondsSinceEpoch(sinceEpoch);
    return DateFormat(format).format(dateTime);
  }

  static DateTime? convertString2DateTime(String? dateTime,
      {String format = 'yyyy-MM-ddTHH:mm:ss.SSSZ'}) {
    if (dateTime == null) {
      return null;
    }
    return DateFormat(format).parse(dateTime);
  }

  static String convertString2String(String? dateTime,
      {String inputFormat = 'yyyy-MM-ddTHH:mm:ss.SSSZ', String outputFormat = 'yyyy-MM-dd'}) {
    if (dateTime == null) {
      return '';
    }
    final DateTime? input = convertString2DateTime(dateTime, format: inputFormat);
    return convertDateTime2String(input, format: outputFormat);
  }

  static String minimum(int? value) {
    if (value == null) {
      return '00';
    }
    return value < 10 ? '0$value' : '$value';
  }

  static String convertPhoneNumber(String phone, {String code = '+84'}) {
    return '$code${phone.substring(1)}';
  }

  static Future<String> uploadFilesNetwork(String path) async {
    String imageUrl = '';
    try {
      UploadTask uploadTask;
      final String nameExtension = 'bonsai${basenameWithoutExtension(File(path).path)}';
      final Reference ref =
          FirebaseStorage.instance.ref().child('product').child('/$nameExtension');
      uploadTask = ref.putFile(File(path));
      // uploadTask = ref.putData(pickedImagesInBytes[i], metadata);
      // await MultipartFile.fromFile(avatar)
      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print(e);
    }
    return imageUrl;
  }

  static bool isContains(String a, String b) {
    return AppASCIIParse.parse((a).toUpperCase()).contains(AppASCIIParse.parse((b).toUpperCase()));
  }

  static String timeAgo(int millisecond) {
    final time = DateTime.fromMillisecondsSinceEpoch(millisecond, isUtc: true);
    timeago.setLocaleMessages('en_US', EnMessages());
    String timeValues = timeago.format(time, locale: 'en_US');
    return timeValues;
  }
}
