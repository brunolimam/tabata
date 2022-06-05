import 'package:tabata/domain/entities/workout.dart';

abstract class GetWorkoutsUseCase {
  Future<List<Workout>> execute();
}
