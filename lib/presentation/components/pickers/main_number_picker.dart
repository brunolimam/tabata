import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/text_styles.dart';

class MainAppPicker extends StatelessWidget {
  final String title;
  final int minValue;
  final int maxValue;
  final int value;
  final Function(int) onChanged;

  const MainAppPicker({
    required this.title,
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BorderSide divider = BorderSide(
      width: 2,
      color: ColorAsset.mainColor,
    );

    return Column(children: [
      Text(
        title,
        style: TextStyles.titleWithSize(
          size: 12,
          weight: FontWeight.w500,
          color: ColorAsset.secondaryTextColor,
        ),
      ),
      NumberPicker(
        itemWidth: 42,
        minValue: minValue,
        maxValue: maxValue,
        value: value,
        textStyle: TextStyles.titleWithSize(
          size: 24,
          weight: FontWeight.w700,
          color: ColorAsset.disabledTextFieldColor,
        ),
        selectedTextStyle: TextStyles.titleWithSize(
          size: 24,
          weight: FontWeight.w700,
          color: ColorAsset.textColor,
        ),
        infiniteLoop: true,
        decoration: BoxDecoration(
          border: Border(
            top: divider,
            bottom: divider,
          ),
        ),
        onChanged: onChanged,
      )
    ]);
  }
}
