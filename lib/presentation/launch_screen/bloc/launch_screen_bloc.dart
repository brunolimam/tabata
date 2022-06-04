import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'launch_screen_event.dart';
part 'launch_screen_state.dart';

class LaunchScreenBloc extends Bloc<LaunchScreenEvent, LaunchScreenState> {
  LaunchScreenBloc() : super(LaunchScreenInitial()) {
    on<StartLaunchScreenEvent>(_mapStartTimer);
  }

  void _mapStartTimer(
      StartLaunchScreenEvent event, Emitter<LaunchScreenState> emit) async {
    emit(LaunchScreenInitial());

    await Future.delayed(event.loadTime, () {
      emit(LaunchScreenClose());
    });
  }
}
