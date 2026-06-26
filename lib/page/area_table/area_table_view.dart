import 'package:flutter/material.dart';
import 'package:foxy/page/area_table/area_table_detail_view_model.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
  final idInput = FormItem(label: '编号', child: FoxyNumberInput<int>(placeholder: 'ID', value: viewModel.id.value, onChanged:(v) => viewModel.id.value = v, readOnly: true));
    final nameInput = FormItem(controller: viewModel.nameController, label: '名称', placeholder: 'AreaName_lang_zhCN');
  final continentIdInput = FormItem(label: '大陆', child: FoxyNumberInput<int>(placeholder: 'ContinentID', value: viewModel.continentId.value, onChanged:(v) => viewModel.continentId.value = v));
  final parentAreaIdInput = FormItem(label: '父级区域', child: FoxyNumberInput<int>(placeholder: 'ParentAreaID', value: viewModel.parentAreaId.value, onChanged:(v) => viewModel.parentAreaId.value = v));
  final areaBitInput = FormItem(label: '区域掩码', child: FoxyNumberInput<int>(placeholder: 'AreaBit', value: viewModel.areaBit.value, onChanged:(v) => viewModel.areaBit.value = v));
  final flagsInput = FormItem(label: '标识', child: FoxyNumberInput<int>(placeholder: 'Flags', value: viewModel.flags.value, onChanged:(v) => viewModel.flags.value = v));
  final factionGroupMaskInput = FormItem(label: '声望组掩码', child: FoxyNumberInput<int>(placeholder: 'FactionGroupMask', value: viewModel.factionGroupMask.value, onChanged:(v) => viewModel.factionGroupMask.value = v));
  final explorationLevelInput = FormItem(label: '探索等级', child: FoxyNumberInput<int>(placeholder: 'ExplorationLevel', value: viewModel.explorationLevel.value, onChanged:(v) => viewModel.explorationLevel.value = v));

    /// Sound
  final ambientMultiplierInput = FormItem(label: '环境系数', child: FoxyNumberInput<double>(placeholder: 'Ambient_multiplier', value: viewModel.ambientMultiplier.value, onChanged:(v) => viewModel.ambientMultiplier.value = v));
  final ambienceIdInput = FormItem(label: '环境', child: FoxyNumberInput<int>(placeholder: 'AmbienceID', value: viewModel.ambienceId.value, onChanged:(v) => viewModel.ambienceId.value = v));
  final zoneMusicInput = FormItem(label: '区域音乐', child: FoxyNumberInput<int>(placeholder: 'ZoneMusic', value: viewModel.zoneMusic.value, onChanged:(v) => viewModel.zoneMusic.value = v));
  final introSoundInput = FormItem(label: 'IntroSound', child: FoxyNumberInput<int>(placeholder: 'IntroSound', value: viewModel.introSound.value, onChanged:(v) => viewModel.introSound.value = v));
  final soundProviderPrefInput = FormItem(label: '音效偏好', child: FoxyNumberInput<int>(placeholder: 'SoundProviderPref', value: viewModel.soundProviderPref.value, onChanged:(v) => viewModel.soundProviderPref.value = v));
  final soundProviderPrefUnderwaterInput = FormItem(label: '水下音效', child: FoxyNumberInput<int>(placeholder: 'SoundProviderPrefUnderwater', value: viewModel.soundProviderPrefUnderwater.value, onChanged:(v) => viewModel.soundProviderPrefUnderwater.value = v));
  final lightIdInput = FormItem(label: '光线', child: FoxyNumberInput<int>(placeholder: 'LightID', value: viewModel.lightId.value, onChanged:(v) => viewModel.lightId.value = v));
  final minElevationInput = FormItem(label: '最低海拔', child: FoxyNumberInput<double>(placeholder: 'MinElevation', value: viewModel.minElevation.value, onChanged:(v) => viewModel.minElevation.value = v));

    /// Liquid
  final liquidTypeId0Input = FormItem(label: '液体类型0', child: FoxyNumberInput<int>(placeholder: 'LiquidTypeID0', value: viewModel.liquidTypeId0.value, onChanged:(v) => viewModel.liquidTypeId0.value = v));
  final liquidTypeId1Input = FormItem(label: '液体类型1', child: FoxyNumberInput<int>(placeholder: 'LiquidTypeID1', value: viewModel.liquidTypeId1.value, onChanged:(v) => viewModel.liquidTypeId1.value = v));
  final liquidTypeId2Input = FormItem(label: '液体类型2', child: FoxyNumberInput<int>(placeholder: 'LiquidTypeID2', value: viewModel.liquidTypeId2.value, onChanged:(v) => viewModel.liquidTypeId2.value = v));
  final liquidTypeId3Input = FormItem(label: '液体类型3', child: FoxyNumberInput<int>(placeholder: 'LiquidTypeID3', value: viewModel.liquidTypeId3.value, onChanged:(v) => viewModel.liquidTypeId3.value = v));

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
          // 基本信息
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('基本信息'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: basicRows),
          ),
          // 环境与音效
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('环境与音效'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: soundRows),
          ),
          // 液体类型
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('液体类型'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: liquidRows),
          ),
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
