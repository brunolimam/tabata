part of 'tabata_workout_bloc.dart';

class TabataWorkout {
  bool isPaused;
  final int seriesTime;
  int seriesTimeRemaining;
  final int seriesNumber;
  int currentSeriesNumber;
  final int cylesNumber;
  int currentCylesNumber;
  final int restTime;
  int restTimeRemaining;
  final int intervalTime;
  int intervalTimeRemaining;
  final int totalTime;
  int totalTimeRemaining;
  String totalTimeText;

  TabataWorkout(
    this.isPaused,
    this.seriesTime,
    this.seriesTimeRemaining,
    this.currentSeriesNumber,
    this.seriesNumber,
    this.currentCylesNumber,
    this.cylesNumber,
    this.restTime,
    this.restTimeRemaining,
    this.intervalTime,
    this.intervalTimeRemaining,
    this.totalTime,
    this.totalTimeRemaining,
    this.totalTimeText,
  );

  bool isOnEndOfCycle() {
    return seriesNumber == currentSeriesNumber && cylesNumber != 1;
  }

  bool isOnEndOfExercise() {
    return seriesNumber == currentSeriesNumber &&
        cylesNumber == currentCylesNumber;
  }
}

abstract class TabataWorkoutState {
  const TabataWorkoutState();
}

class TabataWorkoutPrepare extends TabataWorkoutState {
  final int prepareTimeRemaining;

  const TabataWorkoutPrepare({this.prepareTimeRemaining = 3});
}

class TabataWorkoutExercise extends TabataWorkoutState {
  final TabataWorkout tabataWorkout;

  const TabataWorkoutExercise(this.tabataWorkout);
}

class TabataWorkoutRest extends TabataWorkoutState {
  final TabataWorkout tabataWorkout;

  const TabataWorkoutRest(this.tabataWorkout);
}

class TabataWorkoutPause extends TabataWorkoutState {
  final TabataWorkout tabataWorkout;

  const TabataWorkoutPause(this.tabataWorkout);
}

class TabataWorkoutCycleRest extends TabataWorkoutState {
  final TabataWorkout tabataWorkout;

  const TabataWorkoutCycleRest(this.tabataWorkout);
}

class TabataWorkoutFinished extends TabataWorkoutState {
  final Tabata tabata;

  const TabataWorkoutFinished(this.tabata);
}
