import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabata/domain/entities/workout.dart';
import 'package:tabata/domain/usecases/total_time/get_total_time_use_case.dart';
import 'package:tabata/presentation/components/bars/title_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tabata/presentation/components/loading/loading_state_widget.dart';
import 'package:tabata/presentation/components/workout/workout_list_item.dart';
import 'package:tabata/presentation/main/workouts/bloc/workouts_bloc.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:tabata/utils/text_styles.dart';

class WorkoutsWidget extends StatefulWidget {
  final WorkoutsBloc workoutsBloc;
  final GetTotalTimeUseCase getTotalTimeUseCase;

  const WorkoutsWidget({
    required this.workoutsBloc,
    required this.getTotalTimeUseCase,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _WorkoutsWidgetState();
}

class _WorkoutsWidgetState extends State<WorkoutsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TitleBar(title: "your_workouts".tr()),
          BlocProvider<WorkoutsBloc>(
            create: (context) =>
                widget.workoutsBloc..add(const GetWorkoutsEvent()),
            child: BlocBuilder<WorkoutsBloc, WorkoutsState>(
              builder: (context, state) {
                if (state is WorkoutsLoading) {
                  return const LoadingStateWidget();
                } else if (state is WorkoutsDone) {
                  return _buildContentState(state.workouts);
                } else if (state is WorkoutsEmpty) {
                  return _buildEmptyState();
                }
                return const LoadingStateWidget();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Expanded(
      child: Column(
        children: [
          const Spacer(),
          SvgPicture.asset(IconsAsset.named('treino_empty')),
          const SizedBox(height: 20),
          Text(
            'empty_workouts_title'.tr(),
            style: TextStyles.titleWithSize(
              size: 20,
              weight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'empty_workouts_subtitle'.tr(),
            style: TextStyles.titleWithSize(
              size: 14,
              weight: FontWeight.w700,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildContentState(List<Workout> workouts) {
    var items = workouts
        .map(
          (workout) => WorkoutListItem(
            workout: workout,
            totalTime: widget.getTotalTimeUseCase.execute(workout.tabata),
            onPressed: () {
              _openWorkout(workout);
            },
          ),
        )
        .toList();

    return Expanded(
      child: ListView(
        children: items,
      ),
    );
  }

  _openWorkout(Workout workout) {}
}
