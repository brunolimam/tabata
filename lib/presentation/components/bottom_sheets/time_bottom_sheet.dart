import 'package:flutter/material.dart';
import 'package:tabata/domain/entities/Time.dart';
import 'package:tabata/domain/text_to_time/get_time_from_text_use_case.dart';
import 'package:tabata/domain/time_to_text/get_text_from_time_use_case.dart';
import 'package:tabata/presentation/components/buttons/primary_button.dart';
import 'package:tabata/presentation/components/pickers/main_number_picker.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/dimens.dart';
import 'package:tabata/utils/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';

class TimeBottomSheet extends StatefulWidget {
  final GetTimeFromTextUseCase getTimeFromTextUseCase;
  final GetTextFromTimeUseCase getTextFromTimeUseCase;
  final String title;
  final String value;
  final Function(String) onSelectValue;

  const TimeBottomSheet({
    required this.getTimeFromTextUseCase,
    required this.getTextFromTimeUseCase,
    required this.title,
    required this.value,
    required this.onSelectValue,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _TimeBottomSheetState();
}

class _TimeBottomSheetState extends State<TimeBottomSheet> {
  int _minutesValue = 0;
  int _secondsValue = 0;

  @override
  void initState() {
    Time time = widget.getTimeFromTextUseCase.execute(widget.value);
    _minutesValue = time.minutes;
    _secondsValue = time.seconds == 0 ? 1 : time.seconds;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ColorAsset.mainBackground,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.largeHorizontal,
        ),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Text(
              widget.title,
              style: TextStyles.titleWithSize(
                size: 18,
                weight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildMinutesPicker(),
                const SizedBox(width: 14),
                _buildTimeDivider(),
                const SizedBox(width: 14),
                _buildSecondsPicker(),
              ],
            ),
            const Spacer(),
            PrimaryButton(title: "select".tr(), onPressed: _selectTime),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMinutesPicker() {
    return MainAppPicker(
      title: "minutes".tr(),
      minValue: 0,
      maxValue: 59,
      value: _minutesValue,
      onChanged: (value) {
        setState(() {
          _minutesValue = value;
        });
      },
    );
  }

  Widget _buildSecondsPicker() {
    return MainAppPicker(
      title: "seconds".tr(),
      minValue: 1,
      maxValue: 59,
      value: _secondsValue,
      onChanged: (value) {
        setState(() {
          _secondsValue = value;
        });
      },
    );
  }

  Widget _buildTimeDivider() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          ":",
          style: TextStyles.titleWithSize(
            size: 24,
            weight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  _selectTime() {
    Time time = Time(_minutesValue, _secondsValue);
    String value = widget.getTextFromTimeUseCase.execute(time);
    widget.onSelectValue(value);
    Navigator.pop(context);
  }
}
