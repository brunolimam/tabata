import 'package:flutter/material.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/text_styles.dart';

class TitleBar extends StatelessWidget {
  final String title;

  const TitleBar({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 44),
      Center(
        child: Text(
          title,
          style: TextStyles.titleWithSize(
            size: 18,
            weight: FontWeight.w700,
          ),
        ),
      ),
      const SizedBox(height: 16),
      Divider(
        color: ColorAsset.dividerColor,
        height: 4,
      ),
    ]);
  }
}
