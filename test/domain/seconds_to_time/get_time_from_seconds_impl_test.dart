import 'package:flutter_test/flutter_test.dart';
import 'package:tabata/domain/entities/Time.dart';
import 'package:tabata/domain/seconds_to_time/get_time_from_seconds_impl.dart';

void main() {
  late GetTimeFromSecondsImpl sut;

  setUp(() {
    sut = GetTimeFromSecondsImpl();
  });

  test(
    'execute when seconds is 0 should return Time[0:0]',
    () {
      var result = sut.execute(0);
      expect(result, const Time(0, 0));
    },
  );

  test(
    'execute when seconds is 33 should return Time[0:33]',
    () {
      var result = sut.execute(33);
      expect(result, const Time(0, 33));
    },
  );

  test(
    'execute when seconds is 153 should return Time[2:33]',
    () {
      var result = sut.execute(153);
      expect(result, const Time(2, 33));
    },
  );

  test(
    'execute when seconds is 633 should return Time[10:33]',
    () {
      var result = sut.execute(633);
      expect(result, const Time(10, 33));
    },
  );
}
