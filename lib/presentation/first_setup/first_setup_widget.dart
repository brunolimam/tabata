import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:tabata/domain/usecases/auth/create_anonymous_user_use_case.dart';
import 'package:tabata/domain/usecases/tabata/get_current_tabata_use_case.dart';
import 'package:tabata/domain/usecases/tabata/set_current_tabata_use_case.dart';
import 'package:tabata/domain/usecases/total_time/get_total_time_use_case.dart';
import 'package:tabata/presentation/components/bottom_sheets/alert_bottom_sheet.dart';
import 'package:tabata/presentation/components/buttons/primary_button.dart';
import 'package:tabata/presentation/settings/settings_widget.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tabata/utils/dimens.dart';
import 'package:tabata/utils/navigator_utils.dart';
import 'package:tabata/utils/text_sizes.dart';
import 'package:tabata/utils/text_styles.dart';

class FirstSetupWidget extends StatefulWidget {
  final GetIt _getIt = GetIt.instance;
  final CreateAnonymousUserUseCase createAnonymousUserUseCase;

  FirstSetupWidget({
    required this.createAnonymousUserUseCase,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _FirstSetupWidgetState();
}

class _FirstSetupWidgetState extends State<FirstSetupWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await widget.createAnonymousUserUseCase.execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildHeader(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        SvgPicture.asset(
          ImagesAsset.named("first_setup_workout"),
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
          top: 42,
          child: IconButton(
            onPressed: _closeSetup,
            icon: const Icon(Icons.close),
            color: ColorAsset.iconColor,
          ),
        )
      ],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.largeHorizontal,
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Text(
              "first_setup_workout_title".tr(),
              style: TextStyles.titleWithSize(
                size: TextSizes.title,
                weight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "first_setup_workout_subtitle".tr(),
              style: TextStyles.titleWithSize(
                size: TextSizes.subTitle,
                weight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 44),
            PrimaryButton(
              title: "create_tabata".tr(),
              onPressed: _createTabata,
            )
          ],
        ),
      ),
    );
  }

  _closeSetup() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AlertBottomSheet(
          title: "cancel_confirm_title".tr(),
          subtitle: "cancel_confirm_subtitle".tr(),
          mainButtonTitle: "leave".tr(),
          secondaryButtonTitle: "back".tr(),
          confirmation: () {},
        );
      },
    );
  }

  _createTabata() {
    NavigatorUtils.navigate(
      context,
      SettingsWidget(
        getTotalTimeUseCase: widget._getIt.get<GetTotalTimeUseCase>(),
        getCurrentTabataUseCase: widget._getIt.get<GetCurrentTabataUseCase>(),
        setCurrentTabataUseCase: widget._getIt.get<SetCurrentTabataUseCase>(),
      ),
    );
  }
}
