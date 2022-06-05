import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/usecases/seconds_to_time/get_time_from_seconds_impl.dart';
import 'package:tabata/domain/usecases/text_to_time/get_time_from_text_use_case_impl.dart';
import 'package:tabata/domain/usecases/time_to_seconds/get_seconds_from_time_impl.dart';
import 'package:tabata/domain/usecases/time_to_text/get_text_from_time_use_case_impl.dart';
import 'package:tabata/domain/usecases/total_time/get_total_time_use_case_impl.dart';
import 'package:tabata/presentation/main/tabata_workout/bloc/tabata_workout_bloc.dart';

void main() {
  Tabata tabata = const Tabata(
    seriesTime: "00:20",
    seriesQuantity: "3",
    restTime: "00:10",
    cycleQuantity: "2",
    timeBetweenCycles: "00:20",
  );

  late TabataWorkoutBloc sut;

  setUp(() {
    GetSecondsFromTimeImpl getSecondsFromTime = GetSecondsFromTimeImpl();
    GetTimeFromTextUseCaseImpl getTimeFromTextUseCase =
        GetTimeFromTextUseCaseImpl();
    GetTimeFromSecondsImpl getTimeFromSeconds = GetTimeFromSecondsImpl();
    GetTextFromTimeUseCaseImpl getTextFromTimeUseCase =
        GetTextFromTimeUseCaseImpl();
    GetTotalTimeUseCaseImpl getTotalTimeUseCase = GetTotalTimeUseCaseImpl(
      getSecondsFromTime,
      getTimeFromTextUseCase,
      getTimeFromSeconds,
      getTextFromTimeUseCase,
    );

    sut = TabataWorkoutBloc(
      tabata: tabata,
      getTimeFromTextUseCase: getTimeFromTextUseCase,
      getSecondsFromTime: getSecondsFromTime,
      getTotalTimeUseCase: getTotalTimeUseCase,
      getTimeFromSeconds: getTimeFromSeconds,
      getTextFromTimeUseCase: getTextFromTimeUseCase,
      tickerDuration: const Duration(seconds: 0),
    );
  });

  test('state should be preparing', () async {
    await expectLater(sut.state, prepare);
  });

  test('state should be preparing', () async {
    await expectLater(sut.state, prepare);
  });

  // blocTest<TabataWorkoutBloc, TabataWorkoutState>(
  //   'emits [goToFirstSetup] when StartLaunchScreenEvent is added and user is not authenticated.',
  //   build: () => sut,
  //   act: (bloc) => bloc.add(StartTabataWorkoutEvent()),
  //   expect: () => [
  //     prepare,
  //     exercise,
  //     rest,
  //     exercise,
  //     rest,
  //     exercise,
  //     cycleRest,
  //     exercise,
  //     rest,
  //     exercise,
  //     rest,
  //     exercise,
  //     finished
  //   ],
  // );
}

const prepare = TypeMatcher<TabataWorkoutPrepare>();
const exercise = TypeMatcher<TabataWorkoutExercise>();
const rest = TypeMatcher<TabataWorkoutRest>();
const cycleRest = TypeMatcher<TabataWorkoutCycleRest>();
const finished = TypeMatcher<TabataWorkoutFinished>();
