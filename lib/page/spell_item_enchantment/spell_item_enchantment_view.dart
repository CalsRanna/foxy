import 'package:flutter/material.dart';
import 'package:foxy/page/spell_item_enchantment/spell_item_enchantment_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
    final idInput = FormItem(
      label: '编号',
      placeholder: 'ID',
      child: FoxyNumberInput<int>(
        value: viewModel.id.value,
        onChanged: (v) => viewModel.id.value = v,
        readOnly: true,
      ),
    );
    final nameInput = FormItem(
      controller: viewModel.nameController,
      label: '名称',
      placeholder: 'Name_lang_zhCN',
    );
    final chargesInput = FormItem(
      label: '充能次数',
      placeholder: 'Charges',
      child: FoxyNumberInput<int>(
        value: viewModel.charges.value,
        onChanged: (v) => viewModel.charges.value = v,
      ),
    );

    /// Effect row 0
    final effect0Input = FormItem(
      label: 'Effect0',
      placeholder: 'Effect0',
      child: FoxyNumberInput<int>(
        value: viewModel.effect0.value,
        onChanged: (v) => viewModel.effect0.value = v,
      ),
    );
    final effectPointsMin0Input = FormItem(
      label: 'EffectPointsMin0',
      placeholder: 'EffectPointsMin0',
      child: FoxyNumberInput<int>(
        value: viewModel.effectPointsMin0.value,
        onChanged: (v) => viewModel.effectPointsMin0.value = v,
      ),
    );
    final effectPointsMax0Input = FormItem(
      label: 'EffectPointsMax0',
      placeholder: 'EffectPointsMax0',
      child: FoxyNumberInput<int>(
        value: viewModel.effectPointsMax0.value,
        onChanged: (v) => viewModel.effectPointsMax0.value = v,
      ),
    );
    final effectArg0Input = FormItem(
      label: 'EffectArg0',
      placeholder: 'EffectArg0',
      child: FoxyNumberInput<int>(
        value: viewModel.effectArg0.value,
        onChanged: (v) => viewModel.effectArg0.value = v,
      ),
    );

    /// Effect row 1
    final effect1Input = FormItem(
      label: 'Effect1',
      placeholder: 'Effect1',
      child: FoxyNumberInput<int>(
        value: viewModel.effect1.value,
        onChanged: (v) => viewModel.effect1.value = v,
      ),
    );
    final effectPointsMin1Input = FormItem(
      label: 'EffectPointsMin1',
      placeholder: 'EffectPointsMin1',
      child: FoxyNumberInput<int>(
        value: viewModel.effectPointsMin1.value,
        onChanged: (v) => viewModel.effectPointsMin1.value = v,
      ),
    );
    final effectPointsMax1Input = FormItem(
      label: 'EffectPointsMax1',
      placeholder: 'EffectPointsMax1',
      child: FoxyNumberInput<int>(
        value: viewModel.effectPointsMax1.value,
        onChanged: (v) => viewModel.effectPointsMax1.value = v,
      ),
    );
    final effectArg1Input = FormItem(
      label: 'EffectArg1',
      placeholder: 'EffectArg1',
      child: FoxyNumberInput<int>(
        value: viewModel.effectArg1.value,
        onChanged: (v) => viewModel.effectArg1.value = v,
      ),
    );

    /// Effect row 2
    final effect2Input = FormItem(
      label: 'Effect2',
      placeholder: 'Effect2',
      child: FoxyNumberInput<int>(
        value: viewModel.effect2.value,
        onChanged: (v) => viewModel.effect2.value = v,
      ),
    );
    final effectPointsMin2Input = FormItem(
      label: 'EffectPointsMin2',
      placeholder: 'EffectPointsMin2',
      child: FoxyNumberInput<int>(
        value: viewModel.effectPointsMin2.value,
        onChanged: (v) => viewModel.effectPointsMin2.value = v,
      ),
    );
    final effectPointsMax2Input = FormItem(
      label: 'EffectPointsMax2',
      placeholder: 'EffectPointsMax2',
      child: FoxyNumberInput<int>(
        value: viewModel.effectPointsMax2.value,
        onChanged: (v) => viewModel.effectPointsMax2.value = v,
      ),
    );
    final effectArg2Input = FormItem(
      label: 'EffectArg2',
      placeholder: 'EffectArg2',
      child: FoxyNumberInput<int>(
        value: viewModel.effectArg2.value,
        onChanged: (v) => viewModel.effectArg2.value = v,
      ),
    );

    /// Other
    final itemVisualInput = FormItem(
      label: 'ItemVisual',
      placeholder: 'ItemVisual',
      child: FoxyNumberInput<int>(
        value: viewModel.itemVisual.value,
        onChanged: (v) => viewModel.itemVisual.value = v,
      ),
    );
    final flagsInput = FormItem(
      label: 'Flags',
      placeholder: 'Flags',
      child: FoxyNumberInput<int>(
        value: viewModel.flags.value,
        onChanged: (v) => viewModel.flags.value = v,
      ),
    );
    final srcItemIdInput = FormItem(
      label: 'Src_itemID',
      placeholder: 'Src_itemID',
      child: FoxyNumberInput<int>(
        value: viewModel.srcItemId.value,
        onChanged: (v) => viewModel.srcItemId.value = v,
      ),
    );
    final conditionIdInput = FormItem(
      label: 'Condition_ID',
      placeholder: 'Condition_ID',
      child: FoxyNumberInput<int>(
        value: viewModel.conditionId.value,
        onChanged: (v) => viewModel.conditionId.value = v,
      ),
    );
    final requiredSkillIdInput = FormItem(
      label: 'RequiredSkillID',
      placeholder: 'RequiredSkillID',
      child: FoxyNumberInput<int>(
        value: viewModel.requiredSkillId.value,
        onChanged: (v) => viewModel.requiredSkillId.value = v,
      ),
    );
    final requiredSkillRankInput = FormItem(
      label: 'RequiredSkillRank',
      placeholder: 'RequiredSkillRank',
      child: FoxyNumberInput<int>(
        value: viewModel.requiredSkillRank.value,
        onChanged: (v) => viewModel.requiredSkillRank.value = v,
      ),
    );
    final minLevelInput = FormItem(
      label: 'MinLevel',
      placeholder: 'MinLevel',
      child: FoxyNumberInput<int>(
        value: viewModel.minLevel.value,
        onChanged: (v) => viewModel.minLevel.value = v,
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
