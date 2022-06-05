import 'package:tabata/domain/entities/workout.dart';
import 'package:tabata/domain/repositories/load_workouts_repository.dart';
import 'package:tabata/domain/usecases/workout/get_workouts_use_case.dart';

class GetWorkoutsUseCaseImpl extends GetWorkoutsUseCase {
  final LoadWorkoutsRepository _loadWorkoutsRepository;

  GetWorkoutsUseCaseImpl(this._loadWorkoutsRepository);

  @override
  Future<List<Workout>> execute() async {
    return await _loadWorkoutsRepository.load();
  }
}
