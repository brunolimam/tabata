import 'package:flutter/material.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const PrimaryButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(24.0)),
      child: MaterialButton(
        textColor: ColorAsset.textColor,
        color: ColorAsset.mainColor,
        onPressed: onPressed,
        height: 48,
        minWidth: double.infinity,
        child: Text(
          title,
          style: TextStyles.titleWithSize(
            size: 18,
            weight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
