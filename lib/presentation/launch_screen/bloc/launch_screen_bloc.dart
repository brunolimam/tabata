import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tabata/domain/usecases/auth/is_user_authenticated_use_case.dart';
part 'launch_screen_event.dart';
part 'launch_screen_state.dart';

class LaunchScreenBloc extends Bloc<LaunchScreenEvent, LaunchScreenState> {
  IsUserAuthenticatedUseCase _authenticatedUseCase;

  LaunchScreenBloc(this._authenticatedUseCase) : super(LaunchScreenInitial()) {
    on<StartLaunchScreenEvent>(_mapStartTimer);
  }

  void _mapStartTimer(
      StartLaunchScreenEvent event, Emitter<LaunchScreenState> emit) async {
    emit(LaunchScreenInitial());

    await Future.delayed(event.loadTime, () {
      LaunchScreenState nextState = _authenticatedUseCase.execute()
          ? LaunchScreenGoToWorkout()
          : LaunchScreenGoToFirstSetup();
      emit(nextState);
    });
  }
}
