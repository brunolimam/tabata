import 'package:flutter/material.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/text_styles.dart';

class CloseTitleBar extends StatelessWidget {
  final String title;
  final VoidCallback closeCallback;

  const CloseTitleBar({
    required this.title,
    required this.closeCallback,
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
            left: 0,
            child: IconButton(
              onPressed: closeCallback,
              icon: const Icon(Icons.close),
              color: ColorAsset.iconColor,
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
