import 'package:flutter/material.dart';
import 'package:foxy/page/spell_item_enchantment/spell_item_enchantment_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

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
        fieldController: viewModel.idController,
        readOnly: true,
      ),
    );
    final nameInput = FoxyFormItem(
      label: '名称',
      child: Watch((_) {
        final id = viewModel.enchantment.value.id;
        return FoxyLocalePicker(
          entry: id == 0 ? null : id,
          fieldController: viewModel.nameController,
          title: '附魔名称本地化',
          placeholder: 'Name_lang_zhCN',
          delegate: FoxyLocalePickerDelegates.dbcSpellItemEnchantmentName,
          onSaved: viewModel.applyNameLocales,
        );
      }),
    );
    final chargesInput = FoxyFormItem(
      label: '充能次数',
      child: FoxyNumberInput<int>(
        placeholder: 'Charges',
        fieldController: viewModel.chargesController,
      ),
    );

    /// Effect row 0
    final effect0Input = FoxyFormItem(
      label: 'Effect0',
      child: FoxyNumberInput<int>(
        placeholder: 'Effect0',
        fieldController: viewModel.effect0Controller,
      ),
    );
    final effectPointsMin0Input = FoxyFormItem(
      label: 'EffectPointsMin0',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectPointsMin0',
        fieldController: viewModel.effectPointsMin0Controller,
      ),
    );
    final effectPointsMax0Input = FoxyFormItem(
      label: 'EffectPointsMax0',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectPointsMax0',
        fieldController: viewModel.effectPointsMax0Controller,
      ),
    );
    final effectArg0Input = FoxyFormItem(
      label: 'EffectArg0',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectArg0',
        fieldController: viewModel.effectArg0Controller,
      ),
    );

    /// Effect row 1
    final effect1Input = FoxyFormItem(
      label: 'Effect1',
      child: FoxyNumberInput<int>(
        placeholder: 'Effect1',
        fieldController: viewModel.effect1Controller,
      ),
    );
    final effectPointsMin1Input = FoxyFormItem(
      label: 'EffectPointsMin1',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectPointsMin1',
        fieldController: viewModel.effectPointsMin1Controller,
      ),
    );
    final effectPointsMax1Input = FoxyFormItem(
      label: 'EffectPointsMax1',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectPointsMax1',
        fieldController: viewModel.effectPointsMax1Controller,
      ),
    );
    final effectArg1Input = FoxyFormItem(
      label: 'EffectArg1',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectArg1',
        fieldController: viewModel.effectArg1Controller,
      ),
    );

    /// Effect row 2
    final effect2Input = FoxyFormItem(
      label: 'Effect2',
      child: FoxyNumberInput<int>(
        placeholder: 'Effect2',
        fieldController: viewModel.effect2Controller,
      ),
    );
    final effectPointsMin2Input = FoxyFormItem(
      label: 'EffectPointsMin2',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectPointsMin2',
        fieldController: viewModel.effectPointsMin2Controller,
      ),
    );
    final effectPointsMax2Input = FoxyFormItem(
      label: 'EffectPointsMax2',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectPointsMax2',
        fieldController: viewModel.effectPointsMax2Controller,
      ),
    );
    final effectArg2Input = FoxyFormItem(
      label: 'EffectArg2',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectArg2',
        fieldController: viewModel.effectArg2Controller,
      ),
    );

    /// Other
    final itemVisualInput = FoxyFormItem(
      label: 'ItemVisual',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemVisual',
        fieldController: viewModel.itemVisualController,
      ),
    );
    final flagsInput = FoxyFormItem(
      label: 'Flags',
      child: FoxyNumberInput<int>(
        placeholder: 'Flags',
        fieldController: viewModel.flagsController,
      ),
    );
    final srcItemIdInput = FoxyFormItem(
      label: 'Src_itemID',
      child: FoxyNumberInput<int>(
        placeholder: 'Src_itemID',
        fieldController: viewModel.srcItemIdController,
      ),
    );
    final conditionIdInput = FoxyFormItem(
      label: 'Condition_ID',
      child: FoxyNumberInput<int>(
        placeholder: 'Condition_ID',
        fieldController: viewModel.conditionIdController,
      ),
    );
    final requiredSkillIdInput = FoxyFormItem(
      label: 'RequiredSkillID',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredSkillID',
        fieldController: viewModel.requiredSkillIdController,
      ),
    );
    final requiredSkillRankInput = FoxyFormItem(
      label: 'RequiredSkillRank',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredSkillRank',
        fieldController: viewModel.requiredSkillRankController,
      ),
    );
    final minLevelInput = FoxyFormItem(
      label: 'MinLevel',
      child: FoxyNumberInput<int>(
        placeholder: 'MinLevel',
        fieldController: viewModel.minLevelController,
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
