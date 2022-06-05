import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/text_styles.dart';

class TabataItemHeader extends StatelessWidget {
  final String iconName;
  final String title;
  final String value;

  const TabataItemHeader({
    required this.iconName,
    required this.title,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              iconName,
              color: ColorAsset.tabataItemHeader,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyles.titleWithSize(
                size: 12,
                weight: FontWeight.w600,
                color: ColorAsset.tabataItemHeader,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyles.titleWithSize(
            size: 20,
            weight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
