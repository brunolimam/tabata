import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabata/domain/entities/workout.dart';
import 'package:tabata/presentation/components/gestures/gesture_tap.dart';
import 'package:tabata/presentation/components/workout/workout_item_header.dart';
import 'package:tabata/presentation/components/workout/workout_item_intensity.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/dimens.dart';
import 'package:tabata/domain/entities/workout_feedback_intensity.dart';
import 'package:tabata/utils/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tabata/extension/string_casing_extension.dart';

class WorkoutListItem extends StatelessWidget {
  final Workout workout;
  final VoidCallback onPressed;
  final String totalTime;

  const WorkoutListItem({
    required this.workout,
    required this.onPressed,
    required this.totalTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureTap(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: Dimens.horizontal,
        ),
        child: Column(children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: ColoredBox(
              color: ColorAsset.secondaryBackground,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 16),
                    _buildContent(),
                    const SizedBox(height: 16),
                    Divider(color: ColorAsset.workoutItemDividerColor),
                    const SizedBox(height: 16),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(children: [
      WorkoutItemIntensity(
        intensity: workout.feedback.intensity,
        isSelected: true,
        showsTitle: false,
        onPressed: () {},
      ),
      const SizedBox(width: 8),
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workout.feedback.intensity.displayName,
              style: TextStyles.titleWithSize(
                size: 16,
                weight: FontWeight.w700,
              ),
            ),
            Text(
              workout.feedback.description,
              style: TextStyles.titleWithSize(
                size: 12,
                weight: FontWeight.w700,
              ),
            ),
          ]),
    ]);
  }

  Widget _buildContent() {
    return Row(children: [
      const SizedBox(width: 40),
      WorkoutItemHeader(
        title: 'series'.tr(),
        iconName: 'serie',
        value: workout.tabata.seriesQuantity,
      ),
      const Spacer(),
      WorkoutItemHeader(
        title: 'cycles'.tr(),
        iconName: 'ciclos',
        value: workout.tabata.cycleQuantity,
      ),
      const Spacer(),
      WorkoutItemHeader(
        title: 'total_time'.tr(),
        iconName: 'total',
        value: totalTime,
      ),
      const SizedBox(width: 40),
    ]);
  }

  Widget _buildFooter() {
    return Row(children: [
      SvgPicture.asset(
        IconsAsset.named('return'),
        color: ColorAsset.secondaryColor,
      ),
      const SizedBox(width: 12),
      Text(
        'repeat_tabata'.tr(),
        style: TextStyles.titleWithSize(
            size: 16, color: ColorAsset.secondaryColor),
      ),
      const Spacer(),
      Text(
        _dateDisplay(),
        style: TextStyles.titleWithSize(
          size: 12,
          weight: FontWeight.w600,
          color: ColorAsset.secondaryTextColor,
        ),
      ),
    ]);
  }

  String _dateDisplay() {
    return DateFormat('EEE | dd MMM yy', 'pt')
        .format(workout.date)
        .toTitleCase();
  }
}
