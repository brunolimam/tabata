import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';
import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/entities/time.dart';
import 'package:tabata/domain/usecases/seconds_to_time/get_time_from_seconds.dart';
import 'package:tabata/domain/usecases/text_to_time/get_time_from_text_use_case.dart';
import 'package:tabata/domain/usecases/time_to_seconds/get_seconds_from_time.dart';
import 'package:tabata/domain/usecases/time_to_text/get_text_from_time_use_case.dart';
import 'package:tabata/domain/usecases/total_time/get_total_time_use_case.dart';
import 'package:tabata/presentation/main/tabata_workout/bloc/tabata_workout_bloc_state.dart';

part 'tabata_workout_event.dart';
part 'tabata_workout_state.dart';

class TabataWorkoutBloc extends Bloc<TabataWorkoutEvent, TabataWorkoutState> {
  final Tabata _tabata;
  final GetTimeFromTextUseCase _getTimeFromTextUseCase;
  final GetSecondsFromTime _getSecondsFromTime;
  final GetTotalTimeUseCase _getTotalTimeUseCase;
  final GetTimeFromSeconds _getTimeFromSeconds;
  final GetTextFromTimeUseCase _getTextFromTimeUseCase;

  int _prepareRemainingTime = 3;

  Ticker? _prepareTicker;
  Ticker? _exerciseTicker;
  Ticker? _restTicker;
  Ticker? _cyleRestTicker;

  Ticker? _currentTicker;
  StreamSubscription<int>? _tickerSubscription;

  late TabataWorkout _currentTabataWorkout;
  TabataWorkoutBlocState _currentState = TabataWorkoutBlocState.isPreparing;

  TabataWorkoutBloc(
    this._tabata,
    this._getTimeFromTextUseCase,
    this._getSecondsFromTime,
    this._getTotalTimeUseCase,
    this._getTimeFromSeconds,
    this._getTextFromTimeUseCase,
  ) : super(const TabataWorkoutPrepare()) {
    _currentTabataWorkout = _getInitialTabataWorkout(_tabata);
    on<StartTabataWorkoutEvent>(_mapStartWorkout);
    on<PauseTabataWorkoutEvent>(_mapPauseWorkout);
    on<StopTabataWorkoutEvent>(_mapStopWorkout);
    on<RestartTabataWorkoutEvent>(_mapRestartWorkout);
  }

  TabataWorkout _getInitialTabataWorkout(Tabata tabata) {
    var seriesTime = _getTimeFromTextUseCase.execute(tabata.seriesTime);
    var seriesTimeSeconds = _getSecondsFromTime.execute(seriesTime);

    var restTime = _getTimeFromTextUseCase.execute(tabata.restTime);
    var restTimeSeconds = _getSecondsFromTime.execute(restTime);

    var intervalTime =
        _getTimeFromTextUseCase.execute(tabata.timeBetweenCycles);
    var intervalTimeSeconds = _getSecondsFromTime.execute(intervalTime);

    var seriesNumber = int.parse(tabata.seriesQuantity);
    var cylesNumber = int.parse(tabata.cycleQuantity);

    var totalTimeText = _getTotalTimeUseCase.execute(tabata);
    var totalTimeInTime = _getTimeFromTextUseCase.execute(totalTimeText);
    var totalTimeInSeconds = _getSecondsFromTime.execute(totalTimeInTime);

    return TabataWorkout(
      seriesTimeSeconds,
      seriesTimeSeconds,
      1,
      seriesNumber,
      1,
      cylesNumber,
      restTimeSeconds,
      restTimeSeconds,
      intervalTimeSeconds,
      intervalTimeSeconds,
      totalTimeInSeconds,
      totalTimeInSeconds,
      totalTimeText,
    );
  }

  void _mapStartWorkout(
    StartTabataWorkoutEvent event,
    Emitter<TabataWorkoutState> emit,
  ) {
    _currentTicker?.stop();
    _currentTicker = Ticker(
      (elapsed) {
        add(TabataWorkoutTimerTicked());
      },
    );
  }

  void _mapPauseWorkout(
    PauseTabataWorkoutEvent event,
    Emitter<TabataWorkoutState> emit,
  ) async {}

  void _mapStopWorkout(
    StopTabataWorkoutEvent event,
    Emitter<TabataWorkoutState> emit,
  ) async {}

  void _mapRestartWorkout(
    RestartTabataWorkoutEvent event,
    Emitter<TabataWorkoutState> emit,
  ) async {}

  void _onTicked(
    TabataWorkoutTimerTicked event,
    Emitter<TabataWorkoutState> emit,
  ) {
    _decrementTotalTime();
    switch (_currentState) {
      case TabataWorkoutBlocState.isPreparing:
        _decrementPreparingTime();
        if (_prepareRemainingTime == 0) {
          _restartPrepareTime();
          _currentState = TabataWorkoutBlocState.isExercising;
        }
        break;
      case TabataWorkoutBlocState.isExercising:
        _decrementExerciseTime();
        if (_currentTabataWorkout.seriesTimeRemaining == 0) {
          _restartExerciseTime();

          if (_currentTabataWorkout.isOnEndOfCycle()) {
            _currentState = TabataWorkoutBlocState.isCyleResting;
          } else if (_currentTabataWorkout.isOnEndOfExercise()) {
            _currentState = TabataWorkoutBlocState.isFinished;
          }
        }
        break;
      case TabataWorkoutBlocState.isResting:
        _decrementRestTime();
        if (_currentTabataWorkout.restTimeRemaining == 0) {
          _restartRestTime();
          _currentState = TabataWorkoutBlocState.isExercising;
        }
        break;
      case TabataWorkoutBlocState.isCyleResting:
        _decrementCycleRestTime();
        if (_currentTabataWorkout.intervalTimeRemaining == 0) {
          _restartCycleRestTime();
        }
        break;
      case TabataWorkoutBlocState.isFinished:
        break;
    }
  }

  _restartPrepareTime() {
    _prepareRemainingTime = 0;
  }

  _restartExerciseTime() {
    _currentTabataWorkout.seriesTimeRemaining =
        _currentTabataWorkout.seriesTime;
  }

  _restartRestTime() {
    _currentTabataWorkout.restTimeRemaining = _currentTabataWorkout.restTime;
  }

  _restartTotalTime() {
    _currentTabataWorkout.totalTimeRemaining = _currentTabataWorkout.totalTime;
  }

  _restartCycleRestTime() {
    _currentTabataWorkout.intervalTimeRemaining =
        _currentTabataWorkout.intervalTime;
  }

  _decrementPreparingTime() {
    _currentTabataWorkout.seriesTimeRemaining -= 1;
  }

  _decrementExerciseTime() {
    _currentTabataWorkout.seriesTimeRemaining -= 1;
  }

  _decrementRestTime() {
    _currentTabataWorkout.restTimeRemaining -= 1;
  }

  _decrementCycleRestTime() {
    _currentTabataWorkout.intervalTimeRemaining -= 1;
  }

  _decrementTotalTime() {
    _currentTabataWorkout.totalTimeRemaining -= 1;
    var time =
        _getTimeFromSeconds.execute(_currentTabataWorkout.totalTimeRemaining);
    _currentTabataWorkout.totalTimeText = _getTextFromTimeUseCase.execute(time);
  }

  _incrementSerieNumber() {
    _currentTabataWorkout.currentSeriesNumber += 1;
  }

  _incrementCycleNumber() {
    _currentTabataWorkout.currentCylesNumber += 1;
  }
}
