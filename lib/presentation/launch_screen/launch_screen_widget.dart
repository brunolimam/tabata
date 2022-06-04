import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tabata/presentation/launch_screen/bloc/launch_screen_bloc.dart';
import 'package:tabata/utils/change_root_screen_utils.dart';
import 'package:tabata/utils/color_asset.dart';

class LaunchScreenWidget extends StatelessWidget {
  const LaunchScreenWidget({required this.launchScreenBloc, super.key});

  final LaunchScreenBloc launchScreenBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAsset.mainBackground,
      body: BlocProvider<LaunchScreenBloc>(
        create: (context) => launchScreenBloc..add(StartLaunchScreenEvent()),
        child: BlocBuilder<LaunchScreenBloc, LaunchScreenState>(
          builder: (context, state) {
            if (state is LaunchScreenInitial) {
              return Center(
                child: Lottie.asset(
                  'assets/animations/launch_screen.json',
                  width: 190,
                  height: 230,
                ),
              );
            } else if (state is LaunchScreenClose) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ChangeRootScreenUtils.changeToFirsSetup(context);
              });
              return const Text("Changing root screen");
            }

            return const Text("Something went wrong");
          },
        ),
      ),
    );
  }
}
