import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tabata/presentation/launch_screen/bloc/launch_screen_bloc.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:tabata/utils/change_root_screen_utils.dart';

class LaunchScreenWidget extends StatelessWidget {
  const LaunchScreenWidget({required this.launchScreenBloc, super.key});

  final LaunchScreenBloc launchScreenBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LaunchScreenBloc>(
        create: (context) => launchScreenBloc..add(StartLaunchScreenEvent()),
        child: BlocBuilder<LaunchScreenBloc, LaunchScreenState>(
          builder: (context, state) {
            if (state is LaunchScreenInitial) {
              return Center(
                child: Lottie.asset(
                  AnimationAsset.named("launch_screen"),
                  width: 190,
                  height: 230,
                ),
              );
            } else if (state is LaunchScreenGoToFirstSetup) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ChangeRootScreenUtils.changeToFirsSetup(context);
              });
              return const Text("Changing to first step screen");
            } else if (state is LaunchScreenGoToWorkout) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ChangeRootScreenUtils.changeToWorkout(context);
              });
              return const Text("Changing to workout screen");
            }

            return const Text("Something went wrong");
          },
        ),
      ),
    );
  }
}
