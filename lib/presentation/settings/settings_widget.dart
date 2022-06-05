import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/usecases/tabata/get_current_tabata_use_case.dart';
import 'package:tabata/domain/usecases/tabata/set_current_tabata_use_case.dart';
import 'package:tabata/domain/usecases/text_to_time/get_time_from_text_use_case.dart';
import 'package:tabata/domain/usecases/time_to_text/get_text_from_time_use_case.dart';
import 'package:tabata/domain/usecases/total_time/get_total_time_use_case.dart';
import 'package:tabata/presentation/components/bars/close_title_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tabata/presentation/components/bottom_sheets/alert_bottom_sheet.dart';
import 'package:tabata/presentation/components/bottom_sheets/time_bottom_sheet.dart';
import 'package:tabata/presentation/components/bottom_sheets/value_bottom_sheet.dart';
import 'package:tabata/presentation/components/buttons/primary_button.dart';
import 'package:tabata/presentation/components/fields/settings_field/setting_field.dart';
import 'package:tabata/presentation/components/fields/settings_field/setting_field_state.dart';
import 'package:tabata/utils/asset_load.dart';
import 'package:tabata/utils/change_root_screen_utils.dart';
import 'package:tabata/utils/dimens.dart';
import 'package:tabata/utils/text_styles.dart';

class SettingsWidget extends StatefulWidget {
  final GetTotalTimeUseCase getTotalTimeUseCase;
  final GetCurrentTabataUseCase getCurrentTabataUseCase;
  final SetCurrentTabataUseCase setCurrentTabataUseCase;

  const SettingsWidget({
    required this.getTotalTimeUseCase,
    required this.getCurrentTabataUseCase,
    required this.setCurrentTabataUseCase,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  final _seriesTimeController = TextEditingController();
  final _seriesQuantityController = TextEditingController();
  final _restTimeController = TextEditingController();
  final _cyclesQuantityController = TextEditingController();
  final _timeBetweenCyclesController = TextEditingController();

  final GetIt _getIt = GetIt.instance;

  @override
  void initState() {
    super.initState();
    _seriesTimeController.text = "00:20";
    _seriesQuantityController.text = "8";
    _restTimeController.text = "00:10";
    _cyclesQuantityController.text = "1";
    _timeBetweenCyclesController.text = "00:00";

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Tabata tabata = await widget.getCurrentTabataUseCase.execute();

      setState(() {
        _seriesTimeController.text = tabata.seriesTime;
        _seriesQuantityController.text = tabata.seriesQuantity;
        _restTimeController.text = tabata.restTime;
        _cyclesQuantityController.text = tabata.cycleQuantity;
        _timeBetweenCyclesController.text = tabata.timeBetweenCycles;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CloseTitleBar(
            title: "settings".tr(),
            closeCallback: () {
              _closeSetup();
            },
          ),
          const SizedBox(height: 24),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.horizontal,
        ),
        child: Column(children: [
          _buildHeaderInfo(),
          const SizedBox(height: 16),
          SettingField(
            iconName: IconsAsset.named("tempo_serie"),
            title: "series_time".tr(),
            value: _seriesTimeController.text,
            onPressed: _editSeriesTime,
          ),
          const SizedBox(height: 8),
          SettingField(
            iconName: IconsAsset.named("serie"),
            title: "series_quantity".tr(),
            value: _seriesQuantityController.text,
            onPressed: _editSeriesQuantity,
          ),
          const SizedBox(height: 8),
          SettingField(
            iconName: IconsAsset.named("tempo_descanso"),
            title: "rest_time".tr(),
            value: _restTimeController.text,
            onPressed: _editRestTime,
          ),
          const SizedBox(height: 8),
          SettingField(
            iconName: IconsAsset.named("ciclos"),
            title: "cycles_quantity".tr(),
            value: _cyclesQuantityController.text,
            onPressed: _editCylesQuantity,
          ),
          const SizedBox(height: 8),
          SettingField(
            iconName: IconsAsset.named("intervalo"),
            title: "time_between_cicles".tr(),
            value: _timeBetweenCyclesController.text,
            onPressed: _editTimeBetweenCycles,
            state: timeBetweenCyclesFieldState(),
          ),
          const SizedBox(height: 8),
          SettingField(
            iconName: IconsAsset.named("total"),
            title: "total_time".tr(),
            value: _totalTime(),
            onPressed: () {},
            state: SettingsFieldState.nonEditable,
          ),
          const Spacer(),
          PrimaryButton(
            title: "next".tr(),
            onPressed: _saveSettings,
          ),
          const SizedBox(height: 44),
        ]),
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(IconsAsset.named("info")),
        const SizedBox(
          width: 10,
        ),
        Text(
          "settings_header_title".tr(),
          style: TextStyles.titleWithSize(size: 16),
        )
      ],
    );
  }

  _editSeriesTime() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return TimeBottomSheet(
          getTimeFromTextUseCase: _getIt.get<GetTimeFromTextUseCase>(),
          getTextFromTimeUseCase: _getIt.get<GetTextFromTimeUseCase>(),
          title: "series_time".tr(),
          value: _seriesTimeController.text,
          onSelectValue: (value) {
            setState(() {
              _seriesTimeController.text = value;
            });
          },
        );
      },
    );
  }

  _editSeriesQuantity() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ValueBottomSheet(
          title: "series_quantity".tr(),
          value: _seriesQuantityController.text,
          onSelectValue: (value) {
            setState(() {
              _seriesQuantityController.text = value;
            });
          },
        );
      },
    );
  }

  _editRestTime() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return TimeBottomSheet(
          getTimeFromTextUseCase: _getIt.get<GetTimeFromTextUseCase>(),
          getTextFromTimeUseCase: _getIt.get<GetTextFromTimeUseCase>(),
          title: "rest_time".tr(),
          value: _restTimeController.text,
          onSelectValue: (value) {
            setState(() {
              _restTimeController.text = value;
            });
          },
        );
      },
    );
  }

  _editCylesQuantity() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ValueBottomSheet(
          title: "cycles_quantity".tr(),
          value: _cyclesQuantityController.text,
          onSelectValue: (value) {
            setState(() {
              _cyclesQuantityController.text = value;
            });
          },
        );
      },
    );
  }

  _editTimeBetweenCycles() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return TimeBottomSheet(
          getTimeFromTextUseCase: _getIt.get<GetTimeFromTextUseCase>(),
          getTextFromTimeUseCase: _getIt.get<GetTextFromTimeUseCase>(),
          title: "time_between_cicles".tr(),
          value: _timeBetweenCyclesController.text,
          onSelectValue: (value) {
            setState(() {
              _timeBetweenCyclesController.text = value;
            });
          },
        );
      },
    );
  }

  SettingsFieldState timeBetweenCyclesFieldState() {
    var cyclesQuantity = int.parse(_cyclesQuantityController.text);
    return cyclesQuantity > 1
        ? SettingsFieldState.enabled
        : SettingsFieldState.disable;
  }

  String _totalTime() {
    return widget.getTotalTimeUseCase.execute(
      _seriesTimeController.text,
      _seriesQuantityController.text,
      _restTimeController.text,
      _cyclesQuantityController.text,
      _timeBetweenCyclesController.text,
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

  _saveSettings() async {
    Tabata tabata = Tabata(
      seriesTime: _seriesTimeController.text,
      seriesQuantity: _seriesQuantityController.text,
      restTime: _restTimeController.text,
      cycleQuantity: _cyclesQuantityController.text,
      timeBetweenCycles: _timeBetweenCyclesController.text,
    );

    await widget.setCurrentTabataUseCase.execute(tabata);
    ChangeRootScreenUtils.changeToWorkout(context);
  }
}
