import 'package:flutter/material.dart';
import 'package:tabata/presentation/components/buttons/primary_button.dart';
import 'package:tabata/presentation/components/pickers/main_number_picker.dart';
import 'package:tabata/utils/color_asset.dart';
import 'package:tabata/utils/dimens.dart';
import 'package:tabata/utils/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';

class ValueBottomSheet extends StatefulWidget {
  final String title;
  final String value;
  final Function(String) onSelectValue;

  const ValueBottomSheet({
    required this.title,
    required this.value,
    required this.onSelectValue,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ValueBottomSheetState();
}

class _ValueBottomSheetState extends State<ValueBottomSheet> {
  int _value = 0;

  @override
  void initState() {
    _value = int.parse(widget.value);
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
            _buildValuePicker(),
            const Spacer(),
            PrimaryButton(title: "select".tr(), onPressed: _selectValue),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildValuePicker() {
    return MainAppPicker(
      title: "",
      minValue: 1,
      maxValue: 100,
      value: _value,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
    );
  }

  _selectValue() {
    String value = _value.toString();
    widget.onSelectValue(value);
    Navigator.pop(context);
  }
}
