import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tabata/injector.dart';
import 'package:tabata/presentation/launch_screen/bloc/launch_screen_bloc.dart';
import 'package:tabata/presentation/launch_screen/launch_screen_widget.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('pt')],
      path: 'assets/localizables',
      fallbackLocale: const Locale('pt'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final LaunchScreenBloc _subwayLinesBloc =
      GetIt.instance.get<LaunchScreenBloc>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: ColorAsset.mainBackground,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: LaunchScreenWidget(launchScreenBloc: _subwayLinesBloc),
    );
  }
}
