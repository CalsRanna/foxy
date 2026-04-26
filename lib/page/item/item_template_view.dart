import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/item_constants.dart';
import 'package:foxy/constant/item_enums.dart';
import 'package:foxy/constant/item_flags.dart';
import 'package:foxy/page/creature_template/creature_display_info_selector.dart';
import 'package:foxy/page/creature_template/spell_selector.dart';
import 'package:foxy/page/item/item_enchantment_template_selector.dart';
import 'package:foxy/page/item/item_template_detail_view_model.dart';
import 'package:foxy/page/item/item_template_locale_description_selector.dart';
import 'package:foxy/page/item/item_template_locale_name_selector.dart';
import 'package:foxy/page/item/page_text_selector.dart';
import 'package:foxy/page/item/quest_template_selector.dart';
import 'package:foxy/page/item/scaling_stat_distribution_selector.dart';
import 'package:foxy/widget/flag_picker.dart';
import 'package:foxy/widget/form_item.dart';
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
  Map<int, String> get _itemClassOptions {
    return kItemClasses.asMap().map((k, v) => MapEntry(k, v));
  }

  // Get subclass options based on selected class
  Map<int, String> get _currentSubclassOptions {
    final classId = viewModel.classNameController.value.firstOrNull ?? 0;
    if (classId < 0 || classId >= kItemSubclasses.length) return {};
    final subclasses = kItemSubclasses[classId];
    return subclasses.asMap().map((k, v) => MapEntry(k, v));
  }

  // Convert kItemInventoryTypes List<String> to Map<int, String>
  Map<int, String> get _inventoryTypeOptions {
    return kItemInventoryTypes.asMap().map((k, v) => MapEntry(k, v));
  }

  // Ammo type options
  Map<int, String> get _ammoTypeOptions {
    return {0: '无', 2: '箭', 3: '子弹'};
  }

  // Page material options
  Map<int, String> get _pageMaterialOptions {
    return {
      0: '纸质',
      1: '石头',
      2: '大理石',
      3: '银质',
      4: '青铜',
      5: '铁质',
      6: '铜质',
      7: '未知',
    };
  }

  // Language options
  Map<int, String> get _languageOptions {
    return {
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
  }

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
      controller: viewModel.soundOverrideSubclassController,
      label: '声音覆盖',
      placeholder: 'SoundOverrideSubclass',
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
      child: CreatureDisplayInfoSelector(
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
      controller: viewModel.itemsetController,
      label: '套装',
      placeholder: 'itemset',
    );
    final randomPropertyInput = FormItem(
      label: '随机属性',
      child: ItemEnchantmentTemplateSelector(
        controller: viewModel.randomPropertyController,
        placeholder: 'RandomProperty',
      ),
    );
    final randomSuffixInput = FormItem(
      label: '随机后缀',
      child: ItemEnchantmentTemplateSelector(
        controller: viewModel.randomSuffixController,
        placeholder: 'RandomSuffix',
      ),
    );
    final maxDurabilityInput = FormItem(
      controller: viewModel.maxDurabilityController,
      label: '最大耐久',
      placeholder: 'MaxDurability',
    );
    final buyPriceInput = FormItem(
      controller: viewModel.buyPriceController,
      label: '购买价格',
      placeholder: 'BuyPrice',
    );
    final sellPriceInput = FormItem(
      controller: viewModel.sellPriceController,
      label: '出售价格',
      placeholder: 'SellPrice',
    );
    final buyCountInput = FormItem(
      controller: viewModel.buyCountController,
      label: '购买数量',
      placeholder: 'BuyCount',
    );
    final maxcountInput = FormItem(
      controller: viewModel.maxcountController,
      label: '最大数量',
      placeholder: 'maxcount',
    );
    final stackableInput = FormItem(
      controller: viewModel.stackableController,
      label: '堆叠数',
      placeholder: 'stackable',
    );
    final totemCategoryInput = FormItem(
      controller: viewModel.totemCategoryController,
      label: '图腾类别',
      placeholder: 'TotemCategory',
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
        controller: viewModel.bagFamilyController,
        flags: kItemBagFamilyOptions,
        title: '背包类别',
        placeholder: 'BagFamily',
      ),
    );
    final containerSlotsInput = FormItem(
      controller: viewModel.containerSlotsController,
      label: '容器槽位',
      placeholder: 'ContainerSlots',
    );
    final itemLimitCategoryInput = FormItem(
      controller: viewModel.itemLimitCategoryController,
      label: '限制类别',
      placeholder: 'ItemLimitCategory',
    );
    final startquestInput = FormItem(
      label: '起始任务',
      child: QuestTemplateSelector(
        controller: viewModel.startquestController,
        placeholder: 'startquest',
      ),
    );
    final durationInput = FormItem(
      controller: viewModel.durationController,
      label: '持续时间',
      placeholder: 'duration',
    );
    final disenchantIdInput = FormItem(
      controller: viewModel.disenchantIdController,
      label: '分解ID',
      placeholder: 'DisenchantID',
    );
    final minMoneyLootInput = FormItem(
      controller: viewModel.minMoneyLootController,
      label: '最小金钱',
      placeholder: 'minMoneyLoot',
    );
    final maxMoneyLootInput = FormItem(
      controller: viewModel.maxMoneyLootController,
      label: '最大金钱',
      placeholder: 'maxMoneyLoot',
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
        controller: viewModel.flagsController,
        flags: kItemFlagOptions,
        title: '物品标识',
        placeholder: 'flags',
      ),
    );
    final flagsExtraInput = FormItem(
      label: '额外标识',
      child: FlagPicker(
        controller: viewModel.flagsExtraController,
        flags: kItemFlagsExtraOptions,
        title: '额外标识',
        placeholder: 'flagsExtra',
      ),
    );
    final flagsCustomInput = FormItem(
      label: '自定义标识',
      child: FlagPicker(
        controller: viewModel.flagsCustomController,
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
      controller: viewModel.delayController,
      label: '攻击延迟',
      placeholder: 'delay',
    );
    final rangedModRangeInput = FormItem(
      controller: viewModel.rangedModRangeController,
      label: '远程修正',
      placeholder: 'RangedModRange',
    );
    final armorDamageModifierInput = FormItem(
      controller: viewModel.armorDamageModifierController,
      label: '护甲修正',
      placeholder: 'ArmorDamageModifier',
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
      controller: viewModel.dmgMin1Controller,
      label: '最小伤害1',
      placeholder: 'dmg_min1',
    );
    final dmgMax1Input = FormItem(
      controller: viewModel.dmgMax1Controller,
      label: '最大伤害1',
      placeholder: 'dmg_max1',
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
      controller: viewModel.dmgMin2Controller,
      label: '最小伤害2',
      placeholder: 'dmg_min2',
    );
    final dmgMax2Input = FormItem(
      controller: viewModel.dmgMax2Controller,
      label: '最大伤害2',
      placeholder: 'dmg_max2',
    );
    final armorInput = FormItem(
      controller: viewModel.armorController,
      label: '护甲',
      placeholder: 'armor',
    );
    final blockInput = FormItem(
      controller: viewModel.blockController,
      label: '格挡',
      placeholder: 'block',
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
      child: ScalingStatDistributionSelector(
        controller: viewModel.scalingStatDistributionController,
        placeholder: 'ScalingStatDistribution',
      ),
    );
    final scalingStatValueInput = FormItem(
      label: '缩放值',
      child: FlagPicker(
        controller: viewModel.scalingStatValueController,
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
      controller: viewModel.statsCountController,
      label: '属性数量',
      placeholder: 'StatsCount',
    );

    /// ==================== Card 7: 抗性 ====================
    final holyResInput = FormItem(
      controller: viewModel.holyResController,
      label: '神圣抗性',
      placeholder: 'holy_res',
    );
    final fireResInput = FormItem(
      controller: viewModel.fireResController,
      label: '火焰抗性',
      placeholder: 'fire_res',
    );
    final natureResInput = FormItem(
      controller: viewModel.natureResController,
      label: '自然抗性',
      placeholder: 'nature_res',
    );
    final shadowResInput = FormItem(
      controller: viewModel.shadowResController,
      label: '暗影抗性',
      placeholder: 'shadow_res',
    );
    final frostResInput = FormItem(
      controller: viewModel.frostResController,
      label: '冰霜抗性',
      placeholder: 'frost_res',
    );
    final arcaneResInput = FormItem(
      controller: viewModel.arcaneResController,
      label: '奥术抗性',
      placeholder: 'arcane_res',
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
        controller: viewModel.allowableClassController,
        flags: kAllowableClassOptions,
        title: '允许职业',
        placeholder: 'AllowableClass',
      ),
    );
    final allowableRaceInput = FormItem(
      label: '允许种族',
      child: FlagPicker(
        controller: viewModel.allowableRaceController,
        flags: kAllowableRaceOptions,
        title: '允许种族',
        placeholder: 'AllowableRace',
      ),
    );
    final itemLevelInput = FormItem(
      controller: viewModel.itemLevelController,
      label: '物品等级',
      placeholder: 'ItemLevel',
    );
    final requiredLevelInput = FormItem(
      controller: viewModel.requiredLevelController,
      label: '需求等级',
      placeholder: 'RequiredLevel',
    );
    final requiredSkillInput = FormItem(
      controller: viewModel.requiredSkillController,
      label: '需求技能',
      placeholder: 'RequiredSkill',
    );
    final requiredSkillRankInput = FormItem(
      controller: viewModel.requiredSkillRankController,
      label: '技能等级',
      placeholder: 'RequiredSkillRank',
    );
    final requiredSpellInput = FormItem(
      label: '需求法术',
      child: SpellSelector(
        controller: viewModel.requiredSpellController,
        placeholder: 'requiredspell',
      ),
    );
    final requiredHonorRankInput = FormItem(
      controller: viewModel.requiredHonorRankController,
      label: '荣誉等级',
      placeholder: 'requiredhonorrank',
    );
    final requiredCityRankInput = FormItem(
      controller: viewModel.requiredCityRankController,
      label: '城市等级',
      placeholder: 'RequiredCityRank',
    );
    final requiredReputationFactionInput = FormItem(
      controller: viewModel.requiredReputationFactionController,
      label: '声望阵营',
      placeholder: 'RequiredReputationFaction',
    );
    final requiredReputationRankInput = FormItem(
      controller: viewModel.requiredReputationRankController,
      label: '声望等级',
      placeholder: 'RequiredReputationRank',
    );
    final requiredDisenchantSkillInput = FormItem(
      controller: viewModel.requiredDisenchantSkillController,
      label: '分解技能',
      placeholder: 'RequiredDisenchantSkill',
    );
    final mapIdInput = FormItem(
      controller: viewModel.mapIdController,
      label: '地图',
      placeholder: 'Map',
    );
    final areaInput = FormItem(
      controller: viewModel.areaController,
      label: '区域',
      placeholder: 'area',
    );
    final holidayIdInput = FormItem(
      controller: viewModel.holidayIdController,
      label: '节日ID',
      placeholder: 'HolidayId',
    );
    final lockidInput = FormItem(
      controller: viewModel.lockidController,
      label: '锁定ID',
      placeholder: 'lockid',
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
      controller: viewModel.gemPropertiesController,
      label: '宝石属性',
      placeholder: 'GemProperties',
    );
    final socketBonusInput = FormItem(
      controller: viewModel.socketBonusController,
      label: '插槽奖励',
      placeholder: 'socketBonus',
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
      controller: viewModel.socketContentControllers[0],
      label: '插槽内容1',
      placeholder: 'socketContent_1',
    );
    final socketContent2Input = FormItem(
      controller: viewModel.socketContentControllers[1],
      label: '插槽内容2',
      placeholder: 'socketContent_2',
    );
    final socketContent3Input = FormItem(
      controller: viewModel.socketContentControllers[2],
      label: '插槽内容3',
      placeholder: 'socketContent_3',
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
      child: PageTextSelector(
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
      controller: viewModel.verifiedBuildController,
      label: 'VerifiedBuild',
      placeholder: 'VerifiedBuild',
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
          // 1. 基本信息
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('基本信息'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: basicRows),
          ),
          // 2. 套装/价格/容器/杂项
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('套装/价格/容器/杂项'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: setPricingRows),
          ),
          // 3. 标识
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('标识'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: flagsRows),
          ),
          // 4. 伤害/护甲
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('伤害/护甲'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: damageArmorRows),
          ),
          // 5. 缩放属性
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('缩放属性'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: scalingRows),
          ),
          // 6. 属性
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('属性'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 8,
              children: [
                Row(spacing: 8, children: [Expanded(child: statsCountInput)]),
                Watch((_) {
                  final count = viewModel.statsCount.value;
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
                              controller: viewModel.statValueControllers[i],
                              label: '属性值${i + 1}',
                              placeholder: 'stat_value_${i + 1}',
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
          ),
          // 7. 抗性
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('抗性'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: resistanceRows),
          ),
          // 8. 法术
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('法术'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 8,
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
                                child: SpellSelector(
                                  controller: viewModel.spellIdControllers[i],
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
                                controller: viewModel.spellChargeControllers[i],
                                label: '充能',
                                placeholder: 'spellcharges_${i + 1}',
                              ),
                            ),
                            Expanded(
                              child: FormItem(
                                controller:
                                    viewModel.spellPpmRateControllers[i],
                                label: 'PPM率',
                                placeholder: 'spellppmRate_${i + 1}',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 8,
                          children: [
                            Expanded(
                              child: FormItem(
                                controller:
                                    viewModel.spellCooldownControllers[i],
                                label: '冷却',
                                placeholder: 'spellcooldown_${i + 1}',
                              ),
                            ),
                            Expanded(
                              child: FormItem(
                                controller:
                                    viewModel.spellCategoryControllers[i],
                                label: '类别',
                                placeholder: 'spellcategory_${i + 1}',
                              ),
                            ),
                            Expanded(
                              child: FormItem(
                                controller: viewModel
                                    .spellCategoryCooldownControllers[i],
                                label: '类别冷却',
                                placeholder: 'spellcategorycooldown_${i + 1}',
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
          ),
          // 9. 需求
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('需求'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: requirementRows),
          ),
          // 10. 插槽/宝石
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('插槽/宝石'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: socketGemRows),
          ),
          // 11. 其他/脚本
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('其他/脚本'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: miscRows),
          ),
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
