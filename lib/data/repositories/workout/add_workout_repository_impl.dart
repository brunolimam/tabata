import 'package:tabata/data/models/tabata_model.dart';
import 'package:tabata/data/models/workout_feedback_model.dart';
import 'package:tabata/data/models/workout_model.dart';
import 'package:tabata/data/services/auth/current_user/get_current_user_service.dart';
import 'package:tabata/data/services/workout/add_workout_service.dart';
import 'package:tabata/domain/entities/workout.dart';
import 'package:tabata/domain/repositories/add_workout_repository.dart';

class AddWorkoutRepositoryImpl extends AddWorkoutRepository {
  final AddWorkoutService _service;
  final GetCurrentUserService _getCurrentUserService;

  AddWorkoutRepositoryImpl(
    this._service,
    this._getCurrentUserService,
  );

  @override
  Future<void> add(Workout workout) async {
    var user = _getCurrentUserService.get();
    if (user == null) return;

    var tabataModel = TabataModel(
      seriesTime: workout.tabata.seriesTime,
      seriesQuantity: workout.tabata.seriesQuantity,
      restTime: workout.tabata.restTime,
      cycleQuantity: workout.tabata.cycleQuantity,
      timeBetweenCycles: workout.tabata.timeBetweenCycles,
    );

    var feedbackModel = WorkoutFeedbackModel(
      workout.feedback.description,
      workout.feedback.intensity,
    );

    var workoutModel = WorkoutModel(
      tabataModel,
      feedbackModel,
      workout.date,
    );

    _service.add(workoutModel, user.id);
  }
}
