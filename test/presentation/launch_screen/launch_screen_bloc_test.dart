import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tabata/presentation/launch_screen/bloc/launch_screen_bloc.dart';

void main() {
  late LaunchScreenBloc _launchScreenBlock;

  setUp(() {
    _launchScreenBlock = LaunchScreenBloc();
  });

  test('initial state should be', () async {
    await expectLater(_launchScreenBlock.state, initial);
  });

  blocTest<LaunchScreenBloc, LaunchScreenState>(
      'emits [close] when StartLaunchScreenEvent is added.',
      build: () => _launchScreenBlock,
      act: (bloc) => bloc.add(
            StartLaunchScreenEvent(
              loadTime: const Duration(seconds: 0),
            ),
          ),
      expect: () => [initial, close]);
}

const initial = TypeMatcher<LaunchScreenInitial>();
const close = TypeMatcher<LaunchScreenClose>();
