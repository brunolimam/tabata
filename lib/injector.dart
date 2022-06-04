import 'package:get_it/get_it.dart';
import 'package:tabata/domain/seconds_to_time/get_time_from_seconds.dart';
import 'package:tabata/domain/seconds_to_time/get_time_from_seconds_impl.dart';
import 'package:tabata/domain/text_to_time/get_time_from_text_use_case.dart';
import 'package:tabata/domain/text_to_time/get_time_from_text_use_case_impl.dart';
import 'package:tabata/domain/time_to_seconds/get_seconds_from_time.dart';
import 'package:tabata/domain/time_to_seconds/get_seconds_from_time_impl.dart';
import 'package:tabata/domain/time_to_text/get_text_from_time_use_case.dart';
import 'package:tabata/domain/time_to_text/get_text_from_time_use_case_impl.dart';
import 'package:tabata/domain/total_time/get_total_time_use_case.dart';
import 'package:tabata/domain/total_time/get_total_time_use_case_impl.dart';
import 'package:tabata/presentation/launch_screen/bloc/launch_screen_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  registerLaunchScreenDependencies();
  settingScrenDependencies();
}

Future<void> registerLaunchScreenDependencies() async {
  injector.registerFactory(() => LaunchScreenBloc());
}

Future<void> settingScrenDependencies() async {
  injector.registerFactory<GetTimeFromTextUseCase>(
    () => GetTimeFromTextUseCaseImpl(),
  );

  injector.registerFactory<GetTextFromTimeUseCase>(
    () => GetTextFromTimeUseCaseImpl(),
  );

  injector.registerFactory<GetSecondsFromTime>(
    () => GetSecondsFromTimeImpl(),
  );

  injector.registerFactory<GetTimeFromSeconds>(
    () => GetTimeFromSecondsImpl(),
  );

  injector.registerFactory<GetTotalTimeUseCase>(() => GetTotalTimeUseCaseImpl(
        injector(),
        injector(),
        injector(),
        injector(),
      ));
}
