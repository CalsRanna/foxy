import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/constant/spell_item_enchantment_constants.dart';
import 'package:foxy/page/spell_item_enchantment/spell_item_enchantment_detail_view_model.dart';
import 'package:foxy/widget/form/field_controller.dart';
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

class SpellItemEnchantmentView extends StatelessWidget {
  final SpellItemEnchantmentDetailViewModel viewModel;

  const SpellItemEnchantmentView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
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
        final id = viewModel.persistedKey.value;
        return FoxyLocalePicker(
          entry: id,
          controller: viewModel.nameController,
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
        controller: viewModel.chargesController,
      ),
    );

    final effect0Input = _effectTypeInput(0, viewModel.effect0Controller);
    final effectPointsMin0Input = _effectAmountInput(
      0,
      viewModel.effect0Controller,
      viewModel.effectPointsMin0Controller,
    );
    final effectPointsMax0Input = _clientMaximumInput(
      0,
      viewModel.effectPointsMax0Controller,
    );
    final effectArg0Input = _effectArgumentInput(
      0,
      viewModel.effect0Controller,
      viewModel.effectArg0Controller,
    );

    final effect1Input = _effectTypeInput(1, viewModel.effect1Controller);
    final effectPointsMin1Input = _effectAmountInput(
      1,
      viewModel.effect1Controller,
      viewModel.effectPointsMin1Controller,
    );
    final effectPointsMax1Input = _clientMaximumInput(
      1,
      viewModel.effectPointsMax1Controller,
    );
    final effectArg1Input = _effectArgumentInput(
      1,
      viewModel.effect1Controller,
      viewModel.effectArg1Controller,
    );

    final effect2Input = _effectTypeInput(2, viewModel.effect2Controller);
    final effectPointsMin2Input = _effectAmountInput(
      2,
      viewModel.effect2Controller,
      viewModel.effectPointsMin2Controller,
    );
    final effectPointsMax2Input = _clientMaximumInput(
      2,
      viewModel.effectPointsMax2Controller,
    );
    final effectArg2Input = _effectArgumentInput(
      2,
      viewModel.effect2Controller,
      viewModel.effectArg2Controller,
    );

    final itemVisualInput = FoxyFormItem(
      label: '物品视觉',
      child: FoxyEntityPicker(
        controller: viewModel.itemVisualController,
        delegate: FoxyEntityPickerDelegates.itemVisuals,
        placeholder: 'ItemVisual',
      ),
    );
    final flagsInput = FoxyFormItem(
      label: '附魔标志',
      child: FoxyFlagPicker(
        controller: viewModel.flagsController,
        flags: kSpellItemEnchantmentFlagOptions,
        title: '附魔标志',
        placeholder: 'Flags',
      ),
    );
    final srcItemIdInput = FoxyFormItem(
      label: '来源宝石物品',
      child: FoxyEntityPicker(
        controller: viewModel.srcItemIdController,
        delegate: FoxyEntityPickerDelegates.itemTemplate,
        placeholder: 'Src_itemID',
      ),
    );
    final conditionIdInput = FoxyFormItem(
      label: '附魔条件',
      child: FoxyEntityPicker(
        controller: viewModel.conditionIdController,
        delegate: FoxyEntityPickerDelegates.spellItemEnchantmentCondition,
        placeholder: 'Condition_ID',
      ),
    );
    final requiredSkillIdInput = FoxyFormItem(
      label: '所需技能',
      child: FoxyEntityPicker(
        controller: viewModel.requiredSkillIdController,
        delegate: FoxyEntityPickerDelegates.skillLine,
        placeholder: 'RequiredSkillID',
      ),
    );
    final requiredSkillRankInput = FoxyFormItem(
      label: '所需技能等级',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredSkillRank',
        controller: viewModel.requiredSkillRankController,
      ),
    );
    final minLevelInput = FoxyFormItem(
      label: '最低角色等级',
      child: FoxyNumberInput<int>(
        placeholder: 'MinLevel',
        controller: viewModel.minLevelController,
      ),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(
            title: '基本信息',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: idInput),
                  Expanded(child: nameInput),
                  Expanded(child: chargesInput),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          FoxyFormSection(
            title: '效果信息',
            children: [
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
            ],
          ),
          FoxyFormSection(
            title: '其他',
            children: [
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
                  const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Watch(
                (_) => ShadButton(
                  enabled: !viewModel.submitting.value,
                  onPressed: () => _persist(context),
                  child: const Text('保存'),
                ),
              ),
              const SizedBox(width: 8),
              ShadButton.ghost(onPressed: _goBack, child: const Text('取消')),
            ],
          ),
        ],
      ),
    );
  }

  FoxyFormItem _effectTypeInput(int slot, IntFieldController controller) {
    return FoxyFormItem(
      label: '效果类型 $slot',
      child: FoxyIntShadSelect(
        controller: controller,
        options: kSpellItemEnchantmentEffectTypeOptions,
        placeholder: Text('Effect$slot'),
      ),
    );
  }

  Widget _effectAmountInput(
    int slot,
    IntFieldController typeController,
    IntFieldController amountController,
  ) {
    return ListenableBuilder(
      listenable: typeController.controller,
      builder: (context, child) {
        final type = typeController.collect();
        return FoxyFormItem(
          label: _amountLabel(type, slot),
          child: FoxyNumberInput<int>(
            placeholder: 'EffectPointsMin$slot',
            controller: amountController,
          ),
        );
      },
    );
  }

  FoxyFormItem _clientMaximumInput(int slot, IntFieldController controller) {
    return FoxyFormItem(
      label: '客户端效果值 $slot',
      child: FoxyNumberInput<int>(
        placeholder: 'EffectPointsMax$slot',
        controller: controller,
      ),
    );
  }

  Widget _effectArgumentInput(
    int slot,
    IntFieldController typeController,
    IntFieldController argumentController,
  ) {
    return ListenableBuilder(
      listenable: typeController.controller,
      builder: (context, child) {
        final type = typeController.collect();
        if (type == 1 || type == 3 || type == 7) {
          return FoxyFormItem(
            label: '法术 $slot',
            child: FoxyEntityPicker(
              controller: argumentController,
              delegate: FoxyEntityPickerDelegates.spell,
              placeholder: 'EffectArg$slot',
            ),
          );
        }
        if (type == 4) {
          return FoxyFormItem(
            label: '抗性系别 $slot',
            child: FoxyIntShadSelect(
              controller: argumentController,
              options: kSpellItemEnchantmentSchoolOptions,
              placeholder: Text('EffectArg$slot'),
            ),
          );
        }
        if (type == 5) {
          return FoxyFormItem(
            label: '附魔属性 $slot',
            child: FoxyIntShadSelect(
              controller: argumentController,
              options: kSpellItemEnchantmentStatOptions,
              placeholder: Text('EffectArg$slot'),
              maxHeight: 360,
            ),
          );
        }
        return FoxyFormItem(
          label: '效果参数 $slot',
          child: FoxyNumberInput<int>(
            placeholder: 'EffectArg$slot',
            controller: argumentController,
          ),
        );
      },
    );
  }

  String _amountLabel(int type, int slot) {
    return switch (type) {
      1 => '触发几率 $slot',
      2 => '武器伤害 $slot',
      3 => '法术数值 $slot',
      4 => '抗性数值 $slot',
      5 => '属性数值 $slot',
      6 => '武器伤害系数 $slot',
      _ => '效果数值 $slot',
    };
  }

  Future<void> _persist(BuildContext context) async {
    try {
      await viewModel.persist();
      if (!context.mounted) return;
      GetIt.instance.get<RouterFacade>().updateCurrentLabel(
        '法术附魔 ${viewModel.persistedKey.value}',
      );
      ShadSonner.of(
        context,
      ).show(const ShadToast(description: Text('法术附魔数据已保存')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }
}
