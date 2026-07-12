import 'package:flutter/material.dart';
import 'package:foxy/page/area_table/area_table_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class AreaTableView extends StatefulWidget {
  final int? entry;
  const AreaTableView({super.key, this.entry});

  @override
  State<AreaTableView> createState() => _AreaTableViewState();
}

class _AreaTableViewState extends State<AreaTableView> {
  final viewModel = GetIt.instance.get<AreaTableDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(id: widget.entry);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Basic
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        fieldController: viewModel.idController,
        readOnly: true,
      ),
    );
    final nameInput = FoxyFormItem(
      label: '名称',
      child: Watch((_) {
        final id = viewModel.area.value.id;
        return FoxyLocalePicker(
          entry: id == 0 ? null : id,
          fieldController: viewModel.nameController,
          title: '区域名称本地化',
          placeholder: 'AreaName_lang_zhCN',
          delegate: FoxyLocalePickerDelegates.dbcAreaTableAreaName,
          onSaved: viewModel.applyAreaNameLocales,
        );
      }),
    );
    final continentIdInput = FoxyFormItem(
      label: '大陆',
      child: FoxyNumberInput<int>(
        placeholder: 'ContinentID',
        fieldController: viewModel.continentIdController,
      ),
    );
    final parentAreaIdInput = FoxyFormItem(
      label: '父级区域',
      child: FoxyNumberInput<int>(
        placeholder: 'ParentAreaID',
        fieldController: viewModel.parentAreaIdController,
      ),
    );
    final areaBitInput = FoxyFormItem(
      label: '区域掩码',
      child: FoxyNumberInput<int>(
        placeholder: 'AreaBit',
        fieldController: viewModel.areaBitController,
      ),
    );
    final flagsInput = FoxyFormItem(
      label: '标识',
      child: FoxyNumberInput<int>(
        placeholder: 'Flags',
        fieldController: viewModel.flagsController,
      ),
    );
    final factionGroupMaskInput = FoxyFormItem(
      label: '声望组掩码',
      child: FoxyNumberInput<int>(
        placeholder: 'FactionGroupMask',
        fieldController: viewModel.factionGroupMaskController,
      ),
    );
    final explorationLevelInput = FoxyFormItem(
      label: '探索等级',
      child: FoxyNumberInput<int>(
        placeholder: 'ExplorationLevel',
        fieldController: viewModel.explorationLevelController,
      ),
    );

    /// Sound
    final ambientMultiplierInput = FoxyFormItem(
      label: '环境系数',
      child: FoxyNumberInput<double>(
        placeholder: 'Ambient_multiplier',
        fieldController: viewModel.ambientMultiplierController,
      ),
    );
    final ambienceIdInput = FoxyFormItem(
      label: '环境',
      child: FoxyNumberInput<int>(
        placeholder: 'AmbienceID',
        fieldController: viewModel.ambienceIdController,
      ),
    );
    final zoneMusicInput = FoxyFormItem(
      label: '区域音乐',
      child: FoxyNumberInput<int>(
        placeholder: 'ZoneMusic',
        fieldController: viewModel.zoneMusicController,
      ),
    );
    final introSoundInput = FoxyFormItem(
      label: 'IntroSound',
      child: FoxyNumberInput<int>(
        placeholder: 'IntroSound',
        fieldController: viewModel.introSoundController,
      ),
    );
    final soundProviderPrefInput = FoxyFormItem(
      label: '音效偏好',
      child: FoxyNumberInput<int>(
        placeholder: 'SoundProviderPref',
        fieldController: viewModel.soundProviderPrefController,
      ),
    );
    final soundProviderPrefUnderwaterInput = FoxyFormItem(
      label: '水下音效',
      child: FoxyNumberInput<int>(
        placeholder: 'SoundProviderPrefUnderwater',
        fieldController: viewModel.soundProviderPrefUnderwaterController,
      ),
    );
    final lightIdInput = FoxyFormItem(
      label: '光线',
      child: FoxyNumberInput<int>(
        placeholder: 'LightID',
        fieldController: viewModel.lightIdController,
      ),
    );
    final minElevationInput = FoxyFormItem(
      label: '最低海拔',
      child: FoxyNumberInput<double>(
        placeholder: 'MinElevation',
        fieldController: viewModel.minElevationController,
      ),
    );

    /// Liquid
    final liquidTypeId0Input = FoxyFormItem(
      label: '液体类型0',
      child: FoxyNumberInput<int>(
        placeholder: 'LiquidTypeID0',
        fieldController: viewModel.liquidTypeId0Controller,
      ),
    );
    final liquidTypeId1Input = FoxyFormItem(
      label: '液体类型1',
      child: FoxyNumberInput<int>(
        placeholder: 'LiquidTypeID1',
        fieldController: viewModel.liquidTypeId1Controller,
      ),
    );
    final liquidTypeId2Input = FoxyFormItem(
      label: '液体类型2',
      child: FoxyNumberInput<int>(
        placeholder: 'LiquidTypeID2',
        fieldController: viewModel.liquidTypeId2Controller,
      ),
    );
    final liquidTypeId3Input = FoxyFormItem(
      label: '液体类型3',
      child: FoxyNumberInput<int>(
        placeholder: 'LiquidTypeID3',
        fieldController: viewModel.liquidTypeId3Controller,
      ),
    );

    /// 1. 基本信息
    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: idInput),
          Expanded(child: nameInput),
          Expanded(child: continentIdInput),
          Expanded(child: parentAreaIdInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: areaBitInput),
          Expanded(child: flagsInput),
          Expanded(child: factionGroupMaskInput),
          Expanded(child: explorationLevelInput),
        ],
      ),
    ];

    /// 2. 环境与音效
    final soundRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: ambienceIdInput),
          Expanded(child: ambientMultiplierInput),
          Expanded(child: zoneMusicInput),
          Expanded(child: introSoundInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: soundProviderPrefInput),
          Expanded(child: soundProviderPrefUnderwaterInput),
          Expanded(child: lightIdInput),
          Expanded(child: minElevationInput),
        ],
      ),
    ];

    /// 3. 液体类型
    final liquidRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: liquidTypeId0Input),
          Expanded(child: liquidTypeId1Input),
          Expanded(child: liquidTypeId2Input),
          Expanded(child: liquidTypeId3Input),
        ],
      ),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(title: '基本信息', children: basicRows),
          FoxyFormSection(title: '环境与音效', children: soundRows),
          FoxyFormSection(title: '液体类型', children: liquidRows),
          Row(
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: Text('保存'),
              ),
              const SizedBox(width: 8),
              ShadButton.ghost(
                onPressed: () => viewModel.pop(),
                child: Text('取消'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
