part of 'workouts_bloc.dart';

abstract class WorkoutsEvent {
  const WorkoutsEvent();
}

class GetWorkoutsEvent extends WorkoutsEvent {
  const GetWorkoutsEvent();
}
