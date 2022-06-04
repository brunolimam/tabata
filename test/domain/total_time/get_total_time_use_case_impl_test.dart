import 'package:flutter_test/flutter_test.dart';
import 'package:tabata/domain/seconds_to_time/get_time_from_seconds_impl.dart';
import 'package:tabata/domain/text_to_time/get_time_from_text_use_case_impl.dart';
import 'package:tabata/domain/time_to_seconds/get_seconds_from_time_impl.dart';
import 'package:tabata/domain/time_to_text/get_text_from_time_use_case_impl.dart';
import 'package:tabata/domain/total_time/get_total_time_use_case_impl.dart';

void main() {
  late GetTotalTimeUseCaseImpl sut;

  setUp(() {
    GetSecondsFromTimeImpl getSecondsFromTime = GetSecondsFromTimeImpl();
    GetTimeFromTextUseCaseImpl getTimeFromTextUseCase =
        GetTimeFromTextUseCaseImpl();
    GetTimeFromSecondsImpl getTimeFromSeconds = GetTimeFromSecondsImpl();
    GetTextFromTimeUseCaseImpl getTextFromTimeUseCaseImpl =
        GetTextFromTimeUseCaseImpl();

    sut = GetTotalTimeUseCaseImpl(
      getSecondsFromTime,
      getTimeFromTextUseCase,
      getTimeFromSeconds,
      getTextFromTimeUseCaseImpl,
    );
  });

  test('execute should return [03:50]', () {
    var result = sut.execute("00:20", "8", "00:10", "1", "00:00");
    expect(result, "03:50");
  });

  test('execute should return [07:00]', () {
    var result = sut.execute("01:00", "5", "00:30", "1", "00:00");
    expect(result, "07:00");
  });

  test('execute should return [14:00]', () {
    var result = sut.execute("01:00", "5", "00:30", "2", "00:00");
    expect(result, "14:00");
  });

  test('execute should return [14:30]', () {
    var result = sut.execute("01:00", "5", "00:30", "2", "00:30");
    expect(result, "14:30");
  });

  test('execute should return [22:00]', () {
    var result = sut.execute("01:00", "5", "00:30", "3", "00:30");
    expect(result, "22:00");
  });
}
