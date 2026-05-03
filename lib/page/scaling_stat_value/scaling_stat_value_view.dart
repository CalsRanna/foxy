import 'package:flutter/material.dart';
import 'package:foxy/page/scaling_stat_value/scaling_stat_value_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
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
    final idInput = FormItem(
      label: '编号',
      placeholder: 'ID',
      child: FoxyNumberInput<int>(
        value: viewModel.id.value,
        onChanged: (v) => viewModel.id.value = v,
        readOnly: true,
      ),
    );
    final charlevelInput = FormItem(
      label: '角色等级',
      placeholder: 'Charlevel',
      child: FoxyNumberInput<int>(
        value: viewModel.charlevel.value,
        onChanged: (v) => viewModel.charlevel.value = v,
      ),
    );

    // 分组2: 预算值
    final shoulderBudgetInput = FormItem(
      label: '肩部预算',
      placeholder: 'ShoulderBudget',
      child: FoxyNumberInput<int>(
        value: viewModel.shoulderBudget.value,
        onChanged: (v) => viewModel.shoulderBudget.value = v,
      ),
    );
    final trinketBudgetInput = FormItem(
      label: '饰品预算',
      placeholder: 'TrinketBudget',
      child: FoxyNumberInput<int>(
        value: viewModel.trinketBudget.value,
        onChanged: (v) => viewModel.trinketBudget.value = v,
      ),
    );
    final weaponBudget1HInput = FormItem(
      label: '单手武器预算',
      placeholder: 'WeaponBudget1H',
      child: FoxyNumberInput<int>(
        value: viewModel.weaponBudget1H.value,
        onChanged: (v) => viewModel.weaponBudget1H.value = v,
      ),
    );
    final rangedBudgetInput = FormItem(
      label: '远程预算',
      placeholder: 'RangedBudget',
      child: FoxyNumberInput<int>(
        value: viewModel.rangedBudget.value,
        onChanged: (v) => viewModel.rangedBudget.value = v,
      ),
    );
    final primaryBudgetInput = FormItem(
      label: '主属性预算',
      placeholder: 'PrimaryBudget',
      child: FoxyNumberInput<int>(
        value: viewModel.primaryBudget.value,
        onChanged: (v) => viewModel.primaryBudget.value = v,
      ),
    );
    final tertiaryBudgetInput = FormItem(
      label: '第三属性预算',
      placeholder: 'TertiaryBudget',
      child: FoxyNumberInput<int>(
        value: viewModel.tertiaryBudget.value,
        onChanged: (v) => viewModel.tertiaryBudget.value = v,
      ),
    );
    final spellPowerInput = FormItem(
      label: '法术强度',
      placeholder: 'SpellPower',
      child: FoxyNumberInput<int>(
        value: viewModel.spellPower.value,
        onChanged: (v) => viewModel.spellPower.value = v,
      ),
    );

    // 分组3: 护甲值
    final clothShoulderArmorInput = FormItem(
      label: '布甲肩部',
      placeholder: 'ClothShoulderArmor',
      child: FoxyNumberInput<int>(
        value: viewModel.clothShoulderArmor.value,
        onChanged: (v) => viewModel.clothShoulderArmor.value = v,
      ),
    );
    final leatherShoulderArmorInput = FormItem(
      label: '皮甲肩部',
      placeholder: 'LeatherShoulderArmor',
      child: FoxyNumberInput<int>(
        value: viewModel.leatherShoulderArmor.value,
        onChanged: (v) => viewModel.leatherShoulderArmor.value = v,
      ),
    );
    final mailShoulderArmorInput = FormItem(
      label: '锁甲肩部',
      placeholder: 'MailShoulderArmor',
      child: FoxyNumberInput<int>(
        value: viewModel.mailShoulderArmor.value,
        onChanged: (v) => viewModel.mailShoulderArmor.value = v,
      ),
    );
    final plateShoulderArmorInput = FormItem(
      label: '板甲肩部',
      placeholder: 'PlateShoulderArmor',
      child: FoxyNumberInput<int>(
        value: viewModel.plateShoulderArmor.value,
        onChanged: (v) => viewModel.plateShoulderArmor.value = v,
      ),
    );
    final clothCloakArmorInput = FormItem(
      label: '布甲披风',
      placeholder: 'ClothCloakArmor',
      child: FoxyNumberInput<int>(
        value: viewModel.clothCloakArmor.value,
        onChanged: (v) => viewModel.clothCloakArmor.value = v,
      ),
    );
    final clothChestArmorInput = FormItem(
      label: '布甲胸甲',
      placeholder: 'ClothChestArmor',
      child: FoxyNumberInput<int>(
        value: viewModel.clothChestArmor.value,
        onChanged: (v) => viewModel.clothChestArmor.value = v,
      ),
    );
    final leatherChestArmorInput = FormItem(
      label: '皮甲胸甲',
      placeholder: 'LeatherChestArmor',
      child: FoxyNumberInput<int>(
        value: viewModel.leatherChestArmor.value,
        onChanged: (v) => viewModel.leatherChestArmor.value = v,
      ),
    );
    final mailChestArmorInput = FormItem(
      label: '锁甲胸甲',
      placeholder: 'MailChestArmor',
      child: FoxyNumberInput<int>(
        value: viewModel.mailChestArmor.value,
        onChanged: (v) => viewModel.mailChestArmor.value = v,
      ),
    );
    final plateChestArmorInput = FormItem(
      label: '板甲胸甲',
      placeholder: 'PlateChestArmor',
      child: FoxyNumberInput<int>(
        value: viewModel.plateChestArmor.value,
        onChanged: (v) => viewModel.plateChestArmor.value = v,
      ),
    );

    // 分组4: DPS值
    final weaponDPS1HInput = FormItem(
      label: '单手DPS',
      placeholder: 'WeaponDPS1H',
      child: FoxyNumberInput<int>(
        value: viewModel.weaponDPS1H.value,
        onChanged: (v) => viewModel.weaponDPS1H.value = v,
      ),
    );
    final weaponDPS2HInput = FormItem(
      label: '双手DPS',
      placeholder: 'WeaponDPS2H',
      child: FoxyNumberInput<int>(
        value: viewModel.weaponDPS2H.value,
        onChanged: (v) => viewModel.weaponDPS2H.value = v,
      ),
    );
    final spellcasterDPS1HInput = FormItem(
      label: '法系单手DPS',
      placeholder: 'SpellcasterDPS1H',
      child: FoxyNumberInput<int>(
        value: viewModel.spellcasterDPS1H.value,
        onChanged: (v) => viewModel.spellcasterDPS1H.value = v,
      ),
    );
    final spellcasterDPS2HInput = FormItem(
      label: '法系双手DPS',
      placeholder: 'SpellcasterDPS2H',
      child: FoxyNumberInput<int>(
        value: viewModel.spellcasterDPS2H.value,
        onChanged: (v) => viewModel.spellcasterDPS2H.value = v,
      ),
    );
    final rangedDPSInput = FormItem(
      label: '远程DPS',
      placeholder: 'RangedDPS',
      child: FoxyNumberInput<int>(
        value: viewModel.rangedDPS.value,
        onChanged: (v) => viewModel.rangedDPS.value = v,
      ),
    );
    final wandDPSInput = FormItem(
      label: '魔杖DPS',
      placeholder: 'WandDPS',
      child: FoxyNumberInput<int>(
        value: viewModel.wandDPS.value,
        onChanged: (v) => viewModel.wandDPS.value = v,
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          // 分组1: 基础信息
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 8,
              children: [
                Text(
                  '基础信息',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
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
          ),
          // 分组2: 预算值
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 8,
              children: [
                Text(
                  '预算值',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
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
          ),
          // 分组3: 护甲值
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 8,
              children: [
                Text(
                  '护甲值',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
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
          ),
          // 分组4: DPS值
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 8,
              children: [
                Text(
                  'DPS值',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
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
