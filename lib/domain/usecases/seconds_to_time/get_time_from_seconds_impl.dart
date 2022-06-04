import 'package:tabata/domain/entities/Time.dart';
import 'package:tabata/domain/usecases/seconds_to_time/get_time_from_seconds.dart';

class GetTimeFromSecondsImpl extends GetTimeFromSeconds {
  @override
  Time execute(int value) {
    var minutes = value ~/ 60;
    var seconds = value % 60;

    return Time(minutes, seconds);
  }
}
