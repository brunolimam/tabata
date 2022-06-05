import 'package:tabata/data/services/workout/delete_workout_service.dart';
import 'package:tabata/domain/repositories/delete_workout_repository.dart';

class DeleteWorkoutRepositoryImpl extends DeleteWorkoutRepository {
  final DeleteWorkoutService _service;

  DeleteWorkoutRepositoryImpl(this._service);

  @override
  Future<void> delete(String workoutId) async {
    await _service.delete(workoutId);
  }
}
