import 'package:flutter/material.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/font_asset.dart';

abstract class TextStyles {
  static titleWithSize({
    required double size,
    Color? color,
    FontWeight? weight,
  }) =>
      TextStyle(
        color: color ?? ColorAsset.textColor,
        fontSize: size,
        fontFamily: FontAsset.latoFamily,
        fontWeight: weight,
      );
}
