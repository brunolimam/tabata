import 'package:tabata/domain/seconds_to_time/get_time_from_seconds.dart';
import 'package:tabata/domain/text_to_time/get_time_from_text_use_case.dart';
import 'package:tabata/domain/time_to_seconds/get_seconds_from_time.dart';
import 'package:tabata/domain/time_to_text/get_text_from_time_use_case.dart';
import 'package:tabata/domain/total_time/get_total_time_use_case.dart';

class GetTotalTimeUseCaseImpl extends GetTotalTimeUseCase {
  final GetSecondsFromTime _getSecondsFromTime;
  final GetTimeFromTextUseCase _getTimeFromTextUseCase;
  final GetTimeFromSeconds _getTimeFromSeconds;
  final GetTextFromTimeUseCase _getTextFromTimeUseCase;

  GetTotalTimeUseCaseImpl(
      this._getSecondsFromTime,
      this._getTimeFromTextUseCase,
      this._getTimeFromSeconds,
      this._getTextFromTimeUseCase);

  @override
  String execute(
    String seriesTime,
    String seriesQuantity,
    String restTime,
    String cycleQuantity,
    String timeBetweenCycles,
  ) {
    var timeOfseries = _getTimeFromTextUseCase.execute(seriesTime);
    var seriesTimeInSeconds = _getSecondsFromTime.execute(timeOfseries);

    var timeOfRest = _getTimeFromTextUseCase.execute(restTime);
    var restTimeInSeconds = _getSecondsFromTime.execute(timeOfRest);

    var timeOfBetweenCycles =
        _getTimeFromTextUseCase.execute(timeBetweenCycles);
    var timeBetweenCyclesInSeconds =
        _getSecondsFromTime.execute(timeOfBetweenCycles);

    var seriesQuantityValue = int.parse(seriesQuantity);
    var cycleQuantityValue = int.parse(cycleQuantity);

    var totalBySeries = (seriesTimeInSeconds * seriesQuantityValue);
    var totalByRest = (restTimeInSeconds * (seriesQuantityValue - 1));
    var totalPerCycle = totalBySeries + totalByRest;

    var totalByCycleRest =
        (timeBetweenCyclesInSeconds * (cycleQuantityValue - 1));

    int totalTimeInSeconds;
    if (cycleQuantityValue == 1) {
      totalTimeInSeconds = totalPerCycle;
    } else {
      totalTimeInSeconds =
          (totalPerCycle * cycleQuantityValue) + totalByCycleRest;
    }

    var totalInTime = _getTimeFromSeconds.execute(totalTimeInSeconds);
    return _getTextFromTimeUseCase.execute(totalInTime);
  }
}