import 'package:flutter/material.dart';
import 'package:foxy/widget/entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/item_constants.dart';
import 'package:foxy/constant/item_enums.dart';
import 'package:foxy/constant/item_flags.dart';
import 'package:foxy/page/item/item_template_detail_view_model.dart';
import 'package:foxy/page/item/item_template_locale_description_selector.dart';
import 'package:foxy/page/item/item_template_locale_name_selector.dart';
import 'package:foxy/widget/flag_picker.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class ItemTemplateView extends StatefulWidget {
  final int? entry;
  const ItemTemplateView({super.key, this.entry});

  @override
  State<ItemTemplateView> createState() => _ItemTemplateViewState();
}

class _ItemTemplateViewState extends State<ItemTemplateView> {
  final viewModel = GetIt.instance.get<ItemTemplateDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(entry: widget.entry);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  // Convert kItemClasses List<String> to Map<int, String>
  Map<int, String> get _itemClassOptions => _kItemClassOptions;

  // Get subclass options based on selected class
  Map<int, String> get _currentSubclassOptions {
    final classId = viewModel.classNameController.value.firstOrNull ?? 0;
    if (classId < 0 || classId >= kItemSubclasses.length) return {};
    final subclasses = kItemSubclasses[classId];
    return subclasses.asMap().map((k, v) => MapEntry(k, v));
  }

  // Convert kItemInventoryTypes List<String> to Map<int, String>
  Map<int, String> get _inventoryTypeOptions => _kInventoryTypeOptions;

  // Ammo type options
  Map<int, String> get _ammoTypeOptions => _kAmmoTypeOptions;

  // Page material options
  Map<int, String> get _pageMaterialOptions => _kPageMaterialOptions;

  // Language options
  Map<int, String> get _languageOptions => _kLanguageOptions;

  @override
  Widget build(BuildContext context) {
    /// ==================== Card 1: 基本信息 ====================
    final entryInput = FormItem(
      controller: viewModel.entryController,
      label: '编号',
      placeholder: 'entry',
      readOnly: true,
    );
    final nameInput = FormItem(
      label: '名称',
      child: ItemTemplateLocaleNameSelector(
        entry: widget.entry,
        controller: viewModel.nameController,
        placeholder: 'name',
        title: '名称',
      ),
    );
    final descriptionInput = FormItem(
      label: '描述',
      child: ItemTemplateLocaleDescriptionSelector(
        entry: widget.entry,
        controller: viewModel.descriptionController,
        placeholder: 'description',
        title: '描述',
      ),
    );
    final qualityInput = FormItem(
      label: '品质',
      child: FoxyShadSelect<int>(
        controller: viewModel.qualityController,
        options: kItemQualityOptions,
        placeholder: const Text('Quality'),
      ),
    );
    final classInput = FormItem(
      label: '类别',
      child: FoxyShadSelect<int>(
        controller: viewModel.classNameController,
        options: _itemClassOptions,
        placeholder: const Text('class'),
      ),
    );
    final subclassInput = FormItem(
      label: '子类别',
      child: Watch(
        (_) => FoxyShadSelect<int>(
          controller: viewModel.subclassController,
          options: _currentSubclassOptions,
          placeholder: const Text('subclass'),
        ),
      ),
    );
    final soundOverrideSubclassInput = FormItem(
      label: '声音覆盖',
      child: FoxyNumberInput<int>(
        placeholder: 'SoundOverrideSubclass',
        controller: viewModel.soundOverrideSubclassController,
      ),
    );
    final materialInput = FormItem(
      label: '材质',
      child: FoxyShadSelect<int>(
        controller: viewModel.materialController,
        options: kItemMaterialOptions,
        placeholder: const Text('Material'),
      ),
    );
    final displayIdInput = FormItem(
      label: '外观模型',
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.itemDisplayInfo,
        controller: viewModel.displayIdController,
        placeholder: 'displayid',
      ),
    );
    final inventoryTypeInput = FormItem(
      label: '佩戴位置',
      child: FoxyShadSelect<int>(
        controller: viewModel.inventoryTypeController,
        options: _inventoryTypeOptions,
        placeholder: const Text('InventoryType'),
      ),
    );
    final sheathInput = FormItem(
      label: '挂载类型',
      child: FoxyShadSelect<int>(
        controller: viewModel.sheathController,
        options: kItemSheathOptions,
        placeholder: const Text('sheath'),
      ),
    );
    final bondingInput = FormItem(
      label: '绑定类型',
      child: FoxyShadSelect<int>(
        controller: viewModel.bondingController,
        options: kItemBondingOptions,
        placeholder: const Text('bonding'),
      ),
    );

    final basicRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: entryInput),
          Expanded(child: nameInput),
          Expanded(child: descriptionInput),
          Expanded(child: qualityInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: classInput),
          Expanded(child: subclassInput),
          Expanded(child: soundOverrideSubclassInput),
          Expanded(child: materialInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: displayIdInput),
          Expanded(child: inventoryTypeInput),
          Expanded(child: sheathInput),
          Expanded(child: bondingInput),
        ],
      ),
    ];

    /// ==================== Card 2: 套装/价格/容器/杂项 ====================
    final itemsetInput = FormItem(
      label: '套装',
      child: FoxyNumberInput<int>(
        placeholder: 'itemset',
        controller: viewModel.itemsetController,
      ),
    );
    final randomPropertyInput = FormItem(
      label: '随机属性',
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.itemRandomProperties,
        controller: viewModel.randomPropertyController,
        placeholder: 'RandomProperty',
      ),
    );
    final randomSuffixInput = FormItem(
      label: '随机后缀',
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.itemRandomSuffix,
        controller: viewModel.randomSuffixController,
        placeholder: 'RandomSuffix',
      ),
    );
    final maxDurabilityInput = FormItem(
      label: '最大耐久',
      child: FoxyNumberInput<int>(
        placeholder: 'MaxDurability',
        controller: viewModel.maxDurabilityController,
      ),
    );
    final buyPriceInput = FormItem(
      label: '购买价格',
      child: FoxyNumberInput<int>(
        placeholder: 'BuyPrice',
        controller: viewModel.buyPriceController,
      ),
    );
    final sellPriceInput = FormItem(
      label: '出售价格',
      child: FoxyNumberInput<int>(
        placeholder: 'SellPrice',
        controller: viewModel.sellPriceController,
      ),
    );
    final buyCountInput = FormItem(
      label: '购买数量',
      child: FoxyNumberInput<int>(
        placeholder: 'BuyCount',
        controller: viewModel.buyCountController,
      ),
    );
    final maxcountInput = FormItem(
      label: '最大数量',
      child: FoxyNumberInput<int>(
        placeholder: 'maxcount',
        controller: viewModel.maxcountController,
      ),
    );
    final stackableInput = FormItem(
      label: '堆叠数',
      child: FoxyNumberInput<int>(
        placeholder: 'stackable',
        controller: viewModel.stackableController,
      ),
    );
    final totemCategoryInput = FormItem(
      label: '图腾类别',
      child: FoxyNumberInput<int>(
        placeholder: 'TotemCategory',
        controller: viewModel.totemCategoryController,
      ),
    );
    final foodTypeInput = FormItem(
      label: '食物类型',
      child: FoxyShadSelect<int>(
        controller: viewModel.foodTypeController,
        options: kItemFoodTypeOptions,
        placeholder: const Text('FoodType'),
      ),
    );
    final bagFamilyInput = FormItem(
      label: '背包类别',
      child: FlagPicker(
        signal: viewModel.bagFamily,
        flags: kItemBagFamilyOptions,
        title: '背包类别',
        placeholder: 'BagFamily',
      ),
    );
    final containerSlotsInput = FormItem(
      label: '容器槽位',
      child: FoxyNumberInput<int>(
        placeholder: 'ContainerSlots',
        controller: viewModel.containerSlotsController,
      ),
    );
    final itemLimitCategoryInput = FormItem(
      label: '限制类别',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemLimitCategory',
        controller: viewModel.itemLimitCategoryController,
      ),
    );
    final startquestInput = FormItem(
      label: '起始任务',
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.questTemplate,
        controller: viewModel.startquestController,
        placeholder: 'startquest',
      ),
    );
    final durationInput = FormItem(
      label: '持续时间',
      child: FoxyNumberInput<int>(
        placeholder: 'duration',
        controller: viewModel.durationController,
      ),
    );
    final disenchantIdInput = FormItem(
      label: '分解ID',
      child: FoxyNumberInput<int>(
        placeholder: 'DisenchantID',
        controller: viewModel.disenchantIdController,
      ),
    );
    final minMoneyLootInput = FormItem(
      label: '最小金钱',
      child: FoxyNumberInput<int>(
        placeholder: 'minMoneyLoot',
        controller: viewModel.minMoneyLootController,
      ),
    );
    final maxMoneyLootInput = FormItem(
      label: '最大金钱',
      child: FoxyNumberInput<int>(
        placeholder: 'maxMoneyLoot',
        controller: viewModel.maxMoneyLootController,
      ),
    );

    final setPricingRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: itemsetInput),
          Expanded(child: randomPropertyInput),
          Expanded(child: randomSuffixInput),
          Expanded(child: maxDurabilityInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: buyPriceInput),
          Expanded(child: sellPriceInput),
          Expanded(child: buyCountInput),
          Expanded(child: maxcountInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: stackableInput),
          Expanded(child: totemCategoryInput),
          Expanded(child: foodTypeInput),
          Expanded(child: bagFamilyInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: containerSlotsInput),
          Expanded(child: itemLimitCategoryInput),
          Expanded(child: startquestInput),
          Expanded(child: durationInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: disenchantIdInput),
          Expanded(child: minMoneyLootInput),
          Expanded(child: maxMoneyLootInput),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// ==================== Card 3: 标识 ====================
    final flagsInput = FormItem(
      label: '物品标识',
      child: FlagPicker(
        signal: viewModel.flags,
        flags: kItemFlagOptions,
        title: '物品标识',
        placeholder: 'flags',
      ),
    );
    final flagsExtraInput = FormItem(
      label: '额外标识',
      child: FlagPicker(
        signal: viewModel.flagsExtra,
        flags: kItemFlagsExtraOptions,
        title: '额外标识',
        placeholder: 'flagsExtra',
      ),
    );
    final flagsCustomInput = FormItem(
      label: '自定义标识',
      child: FlagPicker(
        signal: viewModel.flagsCustom,
        flags: kItemFlagsCustomOptions,
        title: '自定义标识',
        placeholder: 'flagsCustom',
      ),
    );

    final flagsRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: flagsInput),
          Expanded(child: flagsExtraInput),
          Expanded(child: flagsCustomInput),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// ==================== Card 4: 伤害/护甲 ====================
    final delayInput = FormItem(
      label: '攻击延迟',
      child: FoxyNumberInput<int>(
        placeholder: 'delay',
        controller: viewModel.delayController,
      ),
    );
    final rangedModRangeInput = FormItem(
      label: '远程修正',
      child: FoxyNumberInput<int>(
        placeholder: 'RangedModRange',
        controller: viewModel.rangedModRangeController,
      ),
    );
    final armorDamageModifierInput = FormItem(
      label: '护甲修正',
      child: FoxyNumberInput<double>(
        placeholder: 'ArmorDamageModifier',
        controller: viewModel.armorDamageModifierController,
      ),
    );
    final ammoTypeInput = FormItem(
      label: '弹药类型',
      child: FoxyShadSelect<int>(
        controller: viewModel.ammoTypeController,
        options: _ammoTypeOptions,
        placeholder: const Text('ammo_type'),
      ),
    );
    final dmgType1Input = FormItem(
      label: '伤害类型1',
      child: FoxyShadSelect<int>(
        controller: viewModel.dmgType1Controller,
        options: kDamageSchoolOptions,
        placeholder: const Text('dmg_type1'),
      ),
    );
    final dmgMin1Input = FormItem(
      label: '最小伤害1',
      child: FoxyNumberInput<double>(
        placeholder: 'dmg_min1',
        controller: viewModel.dmgMin1Controller,
      ),
    );
    final dmgMax1Input = FormItem(
      label: '最大伤害1',
      child: FoxyNumberInput<double>(
        placeholder: 'dmg_max1',
        controller: viewModel.dmgMax1Controller,
      ),
    );
    final dmgType2Input = FormItem(
      label: '伤害类型2',
      child: FoxyShadSelect<int>(
        controller: viewModel.dmgType2Controller,
        options: kDamageSchoolOptions,
        placeholder: const Text('dmg_type2'),
      ),
    );
    final dmgMin2Input = FormItem(
      label: '最小伤害2',
      child: FoxyNumberInput<double>(
        placeholder: 'dmg_min2',
        controller: viewModel.dmgMin2Controller,
      ),
    );
    final dmgMax2Input = FormItem(
      label: '最大伤害2',
      child: FoxyNumberInput<double>(
        placeholder: 'dmg_max2',
        controller: viewModel.dmgMax2Controller,
      ),
    );
    final armorInput = FormItem(
      label: '护甲',
      child: FoxyNumberInput<int>(
        placeholder: 'armor',
        controller: viewModel.armorController,
      ),
    );
    final blockInput = FormItem(
      label: '格挡',
      child: FoxyNumberInput<int>(
        placeholder: 'block',
        controller: viewModel.blockController,
      ),
    );

    final damageArmorRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: delayInput),
          Expanded(child: rangedModRangeInput),
          Expanded(child: armorDamageModifierInput),
          Expanded(child: ammoTypeInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: dmgType1Input),
          Expanded(child: dmgMin1Input),
          Expanded(child: dmgMax1Input),
          Expanded(child: dmgType2Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: dmgMin2Input),
          Expanded(child: dmgMax2Input),
          Expanded(child: armorInput),
          Expanded(child: blockInput),
        ],
      ),
    ];

    /// ==================== Card 5: 缩放属性 ====================
    final scalingStatDistributionInput = FormItem(
      label: '缩放分布',
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.scalingStatDistribution,
        controller: viewModel.scalingStatDistributionController,
        placeholder: 'ScalingStatDistribution',
      ),
    );
    final scalingStatValueInput = FormItem(
      label: '缩放值',
      child: FlagPicker(
        signal: viewModel.scalingStatValue,
        flags: kItemScalingStatValueOptions,
        title: '缩放值',
        placeholder: 'ScalingStatValue',
      ),
    );

    final scalingRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: scalingStatDistributionInput),
          Expanded(child: scalingStatValueInput),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    /// ==================== Card 6: 属性 (dynamic) ====================
    final statsCountInput = FormItem(
      label: '属性数量',
      child: FoxyNumberInput<int>(
        placeholder: 'StatsCount',
        controller: viewModel.statsCountController,
      ),
    );

    /// ==================== Card 7: 抗性 ====================
    final holyResInput = FormItem(
      label: '神圣抗性',
      child: FoxyNumberInput<int>(
        placeholder: 'holy_res',
        controller: viewModel.holyResController,
      ),
    );
    final fireResInput = FormItem(
      label: '火焰抗性',
      child: FoxyNumberInput<int>(
        placeholder: 'fire_res',
        controller: viewModel.fireResController,
      ),
    );
    final natureResInput = FormItem(
      label: '自然抗性',
      child: FoxyNumberInput<int>(
        placeholder: 'nature_res',
        controller: viewModel.natureResController,
      ),
    );
    final shadowResInput = FormItem(
      label: '暗影抗性',
      child: FoxyNumberInput<int>(
        placeholder: 'shadow_res',
        controller: viewModel.shadowResController,
      ),
    );
    final frostResInput = FormItem(
      label: '冰霜抗性',
      child: FoxyNumberInput<int>(
        placeholder: 'frost_res',
        controller: viewModel.frostResController,
      ),
    );
    final arcaneResInput = FormItem(
      label: '奥术抗性',
      child: FoxyNumberInput<int>(
        placeholder: 'arcane_res',
        controller: viewModel.arcaneResController,
      ),
    );

    final resistanceRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: holyResInput),
          Expanded(child: fireResInput),
          Expanded(child: natureResInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: shadowResInput),
          Expanded(child: frostResInput),
          Expanded(child: arcaneResInput),
        ],
      ),
    ];

    /// ==================== Card 9: 需求 ====================
    final allowableClassInput = FormItem(
      label: '允许职业',
      child: FlagPicker(
        signal: viewModel.allowableClass,
        flags: kAllowableClassOptions,
        title: '允许职业',
        placeholder: 'AllowableClass',
      ),
    );
    final allowableRaceInput = FormItem(
      label: '允许种族',
      child: FlagPicker(
        signal: viewModel.allowableRace,
        flags: kAllowableRaceOptions,
        title: '允许种族',
        placeholder: 'AllowableRace',
      ),
    );
    final itemLevelInput = FormItem(
      label: '物品等级',
      child: FoxyNumberInput<int>(
        placeholder: 'ItemLevel',
        controller: viewModel.itemLevelController,
      ),
    );
    final requiredLevelInput = FormItem(
      label: '需求等级',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredLevel',
        controller: viewModel.requiredLevelController,
      ),
    );
    final requiredSkillInput = FormItem(
      label: '需求技能',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredSkill',
        controller: viewModel.requiredSkillController,
      ),
    );
    final requiredSkillRankInput = FormItem(
      label: '技能等级',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredSkillRank',
        controller: viewModel.requiredSkillRankController,
      ),
    );
    final requiredSpellInput = FormItem(
      label: '需求法术',
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.spell,
        controller: viewModel.requiredSpellController,
        placeholder: 'requiredspell',
      ),
    );
    final requiredHonorRankInput = FormItem(
      label: '荣誉等级',
      child: FoxyNumberInput<int>(
        placeholder: 'requiredhonorrank',
        controller: viewModel.requiredHonorRankController,
      ),
    );
    final requiredCityRankInput = FormItem(
      label: '城市等级',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredCityRank',
        controller: viewModel.requiredCityRankController,
      ),
    );
    final requiredReputationFactionInput = FormItem(
      label: '声望阵营',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredReputationFaction',
        controller: viewModel.requiredReputationFactionController,
      ),
    );
    final requiredReputationRankInput = FormItem(
      label: '声望等级',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredReputationRank',
        controller: viewModel.requiredReputationRankController,
      ),
    );
    final requiredDisenchantSkillInput = FormItem(
      label: '分解技能',
      child: FoxyNumberInput<int>(
        placeholder: 'RequiredDisenchantSkill',
        controller: viewModel.requiredDisenchantSkillController,
      ),
    );
    final mapIdInput = FormItem(
      label: '地图',
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.map,
        controller: viewModel.mapIdController,
        placeholder: 'Map',
      ),
    );
    final areaInput = FormItem(
      label: '区域',
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.areaTable,
        controller: viewModel.areaController,
        placeholder: 'area',
      ),
    );
    final holidayIdInput = FormItem(
      label: '节日ID',
      child: FoxyNumberInput<int>(
        placeholder: 'HolidayId',
        controller: viewModel.holidayIdController,
      ),
    );
    final lockidInput = FormItem(
      label: '锁定ID',
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.lock,
        controller: viewModel.lockidController,
        placeholder: 'lockid',
      ),
    );

    final requirementRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: allowableClassInput),
          Expanded(child: allowableRaceInput),
          Expanded(child: itemLevelInput),
          Expanded(child: requiredLevelInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: requiredSkillInput),
          Expanded(child: requiredSkillRankInput),
          Expanded(child: requiredSpellInput),
          Expanded(child: requiredHonorRankInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: requiredCityRankInput),
          Expanded(child: requiredReputationFactionInput),
          Expanded(child: requiredReputationRankInput),
          Expanded(child: requiredDisenchantSkillInput),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: mapIdInput),
          Expanded(child: areaInput),
          Expanded(child: holidayIdInput),
          Expanded(child: lockidInput),
        ],
      ),
    ];

    /// ==================== Card 10: 插槽/宝石 ====================
    final gemPropertiesInput = FormItem(
      label: '宝石属性',
      child: FoxyNumberInput<int>(
        placeholder: 'GemProperties',
        controller: viewModel.gemPropertiesController,
      ),
    );
    final socketBonusInput = FormItem(
      label: '插槽奖励',
      child: FoxyNumberInput<int>(
        placeholder: 'socketBonus',
        controller: viewModel.socketBonusController,
      ),
    );
    final socketColor1Input = FormItem(
      label: '插槽颜色1',
      child: FoxyShadSelect<int>(
        controller: viewModel.socketColorControllers[0],
        options: kItemSocketColorOptions,
        placeholder: const Text('socketColor_1'),
      ),
    );
    final socketColor2Input = FormItem(
      label: '插槽颜色2',
      child: FoxyShadSelect<int>(
        controller: viewModel.socketColorControllers[1],
        options: kItemSocketColorOptions,
        placeholder: const Text('socketColor_2'),
      ),
    );
    final socketColor3Input = FormItem(
      label: '插槽颜色3',
      child: FoxyShadSelect<int>(
        controller: viewModel.socketColorControllers[2],
        options: kItemSocketColorOptions,
        placeholder: const Text('socketColor_3'),
      ),
    );
    final socketContent1Input = FormItem(
      label: '插槽内容1',
      child: FoxyNumberInput<int>(
        placeholder: 'socketContent_1',
        value: viewModel.socketContents[0].value,
        onChanged: (v) => viewModel.socketContents[0].value = v,
      ),
    );
    final socketContent2Input = FormItem(
      label: '插槽内容2',
      child: FoxyNumberInput<int>(
        placeholder: 'socketContent_2',
        value: viewModel.socketContents[1].value,
        onChanged: (v) => viewModel.socketContents[1].value = v,
      ),
    );
    final socketContent3Input = FormItem(
      label: '插槽内容3',
      child: FoxyNumberInput<int>(
        placeholder: 'socketContent_3',
        value: viewModel.socketContents[2].value,
        onChanged: (v) => viewModel.socketContents[2].value = v,
      ),
    );

    final socketGemRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: gemPropertiesInput),
          Expanded(child: socketBonusInput),
          Expanded(child: socketColor1Input),
          Expanded(child: socketColor2Input),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: socketColor3Input),
          Expanded(child: socketContent1Input),
          Expanded(child: socketContent2Input),
          Expanded(child: socketContent3Input),
        ],
      ),
    ];

    /// ==================== Card 11: 其他/脚本 ====================
    final pageTextInput = FormItem(
      label: '页面文本',
      child: FoxyEntityPicker(
        delegate: EntityPickerDelegates.pageText,
        controller: viewModel.pageTextController,
        placeholder: 'PageText',
      ),
    );
    final pageMaterialInput = FormItem(
      label: '页面材质',
      child: FoxyShadSelect<int>(
        controller: viewModel.pageMaterialController,
        options: _pageMaterialOptions,
        placeholder: const Text('PageMaterial'),
      ),
    );
    final languageIdInput = FormItem(
      label: '语言',
      child: FoxyShadSelect<int>(
        controller: viewModel.languageIdController,
        options: _languageOptions,
        placeholder: const Text('LanguageID'),
      ),
    );
    final scriptNameInput = FormItem(
      controller: viewModel.scriptNameController,
      label: '脚本',
      placeholder: 'ScriptName',
    );
    final verifiedBuildInput = FormItem(
      label: 'VerifiedBuild',
      child: FoxyNumberInput<int>(
        placeholder: 'VerifiedBuild',
        controller: viewModel.verifiedBuildController,
      ),
    );

    final miscRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: pageTextInput),
          Expanded(child: pageMaterialInput),
          Expanded(child: languageIdInput),
          Expanded(child: SizedBox()),
        ],
      ),
      Row(
        spacing: 8,
        children: [
          Expanded(child: scriptNameInput),
          Expanded(child: verifiedBuildInput),
          Expanded(child: SizedBox()),
          Expanded(child: SizedBox()),
        ],
      ),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FormSection(title: '基本信息', children: basicRows),
          FormSection(title: '套装/价格/容器/杂项', children: setPricingRows),
          FormSection(title: '标识', children: flagsRows),
          FormSection(title: '伤害/护甲', children: damageArmorRows),
          FormSection(title: '缩放属性', children: scalingRows),
          FormSection(
            title: '属性',
            children: [
              Row(spacing: 8, children: [Expanded(child: statsCountInput)]),
              Watch((_) {
                final count =
                    int.tryParse(viewModel.statsCountController.text) ?? 0;
                final rows = <Row>[];
                for (var i = 0; i < count && i < 10; i++) {
                  rows.add(
                    Row(
                      spacing: 8,
                      children: [
                        Expanded(
                          child: FormItem(
                            label: '属性类型${i + 1}',
                            child: FoxyShadSelect<int>(
                              controller: viewModel.statTypeControllers[i],
                              options: kItemStatTypeOptions,
                              placeholder: Text('stat_type_${i + 1}'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FormItem(
                            label: '属性值${i + 1}',
                            child: FoxyNumberInput<int>(
                              placeholder: 'stat_value_${i + 1}',
                              value: viewModel.statValues[i].value,
                              onChanged: (v) =>
                                  viewModel.statValues[i].value = v,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Column(spacing: 8, children: rows);
              }),
            ],
          ),
          FormSection(title: '抗性', children: resistanceRows),
          FormSection(
            title: '法术',
            children: [
              for (var i = 0; i < 5; i++)
                ShadCard(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    spacing: 8,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: FormItem(
                              label: '法术${i + 1}',
                              child: FoxyEntityPicker(
                                delegate: EntityPickerDelegates.spell,
                                controller: viewModel.spellIds[i],
                                placeholder: 'spellid_${i + 1}',
                              ),
                            ),
                          ),
                          Expanded(
                            child: FormItem(
                              label: '触发类型',
                              child: FoxyShadSelect<int>(
                                controller:
                                    viewModel.spellTriggerControllers[i],
                                options: kItemSpellTriggerOptions,
                                placeholder: Text('spelltrigger_${i + 1}'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: FormItem(
                              label: '充能',
                              child: FoxyNumberInput<int>(
                                placeholder: 'spellcharges_${i + 1}',
                                value: viewModel.spellCharges[i].value,
                                onChanged: (v) =>
                                    viewModel.spellCharges[i].value = v,
                              ),
                            ),
                          ),
                          Expanded(
                            child: FormItem(
                              label: 'PPM率',
                              child: FoxyNumberInput<double>(
                                placeholder: 'spellppmRate_${i + 1}',
                                value: viewModel.spellPpmRates[i].value,
                                onChanged: (v) =>
                                    viewModel.spellPpmRates[i].value = v,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: FormItem(
                              label: '冷却',
                              child: FoxyNumberInput<int>(
                                placeholder: 'spellcooldown_${i + 1}',
                                value: viewModel.spellCooldowns[i].value,
                                onChanged: (v) =>
                                    viewModel.spellCooldowns[i].value = v,
                              ),
                            ),
                          ),
                          Expanded(
                            child: FormItem(
                              label: '类别',
                              child: FoxyNumberInput<int>(
                                placeholder: 'spellcategory_${i + 1}',
                                value: viewModel.spellCategories[i].value,
                                onChanged: (v) =>
                                    viewModel.spellCategories[i].value = v,
                              ),
                            ),
                          ),
                          Expanded(
                            child: FormItem(
                              label: '类别冷却',
                              child: FoxyNumberInput<int>(
                                placeholder: 'spellcategorycooldown_${i + 1}',
                                value:
                                    viewModel.spellCategoryCooldowns[i].value,
                                onChanged: (v) =>
                                    viewModel.spellCategoryCooldowns[i].value =
                                        v,
                              ),
                            ),
                          ),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
          FormSection(title: '需求', children: requirementRows),
          FormSection(title: '插槽/宝石', children: socketGemRows),
          FormSection(title: '其他/脚本', children: miscRows),
          // 保存/取消按钮
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

// 模块级常量选项表：稳定引用，供 FoxyShadSelect 缓存其 ShadOption 列表。
// （此前这些是每次 build 重建 Map 的 getter，破坏了下拉选项缓存。）
final Map<int, String> _kItemClassOptions = kItemClasses.asMap();

final Map<int, String> _kInventoryTypeOptions = kItemInventoryTypes.asMap();

const Map<int, String> _kAmmoTypeOptions = {0: '无', 2: '箭', 3: '子弹'};

const Map<int, String> _kPageMaterialOptions = {
  0: '纸质',
  1: '石头',
  2: '大理石',
  3: '银质',
  4: '青铜',
  5: '铁质',
  6: '铜质',
  7: '未知',
};

const Map<int, String> _kLanguageOptions = {
  0: '通用语',
  1: '兽人语',
  2: '矮人语',
  3: '达纳苏斯语',
  6: '亡灵语',
  7: '牛头人语',
  8: '侏儒语',
  10: '血精灵语',
  11: '德莱尼语',
  12: '龙语',
  13: '恶魔语',
  14: '泰坦语',
  33: '纳迦语',
  35: '亡灵语',
};
