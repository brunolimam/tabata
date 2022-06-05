import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/usecases/workout/add_workout_use_case.dart';
import 'package:tabata/presentation/components/bottom_sheets/alert_bottom_sheet.dart';
import 'package:tabata/presentation/components/tabata/tabata_control_primary_button.dart';
import 'package:tabata/presentation/components/tabata/tabata_control_secondary_button.dart';
import 'package:tabata/presentation/main/tabata_workout/bloc/tabata_workout_bloc.dart';
import 'package:tabata/presentation/main/workout_feedback/workout_feedback_widget.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/dimens.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tabata/utils/navigator_utils.dart';
import 'package:tabata/utils/text_styles.dart';

class TabataWorkoutWidget extends StatefulWidget {
  final Tabata tabata;
  final TabataWorkoutBloc tabataWorkoutBloc;

  const TabataWorkoutWidget({
    required this.tabata,
    required this.tabataWorkoutBloc,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _TabataWorkoutWidgetState();
}

class _TabataWorkoutWidgetState extends State<TabataWorkoutWidget> {
  bool _isSoundEnabled = true;

  @override
  void dispose() {
    widget.tabataWorkoutBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.horizontal,
          ),
          child: BlocProvider<TabataWorkoutBloc>(
            create: (context) =>
                widget.tabataWorkoutBloc..add(StartTabataWorkoutEvent()),
            child: BlocBuilder<TabataWorkoutBloc, TabataWorkoutState>(
                builder: (context, state) {
              if (state is TabataWorkoutPrepare) {
                return _buildPrepareWorkout();
              } else if (state is TabataWorkoutExercise) {
                return _buildExercise(state.tabataWorkout);
              } else if (state is TabataWorkoutRest) {
                return _buildRest(state.tabataWorkout);
              } else if (state is TabataWorkoutCycleRest) {
                return _buildCycleRest(state.tabataWorkout);
              } else if (state is TabataWorkoutFinished) {
                return _buildFinished(state.tabata);
              }

              return const Text('Something went wrong');
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildPrepareWorkout() {
    _playPreparingAudio();
    return Center(
      child: Lottie.asset(
        AnimationAsset.named("start_workout_countdown"),
      ),
    );
  }

  Widget _buildExercise(TabataWorkout tabataWorkout) {
    if (tabataWorkout.seriesTime == tabataWorkout.seriesTimeRemaining) {
      _playStartAudio();
    }

    return Column(
      children: [
        _buildSoundHeader(),
        const Spacer(),
        _buildCyclesHeader(tabataWorkout),
        const SizedBox(height: 16),
        _buildExerciseContent(tabataWorkout),
        const SizedBox(height: 20),
        _buildTotalTimeContent(tabataWorkout),
        const Spacer(),
        _buildControls(tabataWorkout),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildCyclesHeader(TabataWorkout tabataWorkout) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          IconsAsset.named('ciclos'),
          color: ColorAsset.textColor,
        ),
        const SizedBox(width: 5),
        Text(
          '${tabataWorkout.currentCylesNumber}/${tabataWorkout.cylesNumber}',
          style: TextStyles.titleWithSize(
            size: 18,
            weight: FontWeight.w700,
          ),
        )
      ],
    );
  }

  Widget _buildExerciseContent(TabataWorkout tabataWorkout) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Lottie.asset(
          AnimationAsset.named("workout_total_time"),
          width: 280,
          animate: false,
        ),
        Lottie.asset(
          AnimationAsset.named("workout_serie_time"),
          width: 268,
          animate: false,
        ),
        Column(
          children: [
            SvgPicture.asset(IconsAsset.named("tempo_serie")),
            const SizedBox(height: 42),
            Text(
              tabataWorkout.seriesTimeRemaining.toString(),
              style: TextStyles.titleWithSize(
                size: 62,
                weight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'exercise'.tr(),
              style: TextStyles.titleWithSize(size: 16),
            ),
            const SizedBox(height: 29),
            _buildExerciseSerieContent(tabataWorkout),
          ],
        ),
      ],
    );
  }

  Widget _buildExerciseSerieContent(TabataWorkout tabataWorkout) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          IconsAsset.named('serie'),
          color: ColorAsset.textColor,
        ),
        const SizedBox(width: 5),
        Text(
          '${tabataWorkout.currentSeriesNumber}/${tabataWorkout.seriesNumber}',
          style: TextStyles.titleWithSize(
            size: 18,
            weight: FontWeight.w700,
          ),
        )
      ],
    );
  }

  Widget _buildTotalTimeContent(TabataWorkout tabataWorkout) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(IconsAsset.named('total')),
        const SizedBox(width: 5),
        Text(
          tabataWorkout.totalTimeText,
          style: TextStyles.titleWithSize(
            size: 18,
            weight: FontWeight.w700,
          ),
        )
      ],
    );
  }

  Widget _buildRest(TabataWorkout tabataWorkout) {
    if (tabataWorkout.restTimeRemaining < 4) {
      _playPreparingAudio();
    }

    return Column(
      children: [
        _buildSoundHeader(),
        const Spacer(),
        _buildCyclesHeader(tabataWorkout),
        const SizedBox(height: 16),
        _buildRestContent(tabataWorkout),
        const SizedBox(height: 20),
        _buildTotalTimeContent(tabataWorkout),
        const Spacer(),
        _buildControls(tabataWorkout),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildRestContent(TabataWorkout tabataWorkout) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Lottie.asset(
          AnimationAsset.named("workout_total_time"),
          width: 280,
          animate: false,
        ),
        Lottie.asset(
          AnimationAsset.named("workout_rest_time"),
          width: 268,
          animate: false,
        ),
        Column(
          children: [
            SvgPicture.asset(
              IconsAsset.named("tempo_descanso"),
              color: ColorAsset.restColor,
            ),
            const SizedBox(height: 42),
            Text(
              tabataWorkout.restTimeRemaining.toString(),
              style: TextStyles.titleWithSize(
                size: 62,
                weight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'rest'.tr(),
              style: TextStyles.titleWithSize(size: 16),
            ),
            const SizedBox(height: 29),
            _buildExerciseSerieContent(tabataWorkout),
          ],
        ),
      ],
    );
  }

  Widget _buildCycleRest(TabataWorkout tabataWorkout) {
    if (tabataWorkout.intervalTimeRemaining < 4) {
      _playPreparingAudio();
    }

    return Column(
      children: [
        _buildSoundHeader(),
        const Spacer(),
        _buildCyclesHeader(tabataWorkout),
        const SizedBox(height: 16),
        _buildCycleRestContent(tabataWorkout),
        const SizedBox(height: 20),
        _buildTotalTimeContent(tabataWorkout),
        const Spacer(),
        _buildControls(tabataWorkout),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildCycleRestContent(TabataWorkout tabataWorkout) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Lottie.asset(
          AnimationAsset.named("workout_total_time"),
          width: 280,
          animate: false,
        ),
        Lottie.asset(
          AnimationAsset.named("workout_rest_time"),
          width: 268,
          animate: false,
        ),
        Column(
          children: [
            SvgPicture.asset(
              IconsAsset.named("intervalo"),
              color: ColorAsset.restColor,
            ),
            const SizedBox(height: 42),
            Text(
              tabataWorkout.intervalTimeRemaining.toString(),
              style: TextStyles.titleWithSize(
                size: 62,
                weight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'interval'.tr(),
              style: TextStyles.titleWithSize(size: 16),
            ),
            const SizedBox(height: 29),
            _buildExerciseSerieContent(tabataWorkout),
          ],
        ),
      ],
    );
  }

  _buildControls(TabataWorkout tabataWorkout) {
    var mainButtonIcon = tabataWorkout.isPaused ? 'control_play' : 'pause';
    var mainButtonAction = tabataWorkout.isPaused ? _playAction : _pauseAction;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      TabataControlSecondaryButton(
        iconName: 'stop',
        onPressed: _stopAction,
      ),
      const SizedBox(width: 16),
      TabataControlPrimaryButton(
        iconName: mainButtonIcon,
        onPressed: mainButtonAction,
      ),
      const SizedBox(width: 16),
      TabataControlSecondaryButton(
        iconName: 'return',
        onPressed: _repeatAction,
      ),
    ]);
  }

  Widget _buildFinished(Tabata tabata) {
    Timer timer = Timer(const Duration(seconds: 3), () {
      var addWorkoutUseCase = GetIt.instance.get<AddWorkoutUseCase>();
      NavigatorUtils.navigate(
        context,
        WorkoutFeedbackWidget(
          tabata: tabata,
          addWorkoutUseCase: addWorkoutUseCase,
        ),
      );
    });

    return Center(
      child: Lottie.asset(AnimationAsset.named("finished_workout")),
    );
  }

  _playAction() {
    widget.tabataWorkoutBloc.add(PlayTabataWorkoutEvent());
  }

  _pauseAction() {
    widget.tabataWorkoutBloc.add(PauseTabataWorkoutEvent());
  }

  _stopAction() {
    widget.tabataWorkoutBloc.add(PauseTabataWorkoutEvent());

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AlertBottomSheet(
          title: "stop_workout_title".tr(),
          subtitle: "stop_workout_subtitle".tr(),
          mainButtonTitle: "finish_workout".tr(),
          secondaryButtonTitle: "back".tr(),
          confirmation: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  _repeatAction() {
    widget.tabataWorkoutBloc.add(PauseTabataWorkoutEvent());

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AlertBottomSheet(
          title: "restart_workout_title".tr(),
          subtitle: "restart_workout_subtitle".tr(),
          mainButtonTitle: "restart_workout".tr(),
          secondaryButtonTitle: "back".tr(),
          confirmation: () {
            Navigator.pop(context);
            widget.tabataWorkoutBloc.add(RestartTabataWorkoutEvent());
          },
        );
      },
    );
  }

  _buildSoundHeader() {
    var iconName = _isSoundEnabled ? 'sound' : 'sound_mute';
    return Row(
      children: [
        const Spacer(),
        IconButton(
          onPressed: () {
            setState(() {
              _isSoundEnabled = !_isSoundEnabled;
            });
          },
          icon: SvgPicture.asset(IconsAsset.named(iconName)),
        )
      ],
    );
  }

  _playPreparingAudio() {
    if (!_isSoundEnabled) return;

    AudioCache player = AudioCache();
    player.play(AudioAsset.named('prepare_audio'));
  }

  _playStartAudio() {
    if (!_isSoundEnabled) return;

    AudioCache player = AudioCache();
    player.play(AudioAsset.named('start_audio'));
  }
}
