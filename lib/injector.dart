import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tabata/data/repositories/auth/create_anonymous_user_repository_impl.dart';
import 'package:tabata/data/repositories/auth/current_user/get_current_user_repository_impl.dart';
import 'package:tabata/data/repositories/tabata/get_current_tabata_repository_impl.dart';
import 'package:tabata/data/repositories/tabata/set_current_tabata_repository_impl.dart';
import 'package:tabata/data/repositories/workout/add_workout_repository_impl.dart';
import 'package:tabata/data/repositories/workout/delete_workout_repository_impl.dart';
import 'package:tabata/data/repositories/workout/load_workouts_repository_impl.dart';
import 'package:tabata/data/services/auth/create_anonymous_user_service.dart';
import 'package:tabata/data/services/auth/create_anonymous_user_service_impl.dart';
import 'package:tabata/data/services/auth/current_user/get_current_user_service.dart';
import 'package:tabata/data/services/auth/current_user/get_current_user_service_impl.dart';
import 'package:tabata/data/services/tabata/get_current_tabata_service.dart';
import 'package:tabata/data/services/tabata/get_current_tabata_service_impl.dart';
import 'package:tabata/data/services/tabata/set_current_tabata_service.dart';
import 'package:tabata/data/services/tabata/set_current_tabata_service_impl.dart';
import 'package:tabata/data/services/workout/add_workout_service.dart';
import 'package:tabata/data/services/workout/add_workout_service_impl.dart';
import 'package:tabata/data/services/workout/delete_workout_service.dart';
import 'package:tabata/data/services/workout/delete_workout_service_impl.dart';
import 'package:tabata/data/services/workout/load_workouts_service.dart';
import 'package:tabata/data/services/workout/load_workouts_service_impl.dart';
import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/repositories/add_workout_repository.dart';
import 'package:tabata/domain/repositories/create_anonymous_user_repository.dart';
import 'package:tabata/domain/repositories/delete_workout_repository.dart';
import 'package:tabata/domain/repositories/get_current_tabata_repository.dart';
import 'package:tabata/domain/repositories/get_current_user_repository.dart';
import 'package:tabata/domain/repositories/load_workouts_repository.dart';
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
import 'package:tabata/domain/usecases/workout/add_workout_use_case.dart';
import 'package:tabata/domain/usecases/workout/add_workout_use_case_impl.dart';
import 'package:tabata/domain/usecases/workout/delete_workout_use_case.dart';
import 'package:tabata/domain/usecases/workout/delete_workout_use_case_impl.dart';
import 'package:tabata/domain/usecases/workout/get_workouts_use_case.dart';
import 'package:tabata/domain/usecases/workout/get_workouts_use_case_impl.dart';
import 'package:tabata/presentation/launch_screen/bloc/launch_screen_bloc.dart';
import 'package:tabata/presentation/main/tabata/bloc/tabata_bloc.dart';
import 'package:tabata/presentation/main/tabata_workout/bloc/tabata_workout_bloc.dart';
import 'package:tabata/presentation/main/workouts/bloc/workouts_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  registerFirebaseSingletons();
  registerLaunchScreenDependencies();
  registerFirstSetupScreenDependencies();
  settingScreenDependencies();
  tabataScreenDependencies();
  tabataWorkoutScreenDependencies();
  workoutFeedbackScreenDependencies();
  workoutsScreenDependencies();
  workoutDetailScreenDependencies();
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

Future<void> tabataWorkoutScreenDependencies() async {
  injector.registerFactoryParam<TabataWorkoutBloc, Tabata, dynamic>(
    (param1, param2) => TabataWorkoutBloc(
      tabata: param1,
      getSecondsFromTime: injector(),
      getTextFromTimeUseCase: injector(),
      getTimeFromSeconds: injector(),
      getTimeFromTextUseCase: injector(),
      getTotalTimeUseCase: injector(),
    ),
  );
}

Future<void> workoutFeedbackScreenDependencies() async {
  injector.registerFactory<AddWorkoutUseCase>(
      () => AddWorkoutUseCaseImpl(injector()));
  injector.registerFactory<AddWorkoutRepository>(
      () => AddWorkoutRepositoryImpl(injector(), injector()));
  injector.registerFactory<AddWorkoutService>(
      () => AddWorkoutServiceImpl(injector()));
}

Future<void> workoutsScreenDependencies() async {
  injector.registerFactory<GetWorkoutsUseCase>(
      () => GetWorkoutsUseCaseImpl(injector()));
  injector.registerFactory<LoadWorkoutsRepository>(
      () => LoadWorkoutsRepositoryImpl(injector(), injector()));
  injector.registerFactory<LoadWorkoutsService>(
      () => LoadWorkoutsServiceImpl(injector()));

  injector.registerFactory(() => WorkoutsBloc(injector()));
}

Future<void> workoutDetailScreenDependencies() async {
  injector.registerFactory<DeleteWorkoutService>(
      () => DeleteWorkoutServiceImpl(injector()));
  injector.registerFactory<DeleteWorkoutRepository>(
      () => DeleteWorkoutRepositoryImpl(injector()));
  injector.registerFactory<DeleteWorkoutUseCase>(
      () => DeleteWorkoutUseCaseImpl(injector()));
}
