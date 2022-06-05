import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabata/presentation/components/gestures/gesture_tap.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:tabata/utils/color_asset.dart';

class TabataControlSecondaryButton extends StatelessWidget {
  final String iconName;
  final VoidCallback onPressed;

  const TabataControlSecondaryButton({
    required this.iconName,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureTap(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorAsset.disabledTextFieldColor),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SvgPicture.asset(
            IconsAsset.named(iconName),
            color: ColorAsset.textColor,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
