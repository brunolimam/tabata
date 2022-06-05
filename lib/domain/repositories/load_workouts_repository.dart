import 'package:tabata/domain/entities/workout.dart';

abstract class LoadWorkoutsRepository {
  Future<List<Workout>> load();
}
