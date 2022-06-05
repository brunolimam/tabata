import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tabata/domain/entities/workout.dart';
import 'package:tabata/domain/usecases/total_time/get_total_time_use_case.dart';
import 'package:tabata/domain/usecases/workout/delete_workout_use_case.dart';
import 'package:tabata/presentation/components/bars/close_item_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tabata/presentation/components/bottom_sheets/alert_bottom_sheet.dart';
import 'package:tabata/presentation/components/buttons/primary_button.dart';
import 'package:tabata/presentation/components/workout/workout_detail_item.dart';
import 'package:tabata/presentation/components/workout/workout_item_intensity.dart';
import 'package:tabata/domain/entities/workout_feedback_intensity.dart';
import 'package:tabata/presentation/main/tabata_workout/bloc/tabata_workout_bloc.dart';
import 'package:tabata/presentation/main/tabata_workout/tabata_workout_widget.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/navigator_utils.dart';
import 'package:tabata/utils/text_styles.dart';
import 'package:tabata/extension/string_casing_extension.dart';

class WorkoutDetailWidget extends StatefulWidget {
  final Workout workout;
  final GetTotalTimeUseCase getTotalTimeUseCase;
  final DeleteWorkoutUseCase deleteWorkoutUseCase;

  const WorkoutDetailWidget({
    required this.workout,
    required this.getTotalTimeUseCase,
    required this.deleteWorkoutUseCase,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _WorkoutDetailWidgetState();
}

class _WorkoutDetailWidgetState extends State<WorkoutDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CloseItemBar(
            closeCallback: () => Navigator.pop(context),
            title: 'workout_details'.tr(),
            iconItemName: 'trash',
            onItemPressed: _deleteWorkout,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(children: [
                _buildHeader(),
                _buildContent(),
                const Spacer(),
                PrimaryButton(
                  title: 'repeat_tabata'.tr(),
                  onPressed: _repeateWorkout,
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  _deleteWorkout() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AlertBottomSheet(
          title: "delete_workout_title".tr(),
          subtitle: "delete_workout_subtitle".tr(),
          mainButtonTitle: "delete".tr(),
          secondaryButtonTitle: "back".tr(),
          iconName: 'delete',
          confirmation: () {
            Navigator.pop(context);
            Navigator.pop(context);

            widget.deleteWorkoutUseCase.execute(widget.workout);
          },
        );
      },
    );
  }

  _repeateWorkout() {
    var tabataWorkoutBloc =
        GetIt.instance.get<TabataWorkoutBloc>(param1: widget.workout.tabata);
    NavigatorUtils.navigate(
      context,
      TabataWorkoutWidget(
        tabata: widget.workout.tabata,
        tabataWorkoutBloc: tabataWorkoutBloc,
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            WorkoutItemIntensity(
              intensity: widget.workout.feedback.intensity,
              showsTitle: false,
              isSelected: true,
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Treino ${widget.workout.feedback.intensity.displayName}',
                  style: TextStyles.titleWithSize(
                    size: 20,
                    weight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _dateDisplay(),
                  style: TextStyles.titleWithSize(
                    size: 12,
                    weight: FontWeight.w600,
                    color: ColorAsset.secondaryTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          widget.workout.feedback.description,
          style: TextStyles.titleWithSize(
            size: 14,
            weight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  String _dateDisplay() {
    return DateFormat('EEE | dd MMM yy', 'pt')
        .format(widget.workout.date)
        .toTitleCase();
  }

  Widget _buildContent() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      child: Column(
        children: [
          WorkoutDetailItem(
            iconName: 'tempo_serie',
            title: 'series_time'.tr(),
            value: widget.workout.tabata.seriesTime,
            valueColor: ColorAsset.textColor,
          ),
          WorkoutDetailItem(
            iconName: 'tempo_descanso',
            title: 'rest_time'.tr(),
            value: widget.workout.tabata.restTime,
            valueColor: ColorAsset.textColor,
          ),
          WorkoutDetailItem(
            iconName: 'intervalo',
            title: 'time_between_cicles'.tr(),
            value: widget.workout.tabata.timeBetweenCycles,
            valueColor: ColorAsset.textColor,
          ),
          WorkoutDetailItem(
            iconName: 'serie',
            title: 'series_quantity'.tr(),
            value: widget.workout.tabata.seriesQuantity,
            valueColor: ColorAsset.textColor,
          ),
          WorkoutDetailItem(
            iconName: 'ciclos',
            title: 'cycles_quantity'.tr(),
            value: widget.workout.tabata.cycleQuantity,
            valueColor: ColorAsset.textColor,
          ),
          WorkoutDetailItem(
            iconName: 'total',
            title: 'total_time'.tr(),
            value: widget.getTotalTimeUseCase.execute(widget.workout.tabata),
            valueColor: ColorAsset.textColor,
          )
        ],
      ),
    );
  }
}
