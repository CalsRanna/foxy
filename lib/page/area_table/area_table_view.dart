import 'package:flutter/material.dart';
import 'package:foxy/page/area_table/area_table_detail_view_model.dart';
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
    final idInput = FormItem(
      controller: viewModel.idController,
      label: '编号',
      placeholder: 'ID',
      readOnly: true,
    );
    final nameInput = FormItem(
      controller: viewModel.nameController,
      label: '名称',
      placeholder: 'AreaName_lang_zhCN',
    );
    final continentIdInput = FormItem(
      controller: viewModel.continentIdController,
      label: '大陆',
      placeholder: 'ContinentID',
    );
    final parentAreaIdInput = FormItem(
      controller: viewModel.parentAreaIdController,
      label: '父级区域',
      placeholder: 'ParentAreaID',
    );
    final areaBitInput = FormItem(
      controller: viewModel.areaBitController,
      label: '区域掩码',
      placeholder: 'AreaBit',
    );
    final flagsInput = FormItem(
      controller: viewModel.flagsController,
      label: '标识',
      placeholder: 'Flags',
    );
    final factionGroupMaskInput = FormItem(
      controller: viewModel.factionGroupMaskController,
      label: '声望组掩码',
      placeholder: 'FactionGroupMask',
    );
    final explorationLevelInput = FormItem(
      controller: viewModel.explorationLevelController,
      label: '探索等级',
      placeholder: 'ExplorationLevel',
    );

    /// Sound
    final ambientMultiplierInput = FormItem(
      controller: viewModel.ambientMultiplierController,
      label: '环境系数',
      placeholder: 'Ambient_multiplier',
    );
    final ambienceIdInput = FormItem(
      controller: viewModel.ambienceIdController,
      label: '环境',
      placeholder: 'AmbienceID',
    );
    final zoneMusicInput = FormItem(
      controller: viewModel.zoneMusicController,
      label: '区域音乐',
      placeholder: 'ZoneMusic',
    );
    final introSoundInput = FormItem(
      controller: viewModel.introSoundController,
      label: 'IntroSound',
      placeholder: 'IntroSound',
    );
    final soundProviderPrefInput = FormItem(
      controller: viewModel.soundProviderPrefController,
      label: '音效偏好',
      placeholder: 'SoundProviderPref',
    );
    final soundProviderPrefUnderwaterInput = FormItem(
      controller: viewModel.soundProviderPrefUnderwaterController,
      label: '水下音效',
      placeholder: 'SoundProviderPrefUnderwater',
    );
    final lightIdInput = FormItem(
      controller: viewModel.lightIdController,
      label: '光线',
      placeholder: 'LightID',
    );
    final minElevationInput = FormItem(
      controller: viewModel.minElevationController,
      label: '最低海拔',
      placeholder: 'MinElevation',
    );

    /// Liquid
    final liquidTypeId0Input = FormItem(
      controller: viewModel.liquidTypeId0Controller,
      label: '液体类型0',
      placeholder: 'LiquidTypeID0',
    );
    final liquidTypeId1Input = FormItem(
      controller: viewModel.liquidTypeId1Controller,
      label: '液体类型1',
      placeholder: 'LiquidTypeID1',
    );
    final liquidTypeId2Input = FormItem(
      controller: viewModel.liquidTypeId2Controller,
      label: '液体类型2',
      placeholder: 'LiquidTypeID2',
    );
    final liquidTypeId3Input = FormItem(
      controller: viewModel.liquidTypeId3Controller,
      label: '液体类型3',
      placeholder: 'LiquidTypeID3',
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
