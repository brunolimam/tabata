import 'package:flutter_test/flutter_test.dart';
import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/usecases/seconds_to_time/get_time_from_seconds_impl.dart';
import 'package:tabata/domain/usecases/text_to_time/get_time_from_text_use_case_impl.dart';
import 'package:tabata/domain/usecases/time_to_seconds/get_seconds_from_time_impl.dart';
import 'package:tabata/domain/usecases/time_to_text/get_text_from_time_use_case_impl.dart';
import 'package:tabata/domain/usecases/total_time/get_total_time_use_case_impl.dart';

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
    Tabata tabata = const Tabata(
      seriesTime: "00:20",
      seriesQuantity: "8",
      restTime: "00:10",
      cycleQuantity: "1",
      timeBetweenCycles: "00:00",
    );

    var result = sut.execute(tabata);
    expect(result, "03:50");
  });

  test('execute should return [07:00]', () {
    Tabata tabata = const Tabata(
      seriesTime: "01:00",
      seriesQuantity: "5",
      restTime: "00:30",
      cycleQuantity: "1",
      timeBetweenCycles: "00:00",
    );

    var result = sut.execute(tabata);
    expect(result, "07:00");
  });

  test('execute should return [14:00]', () {
    Tabata tabata = const Tabata(
      seriesTime: "01:00",
      seriesQuantity: "5",
      restTime: "00:30",
      cycleQuantity: "2",
      timeBetweenCycles: "00:00",
    );

    var result = sut.execute(tabata);
    expect(result, "14:00");
  });

  test('execute should return [14:30]', () {
    Tabata tabata = const Tabata(
      seriesTime: "01:00",
      seriesQuantity: "5",
      restTime: "00:30",
      cycleQuantity: "2",
      timeBetweenCycles: "00:30",
    );

    var result = sut.execute(tabata);
    expect(result, "14:30");
  });

  test('execute should return [22:00]', () {
    Tabata tabata = const Tabata(
      seriesTime: "01:00",
      seriesQuantity: "5",
      restTime: "00:30",
      cycleQuantity: "3",
      timeBetweenCycles: "00:30",
    );

    var result = sut.execute(tabata);
    expect(result, "22:00");
  });
}
