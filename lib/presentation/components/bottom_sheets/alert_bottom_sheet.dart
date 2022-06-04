import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabata/presentation/components/buttons/primary_button.dart';
import 'package:tabata/presentation/components/buttons/secondary_button.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/dimens.dart';
import 'package:tabata/utils/text_styles.dart';

class AlertBottomSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final String mainButtonTitle;
  final String secondaryButtonTitle;
  final VoidCallback confirmation;

  const AlertBottomSheet({
    required this.title,
    required this.subtitle,
    required this.mainButtonTitle,
    required this.secondaryButtonTitle,
    required this.confirmation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ColorAsset.mainBackground,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.largeHorizontal),
        child: Column(
          children: [
            const SizedBox(height: 34),
            SvgPicture.asset(ImagesAsset.named("warning")),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyles.titleWithSize(
                size: 20,
                weight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              subtitle,
              style: TextStyles.titleWithSize(size: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              title: mainButtonTitle,
              onPressed: confirmation,
            ),
            const SizedBox(height: 20),
            SecondaryButton(
              title: secondaryButtonTitle,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
