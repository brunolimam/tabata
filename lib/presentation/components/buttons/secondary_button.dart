import 'package:flutter/material.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/text_styles.dart';

class SecondaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const SecondaryButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 48,
      minWidth: double.infinity,
      child: Text(
        title,
        style: TextStyles.titleWithSize(
          size: 18,
          color: ColorAsset.secondaryColor,
          weight: FontWeight.w700,
        ),
      ),
    );
  }
}
