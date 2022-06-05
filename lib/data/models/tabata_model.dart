import 'package:tabata/domain/entities/tabata.dart';

class TabataModel extends Tabata {
  const TabataModel({
    required super.seriesTime,
    required super.seriesQuantity,
    required super.restTime,
    required super.cycleQuantity,
    required super.timeBetweenCycles,
  });

  TabataModel.map(Map<String, dynamic> map)
      : super(
          seriesTime: map["seriesTime"],
          seriesQuantity: map["seriesQuantity"],
          restTime: map["restTime"],
          cycleQuantity: map["cycleQuantity"],
          timeBetweenCycles: map["timeBetweenCycles"],
        );

  Map<String, dynamic> toJson() {
    return {
      "seriesTime": seriesTime,
      "seriesQuantity": seriesQuantity,
      "restTime": restTime,
      "cycleQuantity": cycleQuantity,
      "timeBetweenCycles": timeBetweenCycles
    };
  }
}
