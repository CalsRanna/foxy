import 'package:flutter/material.dart';
import 'package:foxy/page/scaling_stat_value/scaling_stat_value_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ScalingStatValueView extends StatefulWidget {
  final int? entry;
  const ScalingStatValueView({super.key, this.entry});

  @override
  State<ScalingStatValueView> createState() => _ScalingStatValueViewState();
}

class _ScalingStatValueViewState extends State<ScalingStatValueView> {
  final viewModel = GetIt.instance.get<ScalingStatValueDetailViewModel>();

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
    // 分组1: 基础信息
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
        readOnly: true,
      ),
    );
    final charlevelInput = FoxyFormItem(
      label: '角色等级',
      child: FoxyNumberInput<int>(
        placeholder: 'Charlevel',
        controller: viewModel.charlevelController,
        readOnly: true,
      ),
    );

    // 分组2: 预算值
    final shoulderBudgetInput = FoxyFormItem(
      label: '肩部预算',
      child: FoxyNumberInput<int>(
        placeholder: 'ShoulderBudget',
        controller: viewModel.shoulderBudgetController,
      ),
    );
    final trinketBudgetInput = FoxyFormItem(
      label: '饰品预算',
      child: FoxyNumberInput<int>(
        placeholder: 'TrinketBudget',
        controller: viewModel.trinketBudgetController,
      ),
    );
    final weaponBudget1HInput = FoxyFormItem(
      label: '单手武器预算',
      child: FoxyNumberInput<int>(
        placeholder: 'WeaponBudget1H',
        controller: viewModel.weaponBudget1HController,
      ),
    );
    final rangedBudgetInput = FoxyFormItem(
      label: '远程预算',
      child: FoxyNumberInput<int>(
        placeholder: 'RangedBudget',
        controller: viewModel.rangedBudgetController,
      ),
    );
    final primaryBudgetInput = FoxyFormItem(
      label: '主要预算',
      child: FoxyNumberInput<int>(
        placeholder: 'PrimaryBudget',
        controller: viewModel.primaryBudgetController,
      ),
    );
    final tertiaryBudgetInput = FoxyFormItem(
      label: '三级预算',
      child: FoxyNumberInput<int>(
        placeholder: 'TertiaryBudget',
        controller: viewModel.tertiaryBudgetController,
      ),
    );
    final spellPowerInput = FoxyFormItem(
      label: '法术强度',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellPower',
        controller: viewModel.spellPowerController,
      ),
    );

    // 分组3: 护甲值
    final clothShoulderArmorInput = FoxyFormItem(
      label: '布甲肩部',
      child: FoxyNumberInput<int>(
        placeholder: 'ClothShoulderArmor',
        controller: viewModel.clothShoulderArmorController,
      ),
    );
    final leatherShoulderArmorInput = FoxyFormItem(
      label: '皮甲肩部',
      child: FoxyNumberInput<int>(
        placeholder: 'LeatherShoulderArmor',
        controller: viewModel.leatherShoulderArmorController,
      ),
    );
    final mailShoulderArmorInput = FoxyFormItem(
      label: '锁甲肩部',
      child: FoxyNumberInput<int>(
        placeholder: 'MailShoulderArmor',
        controller: viewModel.mailShoulderArmorController,
      ),
    );
    final plateShoulderArmorInput = FoxyFormItem(
      label: '板甲肩部',
      child: FoxyNumberInput<int>(
        placeholder: 'PlateShoulderArmor',
        controller: viewModel.plateShoulderArmorController,
      ),
    );
    final clothCloakArmorInput = FoxyFormItem(
      label: '布甲披风',
      child: FoxyNumberInput<int>(
        placeholder: 'ClothCloakArmor',
        controller: viewModel.clothCloakArmorController,
      ),
    );
    final clothChestArmorInput = FoxyFormItem(
      label: '布甲胸甲',
      child: FoxyNumberInput<int>(
        placeholder: 'ClothChestArmor',
        controller: viewModel.clothChestArmorController,
      ),
    );
    final leatherChestArmorInput = FoxyFormItem(
      label: '皮甲胸甲',
      child: FoxyNumberInput<int>(
        placeholder: 'LeatherChestArmor',
        controller: viewModel.leatherChestArmorController,
      ),
    );
    final mailChestArmorInput = FoxyFormItem(
      label: '锁甲胸甲',
      child: FoxyNumberInput<int>(
        placeholder: 'MailChestArmor',
        controller: viewModel.mailChestArmorController,
      ),
    );
    final plateChestArmorInput = FoxyFormItem(
      label: '板甲胸甲',
      child: FoxyNumberInput<int>(
        placeholder: 'PlateChestArmor',
        controller: viewModel.plateChestArmorController,
      ),
    );

    // 分组4: DPS值
    final weaponDPS1HInput = FoxyFormItem(
      label: '单手DPS',
      child: FoxyNumberInput<int>(
        placeholder: 'WeaponDPS1H',
        controller: viewModel.weaponDPS1HController,
      ),
    );
    final weaponDPS2HInput = FoxyFormItem(
      label: '双手DPS',
      child: FoxyNumberInput<int>(
        placeholder: 'WeaponDPS2H',
        controller: viewModel.weaponDPS2HController,
      ),
    );
    final spellcasterDPS1HInput = FoxyFormItem(
      label: '法系单手DPS',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellcasterDPS1H',
        controller: viewModel.spellcasterDPS1HController,
      ),
    );
    final spellcasterDPS2HInput = FoxyFormItem(
      label: '法系双手DPS',
      child: FoxyNumberInput<int>(
        placeholder: 'SpellcasterDPS2H',
        controller: viewModel.spellcasterDPS2HController,
      ),
    );
    final rangedDPSInput = FoxyFormItem(
      label: '远程DPS',
      child: FoxyNumberInput<int>(
        placeholder: 'RangedDPS',
        controller: viewModel.rangedDPSController,
      ),
    );
    final wandDPSInput = FoxyFormItem(
      label: '魔杖DPS',
      child: FoxyNumberInput<int>(
        placeholder: 'WandDPS',
        controller: viewModel.wandDPSController,
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(
            title: '基础信息',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: idInput),
                  Expanded(child: charlevelInput),
                  Expanded(child: SizedBox()),
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          FoxyFormSection(
            title: '预算值',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: shoulderBudgetInput),
                  Expanded(child: trinketBudgetInput),
                  Expanded(child: weaponBudget1HInput),
                  Expanded(child: rangedBudgetInput),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(child: primaryBudgetInput),
                  Expanded(child: tertiaryBudgetInput),
                  Expanded(child: spellPowerInput),
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          FoxyFormSection(
            title: '护甲值',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: clothShoulderArmorInput),
                  Expanded(child: leatherShoulderArmorInput),
                  Expanded(child: mailShoulderArmorInput),
                  Expanded(child: plateShoulderArmorInput),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(child: clothCloakArmorInput),
                  Expanded(child: clothChestArmorInput),
                  Expanded(child: leatherChestArmorInput),
                  Expanded(child: mailChestArmorInput),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(child: plateChestArmorInput),
                  Expanded(child: SizedBox()),
                  Expanded(child: SizedBox()),
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
          FoxyFormSection(
            title: 'DPS值',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: weaponDPS1HInput),
                  Expanded(child: weaponDPS2HInput),
                  Expanded(child: spellcasterDPS1HInput),
                  Expanded(child: spellcasterDPS2HInput),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(child: rangedDPSInput),
                  Expanded(child: wandDPSInput),
                  Expanded(child: SizedBox()),
                  Expanded(child: SizedBox()),
                ],
              ),
            ],
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
