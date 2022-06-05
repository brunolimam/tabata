part of 'workouts_bloc.dart';

abstract class WorkoutsState extends Equatable {
  const WorkoutsState();

  @override
  List<Object> get props => [];
}

class WorkoutsEmpty extends WorkoutsState {}

class WorkoutsLoading extends WorkoutsState {}

class WorkoutsDone extends WorkoutsState {
  final List<Workout> workouts;

  const WorkoutsDone(this.workouts);
}
