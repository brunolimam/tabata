part of 'tabata_workout_bloc.dart';

abstract class TabataWorkoutEvent extends Equatable {
  const TabataWorkoutEvent();

  @override
  List<Object> get props => [];
}

class StartTabataWorkoutEvent extends TabataWorkoutEvent {}

class PauseTabataWorkoutEvent extends TabataWorkoutEvent {}

class PlayTabataWorkoutEvent extends TabataWorkoutEvent {}

class StopTabataWorkoutEvent extends TabataWorkoutEvent {}

class RestartTabataWorkoutEvent extends TabataWorkoutEvent {}

class TabataWorkoutTimerTicked extends TabataWorkoutEvent {}
