import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:tabata/presentation/main/tabata/bloc/tabata_bloc.dart';
import 'package:tabata/presentation/main/tabata/tabata_widget.dart';
import 'package:tabata/presentation/main/workouts/workouts_widget.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/text_styles.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<StatefulWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int _currentBottomNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorAsset.mainBackground,
        currentIndex: _currentBottomNavigationIndex,
        selectedLabelStyle: TextStyles.titleWithSize(
          size: 10,
          weight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyles.titleWithSize(
          size: 10,
          weight: FontWeight.w500,
        ),
        selectedItemColor: ColorAsset.textColor,
        unselectedItemColor: ColorAsset.secondaryTextColor,
        onTap: _updateSelectedTab,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              IconsAsset.named('tabata_option'),
            ),
            label: 'tabata'.tr(),
            activeIcon: SvgPicture.asset(
              IconsAsset.named('tabata_option_selected'),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              IconsAsset.named('history_option'),
            ),
            label: 'workouts'.tr(),
            activeIcon: SvgPicture.asset(
              IconsAsset.named('history_option_selected'),
            ),
          ),
        ],
      ),
    );
  }

  _updateSelectedTab(int index) {
    setState(() {
      _currentBottomNavigationIndex = index;
    });
  }

  Widget _getCurrentBody() {
    GetIt getIt = GetIt.instance;
    TabataBloc tabataBloc = getIt.get<TabataBloc>();

    switch (_currentBottomNavigationIndex) {
      case 0:
        return TabataWidget(tabataBloc: tabataBloc);
      case 1:
        return const WorkoutsWidget();
    }

    return TabataWidget(tabataBloc: tabataBloc);
  }
}
