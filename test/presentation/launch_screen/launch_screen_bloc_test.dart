import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabata/domain/usecases/auth/is_user_authenticated_use_case_impl.dart';
import 'package:tabata/presentation/launch_screen/bloc/launch_screen_bloc.dart';

import 'launch_screen_bloc_test.mocks.dart';

@GenerateMocks([IsUserAuthenticatedUseCaseImpl])
void main() {
  late LaunchScreenBloc launchScreenBlock;
  late MockIsUserAuthenticatedUseCaseImpl isUserAuthenticatedUseCase;

  setUp(() {
    isUserAuthenticatedUseCase = MockIsUserAuthenticatedUseCaseImpl();
    launchScreenBlock = LaunchScreenBloc(isUserAuthenticatedUseCase);
  });

  test('initial state should be', () async {
    await expectLater(launchScreenBlock.state, initial);
  });

  blocTest<LaunchScreenBloc, LaunchScreenState>(
    'emits [goToWorkout] when StartLaunchScreenEvent is added and user is authenticated.',
    build: () => launchScreenBlock,
    setUp: () {
      when(isUserAuthenticatedUseCase.execute()).thenReturn(true);
    },
    act: (bloc) => bloc.add(
      StartLaunchScreenEvent(
        loadTime: const Duration(seconds: 0),
      ),
    ),
    expect: () => [initial, goToWorkout],
  );

  blocTest<LaunchScreenBloc, LaunchScreenState>(
    'emits [goToFirstSetup] when StartLaunchScreenEvent is added and user is not authenticated.',
    build: () => launchScreenBlock,
    setUp: () {
      when(isUserAuthenticatedUseCase.execute()).thenReturn(false);
    },
    act: (bloc) => bloc.add(
      StartLaunchScreenEvent(
        loadTime: const Duration(seconds: 0),
      ),
    ),
    expect: () => [initial, goToFirstSetup],
  );
}

const initial = TypeMatcher<LaunchScreenInitial>();
const goToWorkout = TypeMatcher<LaunchScreenGoToWorkout>();
const goToFirstSetup = TypeMatcher<LaunchScreenGoToFirstSetup>();
