import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/text_styles.dart';

class WorkoutItemHeader extends StatelessWidget {
  final String title;
  final String iconName;
  final String value;

  const WorkoutItemHeader({
    required this.title,
    required this.iconName,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyles.titleWithSize(
              size: 12,
              weight: FontWeight.w600,
              color: ColorAsset.tabataItemHeader),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            SvgPicture.asset(
              IconsAsset.named(iconName),
              color: ColorAsset.textColor,
            ),
            const SizedBox(width: 8),
            Text(
              value,
              style: TextStyles.titleWithSize(
                size: 18,
                weight: FontWeight.w700,
              ),
            ),
          ],
        )
      ],
    );
  }
}
