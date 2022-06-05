import 'package:tabata/data/services/auth/current_user/get_current_user_service.dart';
import 'package:tabata/data/services/workout/load_workouts_service.dart';
import 'package:tabata/domain/entities/workout.dart';
import 'package:tabata/domain/repositories/load_workouts_repository.dart';

class LoadWorkoutsRepositoryImpl extends LoadWorkoutsRepository {
  final LoadWorkoutsService _service;
  final GetCurrentUserService _getCurrentUserService;

  LoadWorkoutsRepositoryImpl(
    this._service,
    this._getCurrentUserService,
  );

  @override
  Future<List<Workout>> load() async {
    var user = _getCurrentUserService.get();
    if (user == null) return [];

    return _service.load(user.id);
  }
}
