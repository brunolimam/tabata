import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tabata/injector.dart';
import 'package:tabata/presentation/launch_screen/bloc/launch_screen_bloc.dart';
import 'package:tabata/presentation/launch_screen/launch_screen_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();
  runApp(MyApp());
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
      ),
      home: LaunchScreenWidget(launchScreenBloc: _subwayLinesBloc),
    );
  }
}
