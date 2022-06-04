import 'package:flutter_test/flutter_test.dart';
import 'package:tabata/domain/text_to_time/get_time_from_text_use_case_impl.dart';

void main() {
  late GetTimeFromTextUseCaseImpl sut;

  setUp(() {
    sut = GetTimeFromTextUseCaseImpl();
  });

  test(
    'execute when time is [00:00] should return 0 minutes and 0 seconds',
    () {
      var result = sut.execute('00:00');

      expect(result.minutes, 0);
      expect(result.seconds, 0);
    },
  );

  test(
    'execute when time is [11:53] should return 11 minutes and 53 seconds',
    () {
      var result = sut.execute('11:53');

      expect(result.minutes, 11);
      expect(result.seconds, 53);
    },
  );

  test(
    'execute when time is [59:59] should return 59 minutes and 59 seconds',
    () {
      var result = sut.execute('59:59');

      expect(result.minutes, 59);
      expect(result.seconds, 59);
    },
  );
}
