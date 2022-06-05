import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/text_styles.dart';

class WorkoutDetailItem extends StatelessWidget {
  final String iconName;
  final String title;
  final String value;
  final Color valueColor;

  const WorkoutDetailItem({
    required this.iconName,
    required this.title,
    required this.value,
    required this.valueColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ColorAsset.secondaryBackground,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            SvgPicture.asset(
              IconsAsset.named(iconName),
              color: ColorAsset.secondaryColor,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyles.titleWithSize(
                size: 16,
                color: ColorAsset.secondaryTextColor,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyles.titleWithSize(
                size: 18,
                weight: FontWeight.w700,
                color: valueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
