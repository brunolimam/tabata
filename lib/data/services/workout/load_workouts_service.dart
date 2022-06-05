import 'package:tabata/data/models/workout_model.dart';

abstract class LoadWorkoutsService {
  Future<List<WorkoutModel>> load(String userId);
}
