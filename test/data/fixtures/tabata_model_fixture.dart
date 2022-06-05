import 'package:tabata/data/models/tabata_model.dart';

extension TabataModelFixture on TabataModel {
  static TabataModel fixture({
    String seriesTime = '00:00',
    String seriesQuantity = '0',
    String restTime = '00:00',
    String cycleQuantity = '0',
    String timeBetweenCycles = '00:00',
  }) {
    return TabataModel(
      seriesTime: seriesTime,
      seriesQuantity: seriesQuantity,
      restTime: restTime,
      cycleQuantity: cycleQuantity,
      timeBetweenCycles: timeBetweenCycles,
    );
  }
}
