import 'package:flutter_test/flutter_test.dart';
import 'package:tabata/domain/entities/Time.dart';
import 'package:tabata/domain/time_to_text/get_text_from_time_use_case_impl.dart';

void main() {
  late GetTextFromTimeUseCaseImpl sut;

  setUp(() {
    sut = GetTextFromTimeUseCaseImpl();
  });

  test(
    'execute when time is 0 minutes and 0 seconds should return [00:00]',
    () {
      var result = sut.execute(Time(0, 0));

      expect(result, "00:00");
    },
  );

  test(
    'execute when time is 11 minutes and 53 seconds should return [11:53]',
    () {
      var result = sut.execute(Time(11, 53));

      expect(result, '11:53');
    },
  );

  test(
    'execute when time is 59 minutes and 59 seconds should return [59:59]',
    () {
      var result = sut.execute(Time(59, 59));

      expect(result, '59:59');
    },
  );
}
