import 'package:tabata/domain/entities/Time.dart';
import 'package:tabata/domain/time_to_seconds/get_seconds_from_time.dart';

class GetSecondsFromTimeImpl extends GetSecondsFromTime {
  @override
  int execute(Time time) {
    return time.minutes * 60 + time.seconds;
  }
}
