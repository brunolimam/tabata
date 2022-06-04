part of 'launch_screen_bloc.dart';

@immutable
abstract class LaunchScreenState {}

class LaunchScreenInitial extends LaunchScreenState {}

class LaunchScreenGoToFirstSetup extends LaunchScreenState {}

class LaunchScreenGoToWorkout extends LaunchScreenState {}
