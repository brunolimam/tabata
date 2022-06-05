import 'package:tabata/domain/entities/workout.dart';
import 'package:tabata/domain/repositories/delete_workout_repository.dart';
import 'package:tabata/domain/usecases/workout/delete_workout_use_case.dart';

class DeleteWorkoutUseCaseImpl extends DeleteWorkoutUseCase {
  DeleteWorkoutRepository _repository;

  DeleteWorkoutUseCaseImpl(this._repository);

  @override
  Future<void> execute(Workout workout) async {
    var id = workout.id;
    if (id == null) return;
    await _repository.delete(id);
  }
}
