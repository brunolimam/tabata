import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabata/presentation/components/gestures/gesture_tap.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/text_styles.dart';

class CloseItemBar extends StatelessWidget {
  final String title;
  final String iconItemName;
  final VoidCallback closeCallback;
  final VoidCallback onItemPressed;

  const CloseItemBar({
    required this.title,
    required this.iconItemName,
    required this.closeCallback,
    required this.onItemPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 44),
      Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              title,
              style: TextStyles.titleWithSize(
                size: 18,
                weight: FontWeight.w700,
              ),
            ),
          ),
          Positioned(
            left: 2,
            child: IconButton(
              onPressed: closeCallback,
              icon: const Icon(Icons.close),
              color: ColorAsset.iconColor,
            ),
          ),
          Positioned(
            right: 18,
            child: GestureTap(
              onPressed: onItemPressed,
              child: SvgPicture.asset(IconsAsset.named(iconItemName)),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      Divider(
        color: ColorAsset.dividerColor,
        height: 4,
      ),
    ]);
  }
}
