import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/usecases/tabata/get_current_tabata_use_case.dart';
import 'package:tabata/domain/usecases/tabata/set_current_tabata_use_case.dart';
import 'package:tabata/domain/usecases/total_time/get_total_time_use_case.dart';
import 'package:tabata/presentation/components/buttons/primary_button.dart';
import 'package:tabata/presentation/components/gestures/gesture_tap.dart';
import 'package:tabata/presentation/components/loading/loading_state_widget.dart';
import 'package:tabata/presentation/components/tabata/tabata_item_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tabata/presentation/main/tabata/bloc/tabata_bloc.dart';
import 'package:tabata/presentation/main/tabata_workout/bloc/tabata_workout_bloc.dart';
import 'package:tabata/presentation/main/tabata_workout/tabata_workout_widget.dart';
import 'package:tabata/presentation/settings/settings_widget.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/dimens.dart';
import 'package:tabata/utils/navigator_utils.dart';
import 'package:tabata/utils/text_styles.dart';

class TabataWidget extends StatefulWidget {
  final TabataBloc tabataBloc;

  const TabataWidget({
    required this.tabataBloc,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _TabataWidgetState();
}

class _TabataWidgetState extends State<TabataWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider<TabataBloc>(
      create: (context) => widget.tabataBloc..add(GetCurrentTabataEvent()),
      child: BlocBuilder<TabataBloc, TabataState>(builder: (context, state) {
        if (state is CurrentTabataLoading) {
          return const LoadingStateWidget();
        } else if (state is CurrentTabataDone) {
          return _body(state.tabata, state.totalTime);
        }

        return const Text('Something went wrong');
      }),
    ));
  }

  Widget _body(Tabata tabata, String totalTime) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.largeHorizontal),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildHeader(
                  tabata,
                  totalTime,
                ),
                const Spacer(),
                _buildContent(tabata),
                const Spacer(),
                PrimaryButton(
                  title: 'edit_tabata'.tr(),
                  onPressed: _editTabata,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        Divider(
          height: 2,
          color: ColorAsset.blackDivider,
        ),
      ],
    );
  }

  Widget _buildHeader(Tabata tabata, String totalTime) {
    return Row(
      children: [
        TabataItemHeader(
          iconName: IconsAsset.named('serie'),
          title: 'series'.tr(),
          value: tabata.seriesQuantity,
        ),
        const Spacer(),
        TabataItemHeader(
          iconName: IconsAsset.named('ciclos'),
          title: 'cycles'.tr(),
          value: tabata.cycleQuantity,
        ),
        const Spacer(),
        TabataItemHeader(
          iconName: IconsAsset.named('total'),
          title: 'total_time'.tr(),
          value: totalTime,
        ),
      ],
    );
  }

  Widget _buildContent(Tabata tabata) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Lottie.asset(
          AnimationAsset.named("workout_total_time"),
          width: 280,
          animate: false,
        ),
        Lottie.asset(
          AnimationAsset.named("workout_serie_time"),
          width: 268,
          animate: false,
        ),
        GestureTap(
          onPressed: () => _startTabataWorkout(tabata),
          child: Column(
            children: [
              SvgPicture.asset(
                IconsAsset.named("play"),
                color: ColorAsset.textColor,
              ),
              const SizedBox(height: 24),
              Text(
                'tap_to_play'.tr(),
                style: TextStyles.titleWithSize(
                  size: 18,
                  weight: FontWeight.w700,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  _editTabata() {
    GetIt getIt = GetIt.instance;

    NavigatorUtils.navigate(
      context,
      SettingsWidget(
        isEditing: true,
        getTotalTimeUseCase: getIt.get<GetTotalTimeUseCase>(),
        getCurrentTabataUseCase: getIt.get<GetCurrentTabataUseCase>(),
        setCurrentTabataUseCase: getIt.get<SetCurrentTabataUseCase>(),
      ),
    );
  }

  _startTabataWorkout(Tabata tabata) {
    GetIt getIt = GetIt.instance;
    TabataWorkoutBloc tabataWorkoutBloc =
        getIt<TabataWorkoutBloc>(param1: tabata);
    NavigatorUtils.navigate(
      context,
      TabataWorkoutWidget(
        tabata: tabata,
        tabataWorkoutBloc: tabataWorkoutBloc,
      ),
    );
  }
}
