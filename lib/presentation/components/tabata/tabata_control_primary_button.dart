import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabata/presentation/components/gestures/gesture_tap.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:tabata/utils/color_asset.dart';

class TabataControlPrimaryButton extends StatelessWidget {
  final String iconName;
  final VoidCallback onPressed;

  const TabataControlPrimaryButton({
    required this.iconName,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureTap(
      onPressed: onPressed,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(500.0)),
        child: ColoredBox(
          color: ColorAsset.textColor,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SvgPicture.asset(
              IconsAsset.named(iconName),
              color: ColorAsset.blackDivider,
              height: 40,
              width: 40,
            ),
          ),
        ),
      ),
    );
  }
}
