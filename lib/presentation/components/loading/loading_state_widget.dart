import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/text_styles.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 120),
          CircularProgressIndicator(color: ColorAsset.mainColor),
          const SizedBox(height: 16),
          Text(
            'loading'.tr(),
            style: TextStyles.titleWithSize(
              size: 18,
              color: ColorAsset.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
