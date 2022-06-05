import 'package:tabata/domain/entities/workout.dart';

abstract class AddWorkoutUseCase {
  Future<void> execute(Workout workout);
}
