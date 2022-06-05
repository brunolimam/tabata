import 'package:flutter/material.dart';
import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/entities/workout.dart';
import 'package:tabata/domain/entities/workout_feed_Intensity.dart';
import 'package:tabata/domain/entities/workout_feedback.dart';
import 'package:tabata/domain/usecases/workout/add_workout_use_case.dart';
import 'package:tabata/presentation/components/buttons/primary_button.dart';
import 'package:tabata/presentation/components/workout/workout_item_header.dart';
import 'package:tabata/presentation/components/workout/workout_item_intensity.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tabata/utils/dimens.dart';
import 'package:tabata/utils/text_styles.dart';

class WorkoutFeedbackWidget extends StatefulWidget {
  final Tabata tabata;
  final AddWorkoutUseCase addWorkoutUseCase;

  const WorkoutFeedbackWidget({
    required this.tabata,
    required this.addWorkoutUseCase,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _WorkoutFeedbackWidgetState();
}

class _WorkoutFeedbackWidgetState extends State<WorkoutFeedbackWidget> {
  WorkoutFeedbackIntensity? _currentItensity;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildContent(),
            const SizedBox(height: 44),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.horizontal),
              child: PrimaryButton(
                title: 'save'.tr(),
                onPressed: _save,
              ),
            ),
            const SizedBox(height: 44),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: ColorAsset.mainColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.horizontal),
        child: Column(children: [
          const SizedBox(height: 60),
          Row(
            children: [
              IconButton(
                onPressed: _close,
                icon: Icon(
                  Icons.close,
                  color: ColorAsset.textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'workout_finished'.tr(),
            style: TextStyles.titleWithSize(
              size: 28,
              weight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          _buildTabataContentHeader(),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }

  Widget _buildTabataContentHeader() {
    return Row(children: [
      const SizedBox(width: 12),
      WorkoutItemHeader(
        title: 'series'.tr(),
        iconName: 'serie',
        value: '20',
      ),
      const Spacer(),
      WorkoutItemHeader(
        title: 'cycles'.tr(),
        iconName: 'ciclos',
        value: '20',
      ),
      const Spacer(),
      WorkoutItemHeader(
        title: 'total_time'.tr(),
        iconName: 'total',
        value: '20',
      ),
      const SizedBox(width: 12),
    ]);
  }

  Widget _buildContent() {
    return Column(
      children: [
        const SizedBox(height: 24),
        Text(
          'how_was_the_workout'.tr(),
          style: TextStyles.titleWithSize(size: 18, weight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        _buildIntensityContent(),
        const SizedBox(height: 32),
        _buildFeedbackDescriptionContent(),
      ],
    );
  }

  Widget _buildIntensityContent() {
    return Row(
      children: [
        const SizedBox(width: 40),
        WorkoutItemIntensity(
          intensity: WorkoutFeedbackIntensity.light,
          isSelected: _currentItensity == WorkoutFeedbackIntensity.light,
          onPressed: () {
            setState(() {
              _currentItensity = WorkoutFeedbackIntensity.light;
            });
          },
        ),
        const Spacer(),
        WorkoutItemIntensity(
          intensity: WorkoutFeedbackIntensity.normal,
          isSelected: _currentItensity == WorkoutFeedbackIntensity.normal,
          onPressed: () {
            setState(() {
              _currentItensity = WorkoutFeedbackIntensity.normal;
            });
          },
        ),
        const Spacer(),
        WorkoutItemIntensity(
          intensity: WorkoutFeedbackIntensity.hard,
          isSelected: _currentItensity == WorkoutFeedbackIntensity.hard,
          onPressed: () {
            setState(() {
              _currentItensity = WorkoutFeedbackIntensity.hard;
            });
          },
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildFeedbackDescriptionContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.horizontal),
      child: Column(
        children: [
          Text(
            'feed_back_more_details'.tr(),
            style: TextStyles.titleWithSize(
              size: 18,
              weight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: ColorAsset.borderFeedbackColor),
              borderRadius: BorderRadius.circular(16),
            ),
            child: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: _feedbackController,
                  cursorColor: ColorAsset.textColor,
                  style: TextStyles.titleWithSize(
                    size: 14,
                    weight: FontWeight.w700,
                    color: ColorAsset.textColor,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  maxLength: 300,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'type_about_the_workout'.tr(),
                    hintStyle: TextStyles.titleWithSize(
                      size: 14,
                      weight: FontWeight.w700,
                      color: ColorAsset.secondaryTextColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _close() {}

  _save() {
    if (_currentItensity == null) return;
    var description = _feedbackController.text;

    var feedback = WorkoutFeedback(
      description: description,
      intensity: _currentItensity!,
    );
    var workout = Workout(
      tabata: widget.tabata,
      feedback: feedback,
    );

    widget.addWorkoutUseCase.execute(workout);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
