import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tabata/data/repositories/auth/create_anonymous_user_repository_impl.dart';
import 'package:tabata/data/repositories/auth/current_user/get_current_user_repository_impl.dart';
import 'package:tabata/data/repositories/tabata/get_current_tabata_repository_impl.dart';
import 'package:tabata/data/repositories/tabata/set_current_tabata_repository_impl.dart';
import 'package:tabata/data/services/auth/create_anonymous_user_service.dart';
import 'package:tabata/data/services/auth/create_anonymous_user_service_impl.dart';
import 'package:tabata/data/services/auth/current_user/get_current_user_service.dart';
import 'package:tabata/data/services/auth/current_user/get_current_user_service_impl.dart';
import 'package:tabata/data/services/tabata/get_current_tabata_service.dart';
import 'package:tabata/data/services/tabata/get_current_tabata_service_impl.dart';
import 'package:tabata/data/services/tabata/set_current_tabata_service.dart';
import 'package:tabata/data/services/tabata/set_current_tabata_service_impl.dart';
import 'package:tabata/domain/repositories/create_anonymous_user_repository.dart';
import 'package:tabata/domain/repositories/get_current_tabata_repository.dart';
import 'package:tabata/domain/repositories/get_current_user_repository.dart';
import 'package:tabata/domain/repositories/set_current_tabata_repository.dart';
import 'package:tabata/domain/usecases/auth/create_anonymous_user_use_case.dart';
import 'package:tabata/domain/usecases/auth/create_anonymous_user_use_case_impl.dart';
import 'package:tabata/domain/usecases/auth/is_user_authenticated_use_case.dart';
import 'package:tabata/domain/usecases/auth/is_user_authenticated_use_case_impl.dart';
import 'package:tabata/domain/usecases/seconds_to_time/get_time_from_seconds.dart';
import 'package:tabata/domain/usecases/seconds_to_time/get_time_from_seconds_impl.dart';
import 'package:tabata/domain/usecases/tabata/get_current_tabata_use_case.dart';
import 'package:tabata/domain/usecases/tabata/get_current_tabata_use_case_impl.dart';
import 'package:tabata/domain/usecases/tabata/set_current_tabata_use_case.dart';
import 'package:tabata/domain/usecases/tabata/set_current_tabata_use_case_impl.dart';
import 'package:tabata/domain/usecases/text_to_time/get_time_from_text_use_case.dart';
import 'package:tabata/domain/usecases/text_to_time/get_time_from_text_use_case_impl.dart';
import 'package:tabata/domain/usecases/time_to_seconds/get_seconds_from_time.dart';
import 'package:tabata/domain/usecases/time_to_seconds/get_seconds_from_time_impl.dart';
import 'package:tabata/domain/usecases/time_to_text/get_text_from_time_use_case.dart';
import 'package:tabata/domain/usecases/time_to_text/get_text_from_time_use_case_impl.dart';
import 'package:tabata/domain/usecases/total_time/get_total_time_use_case.dart';
import 'package:tabata/domain/usecases/total_time/get_total_time_use_case_impl.dart';
import 'package:tabata/presentation/launch_screen/bloc/launch_screen_bloc.dart';
import 'package:tabata/presentation/main/tabata/bloc/tabata_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  registerFirebaseSingletons();
  registerLaunchScreenDependencies();
  registerFirstSetupScreenDependencies();
  settingScreenDependencies();
  tabataScreenDependencies();
}

Future<void> registerFirebaseSingletons() async {
  injector.registerSingleton(FirebaseAuth.instance);
  injector.registerSingleton(FirebaseFirestore.instance);
}

Future<void> registerLaunchScreenDependencies() async {
  injector.registerFactory<GetCurrentUserService>(
      () => GetCurrentUserServiceImpl(injector()));
  injector.registerFactory<GetCurrentUserRepository>(
      () => GetCurrentUserRepositoryImpl(injector()));
  injector.registerFactory<IsUserAuthenticatedUseCase>(
      () => IsUserAuthenticatedUseCaseImpl(injector()));
  injector.registerFactory(() => LaunchScreenBloc(injector()));
}

Future<void> registerFirstSetupScreenDependencies() async {
  injector.registerFactory<CreateAnonymousUserService>(
      () => CreateAnonymousUserServiceImpl(injector()));
  injector.registerFactory<CreateAnonymousUserRepository>(
      () => CreateAnonymousUserRepositoryImpl(injector()));
  injector.registerFactory<CreateAnonymousUserUseCase>(
      () => CreateAnonymousUserUseCaseImpl(injector()));
}

Future<void> settingScreenDependencies() async {
  injector.registerFactory<GetTimeFromTextUseCase>(
      () => GetTimeFromTextUseCaseImpl());
  injector.registerFactory<GetTextFromTimeUseCase>(
      () => GetTextFromTimeUseCaseImpl());
  injector.registerFactory<GetSecondsFromTime>(() => GetSecondsFromTimeImpl());
  injector.registerFactory<GetTimeFromSeconds>(() => GetTimeFromSecondsImpl());

  injector.registerFactory<GetCurrentTabataService>(
      () => GetCurrentTabataServiceImpl(injector()));
  injector.registerFactory<GetCurrentTabataRepository>(
      () => GetCurrentTabataRepositoryImpl(injector(), injector()));
  injector.registerFactory<GetCurrentTabataUseCase>(
      () => GetCurrentTabataUseCaseImpl(injector()));

  injector.registerFactory<SetCurrentTabataService>(
      () => SetCurrentTabataServiceImpl(injector()));
  injector.registerFactory<SetCurrentTabataRepository>(
      () => SetCurrentTabataRepositoryImpl(injector(), injector()));
  injector.registerFactory<SetCurrentTabataUseCase>(
      () => SetCurrentTabataUseCaseImpl(injector()));

  injector.registerFactory<GetTotalTimeUseCase>(() => GetTotalTimeUseCaseImpl(
        injector(),
        injector(),
        injector(),
        injector(),
      ));
}

Future<void> tabataScreenDependencies() async {
  injector.registerFactory(() => TabataBloc(injector(), injector()));
}
