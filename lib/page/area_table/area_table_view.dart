import 'package:flutter/material.dart';
import 'package:foxy/constant/area_table_constants.dart';
import 'package:foxy/page/area_table/area_table_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class AreaTableView extends StatelessWidget {
  final AreaTableDetailViewModel viewModel;

  const AreaTableView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    /// Basic
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
      ),
    );
    final nameInput = FoxyFormItem(
      label: '名称',
      child: Watch((_) {
        final id = viewModel.persistedKey.value?.id;
        return FoxyLocalePicker(
          entry: id,
          controller: viewModel.nameController,
          title: '区域名称本地化',
          placeholder: 'AreaName_lang_zhCN',
          delegate: FoxyLocalePickerDelegates.dbcAreaTableAreaName,
          onSaved: viewModel.applyAreaNameLocales,
        );
      }),
    );
    final continentIdInput = FoxyFormItem(
      label: '地图',
      child: FoxyEntityPicker(
        placeholder: 'ContinentID',
        controller: viewModel.continentIdController,
        delegate: FoxyEntityPickerDelegates.map,
      ),
    );
    final parentAreaIdInput = FoxyFormItem(
      label: '父级区域',
      child: FoxyEntityPicker(
        placeholder: 'ParentAreaID',
        controller: viewModel.parentAreaIdController,
        delegate: FoxyEntityPickerDelegates.areaTable,
      ),
    );
    final areaBitInput = FoxyFormItem(
      label: '探索位索引',
      child: FoxyNumberInput<int>(
        placeholder: 'AreaBit',
        controller: viewModel.areaBitController,
      ),
    );
    final flagsInput = FoxyFormItem(
      label: '区域标志',
      child: FoxyFlagPicker(
        placeholder: 'Flags',
        controller: viewModel.flagsController,
        flags: kAreaFlagOptions,
        title: '区域标志',
      ),
    );
    final factionGroupMaskInput = FoxyFormItem(
      label: '区域阵营',
      child: FoxyIntShadSelect(
        controller: viewModel.factionGroupMaskController,
        options: kAreaTeamOptions,
        placeholder: const Text('FactionGroupMask'),
      ),
    );
    final explorationLevelInput = FoxyFormItem(
      label: '探索等级',
      child: FoxyNumberInput<int>(
        placeholder: 'ExplorationLevel',
        controller: viewModel.explorationLevelController,
      ),
    );
    final areaNameLangFlagsInput = FoxyFormItem(
      label: '名称语言标志',
      child: FoxyNumberInput<int>(
        placeholder: 'AreaName_lang_Flags',
        controller: viewModel.areaNameLangFlagsController,
      ),
    );

    /// Sound
    final ambientMultiplierInput = FoxyFormItem(
      label: '环境系数',
      child: FoxyNumberInput<double>(
        placeholder: 'Ambient_multiplier',
        controller: viewModel.ambientMultiplierController,
      ),
    );
    final ambienceIdInput = FoxyFormItem(
      label: '环境声音',
      child: FoxyEntityPicker(
        placeholder: 'AmbienceID',
        controller: viewModel.ambienceIdController,
        delegate: FoxyEntityPickerDelegates.soundAmbience,
      ),
    );
    final zoneMusicInput = FoxyFormItem(
      label: '区域音乐',
      child: FoxyEntityPicker(
        placeholder: 'ZoneMusic',
        controller: viewModel.zoneMusicController,
        delegate: FoxyEntityPickerDelegates.zoneMusic,
      ),
    );
    final introSoundInput = FoxyFormItem(
      label: '进入音乐',
      child: FoxyEntityPicker(
        placeholder: 'IntroSound',
        controller: viewModel.introSoundController,
        delegate: FoxyEntityPickerDelegates.zoneIntroMusic,
      ),
    );
    final soundProviderPrefInput = FoxyFormItem(
      label: '声音提供器偏好',
      child: FoxyEntityPicker(
        placeholder: 'SoundProviderPref',
        controller: viewModel.soundProviderPrefController,
        delegate: FoxyEntityPickerDelegates.soundProviderPreferences,
      ),
    );
    final soundProviderPrefUnderwaterInput = FoxyFormItem(
      label: '水下声音提供器偏好',
      child: FoxyEntityPicker(
        placeholder: 'SoundProviderPrefUnderwater',
        controller: viewModel.soundProviderPrefUnderwaterController,
        delegate: FoxyEntityPickerDelegates.soundProviderPreferences,
      ),
    );
    final lightIdInput = FoxyFormItem(
      label: '光照',
      child: FoxyEntityPicker(
        placeholder: 'LightID',
        controller: viewModel.lightIdController,
        delegate: FoxyEntityPickerDelegates.light,
      ),
    );
    final minElevationInput = FoxyFormItem(
      label: '最低海拔',
      child: FoxyNumberInput<double>(
        placeholder: 'MinElevation',
        controller: viewModel.minElevationController,
      ),
    );

    /// Liquid
    final liquidTypeId0Input = FoxyFormItem(
      label: '水覆盖',
      child: FoxyEntityPicker(
        placeholder: 'LiquidTypeID0',
        controller: viewModel.liquidTypeId0Controller,
        delegate: FoxyEntityPickerDelegates.liquidType,
      ),
    );
    final liquidTypeId1Input = FoxyFormItem(
      label: '海洋覆盖',
      child: FoxyEntityPicker(
        placeholder: 'LiquidTypeID1',
        controller: viewModel.liquidTypeId1Controller,
        delegate: FoxyEntityPickerDelegates.liquidType,
      ),
    );
    final liquidTypeId2Input = FoxyFormItem(
      label: '岩浆覆盖',
      child: FoxyEntityPicker(
        placeholder: 'LiquidTypeID2',
        controller: viewModel.liquidTypeId2Controller,
        delegate: FoxyEntityPickerDelegates.liquidType,
      ),
    );
    final liquidTypeId3Input = FoxyFormItem(
      label: '软泥覆盖',
      child: FoxyEntityPicker(
        placeholder: 'LiquidTypeID3',
        controller: viewModel.liquidTypeId3Controller,
        delegate: FoxyEntityPickerDelegates.liquidType,
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
      Row(
        spacing: 8,
        children: [
          Expanded(child: areaNameLangFlagsInput),
          const Expanded(child: SizedBox()),
          const Expanded(child: SizedBox()),
          const Expanded(child: SizedBox()),
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
