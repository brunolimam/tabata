part of 'launch_screen_bloc.dart';

@immutable
abstract class LaunchScreenEvent {}

class StartLaunchScreenEvent extends LaunchScreenEvent {
  final Duration loadTime;

  StartLaunchScreenEvent({
    this.loadTime = const Duration(seconds: 3),
  });
}
