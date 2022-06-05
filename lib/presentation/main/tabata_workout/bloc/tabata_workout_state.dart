part of 'tabata_workout_bloc.dart';

class TabataWorkout {
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
    return seriesNumber == currentCylesNumber && cylesNumber != 1;
  }

  bool isOnEndOfExercise() {
    return seriesNumber == currentCylesNumber &&
        cylesNumber == currentCylesNumber;
  }
}

abstract class TabataWorkoutState extends Equatable {
  const TabataWorkoutState();

  @override
  List<Object> get props => [];
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

class TabataWorkoutInterval extends TabataWorkoutState {
  final TabataWorkout tabataWorkout;

  const TabataWorkoutInterval(this.tabataWorkout);
}
