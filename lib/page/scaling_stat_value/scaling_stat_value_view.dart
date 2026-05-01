import 'package:flutter/material.dart';
import 'package:foxy/page/scaling_stat_value/scaling_stat_value_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
      controller: viewModel.idController,
      label: '编号',
      placeholder: 'ID',
      readOnly: true,
    );
    final charlevelInput = FormItem(
      controller: viewModel.charlevelController,
      label: '角色等级',
      placeholder: 'Charlevel',
    );

    // 分组2: 预算值
    final shoulderBudgetInput = FormItem(
      controller: viewModel.shoulderBudgetController,
      label: '肩部预算',
      placeholder: 'ShoulderBudget',
    );
    final trinketBudgetInput = FormItem(
      controller: viewModel.trinketBudgetController,
      label: '饰品预算',
      placeholder: 'TrinketBudget',
    );
    final weaponBudget1HInput = FormItem(
      controller: viewModel.weaponBudget1HController,
      label: '单手武器预算',
      placeholder: 'WeaponBudget1H',
    );
    final rangedBudgetInput = FormItem(
      controller: viewModel.rangedBudgetController,
      label: '远程预算',
      placeholder: 'RangedBudget',
    );
    final primaryBudgetInput = FormItem(
      controller: viewModel.primaryBudgetController,
      label: '主属性预算',
      placeholder: 'PrimaryBudget',
    );
    final tertiaryBudgetInput = FormItem(
      controller: viewModel.tertiaryBudgetController,
      label: '第三属性预算',
      placeholder: 'TertiaryBudget',
    );
    final spellPowerInput = FormItem(
      controller: viewModel.spellPowerController,
      label: '法术强度',
      placeholder: 'SpellPower',
    );

    // 分组3: 护甲值
    final clothShoulderArmorInput = FormItem(
      controller: viewModel.clothShoulderArmorController,
      label: '布甲肩部',
      placeholder: 'ClothShoulderArmor',
    );
    final leatherShoulderArmorInput = FormItem(
      controller: viewModel.leatherShoulderArmorController,
      label: '皮甲肩部',
      placeholder: 'LeatherShoulderArmor',
    );
    final mailShoulderArmorInput = FormItem(
      controller: viewModel.mailShoulderArmorController,
      label: '锁甲肩部',
      placeholder: 'MailShoulderArmor',
    );
    final plateShoulderArmorInput = FormItem(
      controller: viewModel.plateShoulderArmorController,
      label: '板甲肩部',
      placeholder: 'PlateShoulderArmor',
    );
    final clothCloakArmorInput = FormItem(
      controller: viewModel.clothCloakArmorController,
      label: '布甲披风',
      placeholder: 'ClothCloakArmor',
    );
    final clothChestArmorInput = FormItem(
      controller: viewModel.clothChestArmorController,
      label: '布甲胸甲',
      placeholder: 'ClothChestArmor',
    );
    final leatherChestArmorInput = FormItem(
      controller: viewModel.leatherChestArmorController,
      label: '皮甲胸甲',
      placeholder: 'LeatherChestArmor',
    );
    final mailChestArmorInput = FormItem(
      controller: viewModel.mailChestArmorController,
      label: '锁甲胸甲',
      placeholder: 'MailChestArmor',
    );
    final plateChestArmorInput = FormItem(
      controller: viewModel.plateChestArmorController,
      label: '板甲胸甲',
      placeholder: 'PlateChestArmor',
    );

    // 分组4: DPS值
    final weaponDPS1HInput = FormItem(
      controller: viewModel.weaponDPS1HController,
      label: '单手DPS',
      placeholder: 'WeaponDPS1H',
    );
    final weaponDPS2HInput = FormItem(
      controller: viewModel.weaponDPS2HController,
      label: '双手DPS',
      placeholder: 'WeaponDPS2H',
    );
    final spellcasterDPS1HInput = FormItem(
      controller: viewModel.spellcasterDPS1HController,
      label: '法系单手DPS',
      placeholder: 'SpellcasterDPS1H',
    );
    final spellcasterDPS2HInput = FormItem(
      controller: viewModel.spellcasterDPS2HController,
      label: '法系双手DPS',
      placeholder: 'SpellcasterDPS2H',
    );
    final rangedDPSInput = FormItem(
      controller: viewModel.rangedDPSController,
      label: '远程DPS',
      placeholder: 'RangedDPS',
    );
    final wandDPSInput = FormItem(
      controller: viewModel.wandDPSController,
      label: '魔杖DPS',
      placeholder: 'WandDPS',
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
