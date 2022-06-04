import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabata/presentation/components/buttons/primary_button.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tabata/utils/dimens.dart';
import 'package:tabata/utils/text_sizes.dart';
import 'package:tabata/utils/text_styles.dart';

class FirstSetupWidget extends StatefulWidget {
  const FirstSetupWidget({super.key});

  @override
  State<StatefulWidget> createState() => _FirstSetupWidgetState();
}

class _FirstSetupWidgetState extends State<FirstSetupWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAsset.mainBackground,
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
            color: ColorAsset.textColor,
          ),
        )
      ],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.horizontal,
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
            const SizedBox(height: 24),
            PrimaryButton(
              title: "create_tabata".tr(),
              onPressed: _createTabata,
            )
          ],
        ),
      ),
    );
  }

  _closeSetup() {}

  _createTabata() {}
}
