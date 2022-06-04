import 'package:flutter_test/flutter_test.dart';
import 'package:tabata/domain/entities/Time.dart';
import 'package:tabata/domain/time_to_seconds/get_seconds_from_time_impl.dart';

void main() {
  late GetSecondsFromTimeImpl sut;

  setUp(() {
    sut = GetSecondsFromTimeImpl();
  });

  test(
    'execute when time is 0 minutes and 0 seconds should return 0 seconds',
    () {
      var result = sut.execute(Time(0, 0));

      expect(result, 0);
    },
  );

  test(
    'execute when time is 0 minutes and 33 seconds should return 33 seconds',
    () {
      var result = sut.execute(Time(0, 33));

      expect(result, 33);
    },
  );

  test(
    'execute when time is 2 minutes and 33 seconds should return 153 seconds',
    () {
      var result = sut.execute(Time(2, 33));

      expect(result, 153);
    },
  );
}
