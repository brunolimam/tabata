import 'package:get_it/get_it.dart';
import 'package:tabata/presentation/launch_screen/bloc/launch_screen_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  registerLaunchScrenDependencies();
}

Future<void> registerLaunchScrenDependencies() async {
  injector.registerFactory(() => LaunchScreenBloc());
}
