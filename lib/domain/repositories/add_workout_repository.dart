import 'package:tabata/domain/entities/workout.dart';

abstract class AddWorkoutRepository {
  Future<void> add(Workout workout);
}
