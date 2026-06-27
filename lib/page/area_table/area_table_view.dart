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
  final idInput = FormItem(label: '编号', child: FoxyNumberInput<int>(placeholder: 'ID', controller: viewModel.idController, readOnly: true));
    final nameInput = FormItem(controller: viewModel.nameController, label: '名称', placeholder: 'AreaName_lang_zhCN');
  final continentIdInput = FormItem(label: '大陆', child: FoxyNumberInput<int>(placeholder: 'ContinentID', controller: viewModel.continentIdController));
  final parentAreaIdInput = FormItem(label: '父级区域', child: FoxyNumberInput<int>(placeholder: 'ParentAreaID', controller: viewModel.parentAreaIdController));
  final areaBitInput = FormItem(label: '区域掩码', child: FoxyNumberInput<int>(placeholder: 'AreaBit', controller: viewModel.areaBitController));
  final flagsInput = FormItem(label: '标识', child: FoxyNumberInput<int>(placeholder: 'Flags', controller: viewModel.flagsController));
  final factionGroupMaskInput = FormItem(label: '声望组掩码', child: FoxyNumberInput<int>(placeholder: 'FactionGroupMask', controller: viewModel.factionGroupMaskController));
  final explorationLevelInput = FormItem(label: '探索等级', child: FoxyNumberInput<int>(placeholder: 'ExplorationLevel', controller: viewModel.explorationLevelController));

    /// Sound
  final ambientMultiplierInput = FormItem(label: '环境系数', child: FoxyNumberInput<double>(placeholder: 'Ambient_multiplier', controller: viewModel.ambientMultiplierController));
  final ambienceIdInput = FormItem(label: '环境', child: FoxyNumberInput<int>(placeholder: 'AmbienceID', controller: viewModel.ambienceIdController));
  final zoneMusicInput = FormItem(label: '区域音乐', child: FoxyNumberInput<int>(placeholder: 'ZoneMusic', controller: viewModel.zoneMusicController));
  final introSoundInput = FormItem(label: 'IntroSound', child: FoxyNumberInput<int>(placeholder: 'IntroSound', controller: viewModel.introSoundController));
  final soundProviderPrefInput = FormItem(label: '音效偏好', child: FoxyNumberInput<int>(placeholder: 'SoundProviderPref', controller: viewModel.soundProviderPrefController));
  final soundProviderPrefUnderwaterInput = FormItem(label: '水下音效', child: FoxyNumberInput<int>(placeholder: 'SoundProviderPrefUnderwater', controller: viewModel.soundProviderPrefUnderwaterController));
  final lightIdInput = FormItem(label: '光线', child: FoxyNumberInput<int>(placeholder: 'LightID', controller: viewModel.lightIdController));
  final minElevationInput = FormItem(label: '最低海拔', child: FoxyNumberInput<double>(placeholder: 'MinElevation', controller: viewModel.minElevationController));

    /// Liquid
  final liquidTypeId0Input = FormItem(label: '液体类型0', child: FoxyNumberInput<int>(placeholder: 'LiquidTypeID0', controller: viewModel.liquidTypeId0Controller));
  final liquidTypeId1Input = FormItem(label: '液体类型1', child: FoxyNumberInput<int>(placeholder: 'LiquidTypeID1', controller: viewModel.liquidTypeId1Controller));
  final liquidTypeId2Input = FormItem(label: '液体类型2', child: FoxyNumberInput<int>(placeholder: 'LiquidTypeID2', controller: viewModel.liquidTypeId2Controller));
  final liquidTypeId3Input = FormItem(label: '液体类型3', child: FoxyNumberInput<int>(placeholder: 'LiquidTypeID3', controller: viewModel.liquidTypeId3Controller));

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
