import 'package:tabata/data/models/workout_model.dart';

abstract class AddWorkoutService {
  Future<void> add(
    WorkoutModel workoutModel,
    String userId,
  );
}
