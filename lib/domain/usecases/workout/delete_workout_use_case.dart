import 'package:tabata/domain/entities/workout.dart';

abstract class DeleteWorkoutUseCase {
  Future<void> execute(Workout workout);
}
