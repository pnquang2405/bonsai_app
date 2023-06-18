import 'package:flutter/material.dart';
import '../extensions/extensions.dart';
import '../utils/app_utils.dart';

class AppColors {
  AppColors._();

  static Color get primary => AppUtils.valueByMode(values: <Color>[primaryLight, primaryLight]);

  static Color get primaryDark => HexColor.fromHex('#FF095A44');

  static Color get primaryLight => HexColor.fromHex('#1EAE86');

  static Color get text => AppUtils.valueByMode(values: <Color>[textLight, textLight]);

  static Color get textDark => Colors.white;

  static Color get bezierCurves => HexColor.fromHex('#1eae86');
  static Color get textC4 => HexColor.fromHex('#C4C4C4');

  static Color get textA6 => HexColor.fromHex('#A6A6A6');

  static Color get textA8 => HexColor.fromHex('#B4A8A8');

  static Color get darkBlue => HexColor.fromHex('#095A44');

  static Color get green => HexColor.fromHex('#1EAE86');

  static Color get backgroundMain => textC4.withOpacity(0.1);

  static Color get textLight => Colors.black;
}
