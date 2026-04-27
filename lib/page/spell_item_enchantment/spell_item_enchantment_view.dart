import 'package:flutter/material.dart';
import 'package:foxy/page/spell_item_enchantment/spell_item_enchantment_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SpellItemEnchantmentView extends StatefulWidget {
  final int? entry;
  const SpellItemEnchantmentView({super.key, this.entry});

  @override
  State<SpellItemEnchantmentView> createState() =>
      _SpellItemEnchantmentViewState();
}

class _SpellItemEnchantmentViewState extends State<SpellItemEnchantmentView> {
  final viewModel = GetIt.instance.get<SpellItemEnchantmentDetailViewModel>();

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
      placeholder: 'Name_lang_zhCN',
    );
    final chargesInput = FormItem(
      controller: viewModel.chargesController,
      label: '充能次数',
      placeholder: 'Charges',
    );

    /// Effect row 0
    final effect0Input = FormItem(
      controller: viewModel.effect0Controller,
      label: 'Effect0',
      placeholder: 'Effect0',
    );
    final effectPointsMin0Input = FormItem(
      controller: viewModel.effectPointsMin0Controller,
      label: 'EffectPointsMin0',
      placeholder: 'EffectPointsMin0',
    );
    final effectPointsMax0Input = FormItem(
      controller: viewModel.effectPointsMax0Controller,
      label: 'EffectPointsMax0',
      placeholder: 'EffectPointsMax0',
    );
    final effectArg0Input = FormItem(
      controller: viewModel.effectArg0Controller,
      label: 'EffectArg0',
      placeholder: 'EffectArg0',
    );

    /// Effect row 1
    final effect1Input = FormItem(
      controller: viewModel.effect1Controller,
      label: 'Effect1',
      placeholder: 'Effect1',
    );
    final effectPointsMin1Input = FormItem(
      controller: viewModel.effectPointsMin1Controller,
      label: 'EffectPointsMin1',
      placeholder: 'EffectPointsMin1',
    );
    final effectPointsMax1Input = FormItem(
      controller: viewModel.effectPointsMax1Controller,
      label: 'EffectPointsMax1',
      placeholder: 'EffectPointsMax1',
    );
    final effectArg1Input = FormItem(
      controller: viewModel.effectArg1Controller,
      label: 'EffectArg1',
      placeholder: 'EffectArg1',
    );

    /// Effect row 2
    final effect2Input = FormItem(
      controller: viewModel.effect2Controller,
      label: 'Effect2',
      placeholder: 'Effect2',
    );
    final effectPointsMin2Input = FormItem(
      controller: viewModel.effectPointsMin2Controller,
      label: 'EffectPointsMin2',
      placeholder: 'EffectPointsMin2',
    );
    final effectPointsMax2Input = FormItem(
      controller: viewModel.effectPointsMax2Controller,
      label: 'EffectPointsMax2',
      placeholder: 'EffectPointsMax2',
    );
    final effectArg2Input = FormItem(
      controller: viewModel.effectArg2Controller,
      label: 'EffectArg2',
      placeholder: 'EffectArg2',
    );

    /// Other
    final itemVisualInput = FormItem(
      controller: viewModel.itemVisualController,
      label: 'ItemVisual',
      placeholder: 'ItemVisual',
    );
    final flagsInput = FormItem(
      controller: viewModel.flagsController,
      label: 'Flags',
      placeholder: 'Flags',
    );
    final srcItemIdInput = FormItem(
      controller: viewModel.srcItemIdController,
      label: 'Src_itemID',
      placeholder: 'Src_itemID',
    );
    final conditionIdInput = FormItem(
      controller: viewModel.conditionIdController,
      label: 'Condition_ID',
      placeholder: 'Condition_ID',
    );
    final requiredSkillIdInput = FormItem(
      controller: viewModel.requiredSkillIdController,
      label: 'RequiredSkillID',
      placeholder: 'RequiredSkillID',
    );
    final requiredSkillRankInput = FormItem(
      controller: viewModel.requiredSkillRankController,
      label: 'RequiredSkillRank',
      placeholder: 'RequiredSkillRank',
    );
    final minLevelInput = FormItem(
      controller: viewModel.minLevelController,
      label: 'MinLevel',
      placeholder: 'MinLevel',
    );

    /// 1. 基本信息
    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: idInput),
          Expanded(child: nameInput),
          Expanded(child: chargesInput),
        ],
      ),
    ];

    /// 2. 效果信息（3 行）
    final effectRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: effect0Input),
          Expanded(child: effectPointsMin0Input),
          Expanded(child: effectPointsMax0Input),
          Expanded(child: effectArg0Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effect1Input),
          Expanded(child: effectPointsMin1Input),
          Expanded(child: effectPointsMax1Input),
          Expanded(child: effectArg1Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: effect2Input),
          Expanded(child: effectPointsMin2Input),
          Expanded(child: effectPointsMax2Input),
          Expanded(child: effectArg2Input),
        ],
      ),
    ];

    /// 3. 其他（2 行 4+3）
    final otherRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: itemVisualInput),
          Expanded(child: flagsInput),
          Expanded(child: srcItemIdInput),
          Expanded(child: conditionIdInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: requiredSkillIdInput),
          Expanded(child: requiredSkillRankInput),
          Expanded(child: minLevelInput),
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
          // 效果信息
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('效果信息'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: effectRows),
          ),
          // 其他
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('其他'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: otherRows),
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
