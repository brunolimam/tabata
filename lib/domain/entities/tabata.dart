import 'package:equatable/equatable.dart';

class Tabata extends Equatable {
  final String seriesTime;
  final String seriesQuantity;
  final String restTime;
  final String cycleQuantity;
  final String timeBetweenCycles;

  const Tabata({
    required this.seriesTime,
    required this.seriesQuantity,
    required this.restTime,
    required this.cycleQuantity,
    required this.timeBetweenCycles,
  });

  const Tabata.defaultValue()
      : this(
          seriesTime: "00:20",
          seriesQuantity: "8",
          restTime: "00:10",
          cycleQuantity: "1",
          timeBetweenCycles: "00:00",
        );

  @override
  List<Object?> get props => [
        seriesTime,
        seriesQuantity,
        restTime,
        cycleQuantity,
        timeBetweenCycles,
      ];
}
