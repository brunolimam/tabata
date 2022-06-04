import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabata/presentation/components/fields/settings_field/setting_field_state.dart';
import 'package:tabata/presentation/components/gestures/gesture_tap.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/text_styles.dart';

class SettingField extends StatelessWidget {
  final String iconName;
  final String title;
  final String value;
  final VoidCallback onPressed;
  final SettingsFieldState state;

  const SettingField({
    required this.iconName,
    required this.title,
    required this.value,
    required this.onPressed,
    this.state = SettingsFieldState.enabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius radius = const BorderRadius.all(Radius.circular(16.0));

    Widget fieldContent = ClipRRect(
      borderRadius: radius,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _getBorderColor()),
          borderRadius: radius,
        ),
        child: ColoredBox(
          color: _getBackgroundColor(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SvgPicture.asset(
                  iconName,
                  color: _getIconColor(),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyles.titleWithSize(
                    size: 16,
                    color: _getTextColor(),
                  ),
                ),
                const Spacer(),
                Text(
                  value,
                  style: TextStyles.titleWithSize(
                    size: 18,
                    weight: FontWeight.w700,
                    color: _getTextColor(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return state == SettingsFieldState.enabled
        ? GestureTap(
            onPressed: () {
              if (state != SettingsFieldState.enabled) return;
              onPressed();
            },
            child: fieldContent,
          )
        : fieldContent;
  }

  Color _getBackgroundColor() {
    switch (state) {
      case SettingsFieldState.enabled:
        return ColorAsset.secondaryBackground;
      case SettingsFieldState.disable:
        return ColorAsset.disabledFieldColor;
      case SettingsFieldState.nonEditable:
        return Colors.transparent;
    }
  }

  Color _getIconColor() {
    switch (state) {
      case SettingsFieldState.enabled:
      case SettingsFieldState.nonEditable:
        return ColorAsset.secondaryColor;
      case SettingsFieldState.disable:
        return ColorAsset.disabledTextFieldColor;
    }
  }

  Color _getTextColor() {
    switch (state) {
      case SettingsFieldState.enabled:
        return ColorAsset.textColor;
      case SettingsFieldState.disable:
        return ColorAsset.disabledTextFieldColor;
      case SettingsFieldState.nonEditable:
        return ColorAsset.secondaryColor;
    }
  }

  Color _getBorderColor() {
    switch (state) {
      case SettingsFieldState.enabled:
      case SettingsFieldState.disable:
        return Colors.transparent;
      case SettingsFieldState.nonEditable:
        return ColorAsset.secondaryBackground;
    }
  }
}
