import 'package:get_it/get_it.dart';
import 'package:tabata/domain/text_to_time/get_time_from_text_use_case.dart';
import 'package:tabata/domain/text_to_time/get_time_from_text_use_case_impl.dart';
import 'package:tabata/domain/time_to_text/get_text_from_time_use_case.dart';
import 'package:tabata/domain/time_to_text/get_text_from_time_use_case_impl.dart';
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
}
