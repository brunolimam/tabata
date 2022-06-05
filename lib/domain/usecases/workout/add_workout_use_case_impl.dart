import 'package:tabata/domain/entities/workout.dart';
import 'package:tabata/domain/repositories/add_workout_repository.dart';
import 'package:tabata/domain/usecases/workout/add_workout_use_case.dart';

class AddWorkoutUseCaseImpl extends AddWorkoutUseCase {
  final AddWorkoutRepository _repository;

  AddWorkoutUseCaseImpl(this._repository);

  @override
  Future<void> execute(Workout workout) async {
    _repository.add(workout);
  }
}
