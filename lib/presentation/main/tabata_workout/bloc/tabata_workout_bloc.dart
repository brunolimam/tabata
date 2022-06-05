import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/usecases/seconds_to_time/get_time_from_seconds.dart';
import 'package:tabata/domain/usecases/text_to_time/get_time_from_text_use_case.dart';
import 'package:tabata/domain/usecases/time_to_seconds/get_seconds_from_time.dart';
import 'package:tabata/domain/usecases/time_to_text/get_text_from_time_use_case.dart';
import 'package:tabata/domain/usecases/total_time/get_total_time_use_case.dart';
import 'package:tabata/presentation/main/tabata_workout/bloc/tabata_workout_bloc_state.dart';

part 'tabata_workout_event.dart';
part 'tabata_workout_state.dart';

class TabataWorkoutBloc extends Bloc<TabataWorkoutEvent, TabataWorkoutState> {
  final Tabata tabata;
  final GetTimeFromTextUseCase getTimeFromTextUseCase;
  final GetSecondsFromTime getSecondsFromTime;
  final GetTotalTimeUseCase getTotalTimeUseCase;
  final GetTimeFromSeconds getTimeFromSeconds;
  final GetTextFromTimeUseCase getTextFromTimeUseCase;

  int _prepareRemainingTime = 3;

  Duration tickerDuration;
  Timer? _currentTimer;

  late TabataWorkout _currentTabataWorkout;
  TabataWorkoutBlocState _currentState = TabataWorkoutBlocState.isPreparing;

  TabataWorkoutBloc({
    required this.tabata,
    required this.getTimeFromTextUseCase,
    required this.getSecondsFromTime,
    required this.getTotalTimeUseCase,
    required this.getTimeFromSeconds,
    required this.getTextFromTimeUseCase,
    this.tickerDuration = const Duration(seconds: 1),
  }) : super(const TabataWorkoutPrepare()) {
    _currentTabataWorkout = _getInitialTabataWorkout(tabata);
    on<StartTabataWorkoutEvent>(_mapStartWorkout);
    on<PauseTabataWorkoutEvent>(_mapPauseWorkout);
    on<PlayTabataWorkoutEvent>(_mapPlayWorkout);
    on<RestartTabataWorkoutEvent>(_mapRestartWorkout);
    on<TabataWorkoutTimerTicked>(_onTicked);
  }

  void _mapStartWorkout(
    StartTabataWorkoutEvent event,
    Emitter<TabataWorkoutState> emit,
  ) async {
    _startTicker();
  }

  void _mapPauseWorkout(
    PauseTabataWorkoutEvent event,
    Emitter<TabataWorkoutState> emit,
  ) async {
    _currentTimer?.cancel();
    _currentTabataWorkout.isPaused = true;
    _updateState(emit);
  }

  void _mapPlayWorkout(
    PlayTabataWorkoutEvent event,
    Emitter<TabataWorkoutState> emit,
  ) async {
    _startTicker();
    _currentTabataWorkout.isPaused = false;
    _updateState(emit);
  }

  void _mapRestartWorkout(
    RestartTabataWorkoutEvent event,
    Emitter<TabataWorkoutState> emit,
  ) async {
    _currentTabataWorkout = _getInitialTabataWorkout(tabata);
    _currentState = TabataWorkoutBlocState.isPreparing;
    _prepareRemainingTime = 3;
    _startTicker();
    _updateState(emit);
  }

  _updateState(Emitter<TabataWorkoutState> emit) {
    switch (_currentState) {
      case TabataWorkoutBlocState.isPreparing:
        emit(TabataWorkoutPrepare(prepareTimeRemaining: _prepareRemainingTime));
        break;

      case TabataWorkoutBlocState.isExercising:
        emit(TabataWorkoutExercise(_currentTabataWorkout));

        break;
      case TabataWorkoutBlocState.isResting:
        emit(TabataWorkoutRest(_currentTabataWorkout));

        break;
      case TabataWorkoutBlocState.isCyleResting:
        emit(TabataWorkoutCycleRest(_currentTabataWorkout));

        break;
      case TabataWorkoutBlocState.isFinished:
        break;
    }
  }

  void _onTicked(
    TabataWorkoutTimerTicked event,
    Emitter<TabataWorkoutState> emit,
  ) {
    switch (_currentState) {
      case TabataWorkoutBlocState.isPreparing:
        _tickedPreparing(emit);
        break;
      case TabataWorkoutBlocState.isExercising:
        _decrementTotalTime();
        _tickerExercising(emit);
        break;
      case TabataWorkoutBlocState.isResting:
        _decrementTotalTime();
        _tickedResting(emit);
        break;
      case TabataWorkoutBlocState.isCyleResting:
        _decrementTotalTime();
        _tickedCycleResting(emit);
        break;
      case TabataWorkoutBlocState.isFinished:
        break;
    }
  }

  _startTicker() {
    _currentTimer?.cancel();
    _currentTimer = Timer.periodic(
      tickerDuration,
      (_) => add(
        TabataWorkoutTimerTicked(),
      ),
    );
  }

  _tickedPreparing(Emitter<TabataWorkoutState> emit) {
    _decrementPreparingTime();
    if (_prepareRemainingTime == 0) {
      _restartPrepareTime();
      _currentState = TabataWorkoutBlocState.isExercising;
      return emit(TabataWorkoutExercise(_currentTabataWorkout));
    }

    emit(TabataWorkoutPrepare(prepareTimeRemaining: _prepareRemainingTime));
  }

  _tickerExercising(Emitter<TabataWorkoutState> emit) {
    _decrementExerciseTime();
    if (_currentTabataWorkout.seriesTimeRemaining == 0) {
      _restartExerciseTime();

      if (_currentTabataWorkout.isOnEndOfExercise()) {
        _currentState = TabataWorkoutBlocState.isFinished;
        _currentTimer?.cancel();
        return emit(TabataWorkoutFinished(tabata));
      } else if (_currentTabataWorkout.isOnEndOfCycle()) {
        _restartExerciseNumer();
        _incrementCycleNumber();
        _currentState = TabataWorkoutBlocState.isCyleResting;
        return emit(TabataWorkoutCycleRest(_currentTabataWorkout));
      } else {
        _incrementSerieNumber();
        _currentState = TabataWorkoutBlocState.isResting;
        return emit(TabataWorkoutRest(_currentTabataWorkout));
      }
    }

    emit(TabataWorkoutExercise(_currentTabataWorkout));
  }

  _tickedResting(Emitter<TabataWorkoutState> emit) {
    _decrementRestTime();
    if (_currentTabataWorkout.restTimeRemaining == 0) {
      _restartRestTime();
      _currentState = TabataWorkoutBlocState.isExercising;
      return emit(TabataWorkoutExercise(_currentTabataWorkout));
    }

    emit(TabataWorkoutRest(_currentTabataWorkout));
  }

  _tickedCycleResting(Emitter<TabataWorkoutState> emit) {
    _decrementCycleRestTime();
    if (_currentTabataWorkout.intervalTimeRemaining == 0) {
      _restartCycleRestTime();
      _currentState = TabataWorkoutBlocState.isExercising;
      return emit(TabataWorkoutExercise(_currentTabataWorkout));
    }

    emit(TabataWorkoutCycleRest(_currentTabataWorkout));
  }

  _restartPrepareTime() {
    _prepareRemainingTime = 0;
  }

  _restartExerciseTime() {
    _currentTabataWorkout.seriesTimeRemaining =
        _currentTabataWorkout.seriesTime;
  }

  _restartExerciseNumer() {
    _currentTabataWorkout.currentSeriesNumber = 1;
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
    _prepareRemainingTime -= 1;
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
        getTimeFromSeconds.execute(_currentTabataWorkout.totalTimeRemaining);
    _currentTabataWorkout.totalTimeText = getTextFromTimeUseCase.execute(time);
  }

  _incrementSerieNumber() {
    _currentTabataWorkout.currentSeriesNumber += 1;
  }

  _incrementCycleNumber() {
    _currentTabataWorkout.currentCylesNumber += 1;
  }

  TabataWorkout _getInitialTabataWorkout(Tabata tabata) {
    var seriesTime = getTimeFromTextUseCase.execute(tabata.seriesTime);
    var seriesTimeSeconds = getSecondsFromTime.execute(seriesTime);

    var restTime = getTimeFromTextUseCase.execute(tabata.restTime);
    var restTimeSeconds = getSecondsFromTime.execute(restTime);

    var intervalTime = getTimeFromTextUseCase.execute(tabata.timeBetweenCycles);
    var intervalTimeSeconds = getSecondsFromTime.execute(intervalTime);

    var seriesNumber = int.parse(tabata.seriesQuantity);
    var cylesNumber = int.parse(tabata.cycleQuantity);

    var totalTimeText = getTotalTimeUseCase.execute(tabata);
    var totalTimeInTime = getTimeFromTextUseCase.execute(totalTimeText);
    var totalTimeInSeconds = getSecondsFromTime.execute(totalTimeInTime);

    return TabataWorkout(
      false,
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
}
