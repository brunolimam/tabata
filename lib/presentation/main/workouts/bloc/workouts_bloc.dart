import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tabata/domain/entities/workout.dart';
import 'package:tabata/domain/usecases/workout/get_workouts_use_case.dart';

part 'workouts_event.dart';
part 'workouts_state.dart';

class WorkoutsBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  final GetWorkoutsUseCase _getWorkoutsUseCase;

  WorkoutsBloc(this._getWorkoutsUseCase) : super(WorkoutsLoading()) {
    on<GetWorkoutsEvent>(_mapLoadworkouts);
  }

  _mapLoadworkouts(GetWorkoutsEvent event, Emitter<WorkoutsState> emit) async {
    emit(WorkoutsLoading());
    var workouts = await _getWorkoutsUseCase.execute();

    if (workouts.isEmpty) {
      return emit(WorkoutsEmpty());
    }

    return emit(WorkoutsDone(workouts));
  }
}
