import 'package:flutter/material.dart';
import 'package:foxy/page/spell_item_enchantment/spell_item_enchantment_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
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
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
        readOnly: true,
      ),
    );
    final nameInput = FoxyFormItem(
      controller: viewModel.nameController,
      label: '名称',
      placeholder: 'Name_lang_zhCN',
    );
    final chargesInput = FoxyFormItem(
      label: '充能次数',
      child: FoxyNumberInput<int>(
        placeholder: 'Charges',
        controller: viewModel.chargesController,
      ),
    );

    /// Effect row 0
    final effect0Input = FoxyFormItem(
      label: 'Effect0',
      child: FoxyNumberInput<int>(
        placeholder: 'Effect0',
        controller: viewModel.effect0Controller,
      ),
    );
    final effectPointsMin0Input = FoxyFormItem(
      label: 'EffectPointsMin0',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectPointsMin0',
        controller: viewModel.effectPointsMin0Controller,
      ),
    );
    final effectPointsMax0Input = FoxyFormItem(
      label: 'EffectPointsMax0',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectPointsMax0',
        controller: viewModel.effectPointsMax0Controller,
      ),
    );
    final effectArg0Input = FoxyFormItem(
      label: 'EffectArg0',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectArg0',
        controller: viewModel.effectArg0Controller,
      ),
    );

    /// Effect row 1
    final effect1Input = FoxyFormItem(
      label: 'Effect1',
      child: FoxyNumberInput<int>(
        placeholder: 'Effect1',
        controller: viewModel.effect1Controller,
      ),
    );
    final effectPointsMin1Input = FoxyFormItem(
      label: 'EffectPointsMin1',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectPointsMin1',
        controller: viewModel.effectPointsMin1Controller,
      ),
    );
    final effectPointsMax1Input = FoxyFormItem(
      label: 'EffectPointsMax1',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectPointsMax1',
        controller: viewModel.effectPointsMax1Controller,
      ),
    );
    final effectArg1Input = FoxyFormItem(
      label: 'EffectArg1',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectArg1',
        controller: viewModel.effectArg1Controller,
      ),
    );

    /// Effect row 2
    final effect2Input = FoxyFormItem(
      label: 'Effect2',
      child: FoxyNumberInput<int>(
        placeholder: 'Effect2',
        controller: viewModel.effect2Controller,
      ),
    );
    final effectPointsMin2Input = FoxyFormItem(
      label: 'EffectPointsMin2',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectPointsMin2',
        controller: viewModel.effectPointsMin2Controller,
      ),
    );
    final effectPointsMax2Input = FoxyFormItem(
      label: 'EffectPointsMax2',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectPointsMax2',
        controller: viewModel.effectPointsMax2Controller,
      ),
    );
    final effectArg2Input = FoxyFormItem(
      label: 'EffectArg2',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectArg2',
        controller: viewModel.effectArg2Controller,
      ),
    );

    /// Other
    final itemVisualInput = FoxyFormItem(
      label: 'ItemVisual',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemVisual',
        controller: viewModel.itemVisualController,
      ),
    );
    final flagsInput = FoxyFormItem(
      label: 'Flags',
      child: FoxyNumberInput<int>(
        placeholder: 'Flags',
        controller: viewModel.flagsController,
      ),
    );
    final srcItemIdInput = FoxyFormItem(
      label: 'Src_itemID',
      child: FoxyNumberInput<int>(
        placeholder: 'Src_itemID',
        controller: viewModel.srcItemIdController,
      ),
    );
    final conditionIdInput = FoxyFormItem(
      label: 'Condition_ID',
      child: FoxyNumberInput<int>(
        placeholder: 'Condition_ID',
        controller: viewModel.conditionIdController,
      ),
    );
    final requiredSkillIdInput = FoxyFormItem(
      label: 'RequiredSkillID',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredSkillID',
        controller: viewModel.requiredSkillIdController,
      ),
    );
    final requiredSkillRankInput = FoxyFormItem(
      label: 'RequiredSkillRank',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredSkillRank',
        controller: viewModel.requiredSkillRankController,
      ),
    );
    final minLevelInput = FoxyFormItem(
      label: 'MinLevel',
      child: FoxyNumberInput<int>(
        placeholder: 'MinLevel',
        controller: viewModel.minLevelController,
      ),
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
          FoxyFormSection(title: '基本信息', children: basicRows),
          FoxyFormSection(title: '效果信息', children: effectRows),
          FoxyFormSection(title: '其他', children: otherRows),
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
