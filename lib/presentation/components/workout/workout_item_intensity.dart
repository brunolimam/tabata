import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabata/domain/entities/workout_feed_Intensity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tabata/presentation/components/gestures/gesture_tap.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/text_styles.dart';

class WorkoutItemIntensity extends StatelessWidget {
  final bool isSelected;
  final WorkoutFeedbackIntensity intensity;
  final VoidCallback onPressed;

  const WorkoutItemIntensity({
    this.isSelected = false,
    required this.intensity,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureTap(
      onPressed: onPressed,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: ColoredBox(
              color: _getColor(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  IconsAsset.named(_getIconName()),
                  color: _getIconColor(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _getTitle(),
            style: TextStyles.titleWithSize(
              size: 14,
              weight: FontWeight.w700,
              color: _getTextColor(),
            ),
          )
        ],
      ),
    );
  }

  String _getTitle() {
    switch (intensity) {
      case WorkoutFeedbackIntensity.light:
        return "light".tr();
      case WorkoutFeedbackIntensity.normal:
        return "moderate".tr();
      case WorkoutFeedbackIntensity.hard:
        return "hard".tr();
    }
  }

  Color _getColor() {
    if (!isSelected) return ColorAsset.secondaryBackground;

    switch (intensity) {
      case WorkoutFeedbackIntensity.light:
        return ColorAsset.lightFeedbackColor;
      case WorkoutFeedbackIntensity.normal:
        return ColorAsset.mainColor;
      case WorkoutFeedbackIntensity.hard:
        return ColorAsset.hardFeedbackColor;
    }
  }

  Color _getTextColor() {
    if (!isSelected) return ColorAsset.secondaryTextColor;

    switch (intensity) {
      case WorkoutFeedbackIntensity.light:
        return ColorAsset.restColor;
      case WorkoutFeedbackIntensity.normal:
        return ColorAsset.secondaryColor;
      case WorkoutFeedbackIntensity.hard:
        return ColorAsset.hardFeedbackTextColor;
    }
  }

  Color _getIconColor() {
    return isSelected
        ? ColorAsset.textColor
        : ColorAsset.unselectedIconFeedbackColor;
  }

  String _getIconName() {
    switch (intensity) {
      case WorkoutFeedbackIntensity.light:
        return "leve";
      case WorkoutFeedbackIntensity.normal:
        return "moderado";
      case WorkoutFeedbackIntensity.hard:
        return "intenso";
    }
  }
}
