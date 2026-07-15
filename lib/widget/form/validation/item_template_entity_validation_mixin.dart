import 'package:foxy/constant/scaling_stat_value_constants.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin ItemTemplateValidationMixin on ViewModelValidationMixin {
  void validateItemTemplateFields(ItemTemplateEntity value) =>
      value._validateFields();
}

extension on ItemTemplateEntity {
  void _validateFields() {
    if (quality < 0 || quality > 7) {
      throw ArgumentError.value(quality, 'Quality', '必须在 0 到 7 之间');
    }
    if (buyCount <= 0) {
      throw ArgumentError.value(buyCount, 'BuyCount', '必须大于 0');
    }
    if (maxcount < -1) {
      throw ArgumentError.value(maxcount, 'maxcount', '最小特殊值为 -1');
    }
    if (stackable < -1 || stackable == 0) {
      throw ArgumentError.value(stackable, 'stackable', '只允许 -1 或正整数');
    }
    if (containerSlots < 0 || containerSlots > 36) {
      throw ArgumentError.value(
        containerSlots,
        'ContainerSlots',
        '必须在 0 到 36 之间',
      );
    }
    if (randomProperty != 0 && randomSuffix != 0) {
      throw ArgumentError('RandomProperty 与 RandomSuffix 只能设置一个');
    }
    if (minMoneyLoot > maxMoneyLoot) {
      throw ArgumentError('minMoneyLoot 不能大于 maxMoneyLoot');
    }
    _validateStatType(statType1, statValue1, 'stat_type1');
    _validateStatType(statType2, statValue2, 'stat_type2');
    _validateStatType(statType3, statValue3, 'stat_type3');
    _validateStatType(statType4, statValue4, 'stat_type4');
    _validateStatType(statType5, statValue5, 'stat_type5');
    _validateStatType(statType6, statValue6, 'stat_type6');
    _validateStatType(statType7, statValue7, 'stat_type7');
    _validateStatType(statType8, statValue8, 'stat_type8');
    _validateStatType(statType9, statValue9, 'stat_type9');
    _validateStatType(statType10, statValue10, 'stat_type10');
    if (dmgType1 < 0 || dmgType1 > 6) {
      throw ArgumentError('dmg_type1 必须在 0 到 6 之间');
    }
    if (dmgType2 < 0 || dmgType2 > 6) {
      throw ArgumentError('dmg_type2 必须在 0 到 6 之间');
    }
    _validateSpellTrigger(spellTrigger1, 'spelltrigger_1');
    _validateSpellTrigger(spellTrigger2, 'spelltrigger_2');
    _validateSpellTrigger(spellTrigger3, 'spelltrigger_3');
    _validateSpellTrigger(spellTrigger4, 'spelltrigger_4');
    _validateSpellTrigger(spellTrigger5, 'spelltrigger_5');
    final specialLearning = spellId1 == 483 || spellId1 == 55884;
    if (specialLearning) {
      if (spellTrigger1 != 0 ||
          spellTrigger2 != 6 ||
          spellId2 == 0 ||
          spellId3 != 0 ||
          spellId4 != 0 ||
          spellId5 != 0 ||
          spellTrigger3 != 0 ||
          spellTrigger4 != 0 ||
          spellTrigger5 != 0) {
        throw ArgumentError('特殊学习物品必须使用 AzerothCore 的 spell_1/spell_2 格式');
      }
    } else if (spellTrigger1 == 6 ||
        spellTrigger2 == 6 ||
        spellTrigger3 == 6 ||
        spellTrigger4 == 6 ||
        spellTrigger5 == 6 ||
        spellId2 == 483 ||
        spellId3 == 483 ||
        spellId4 == 483 ||
        spellId5 == 483 ||
        spellId2 == 55884 ||
        spellId3 == 55884 ||
        spellId4 == 55884 ||
        spellId5 == 55884) {
      throw ArgumentError('学习触发类型 6 仅允许用于特殊学习物品格式');
    }
    if (bonding < 0 || bonding > 5) {
      throw ArgumentError.value(bonding, 'bonding', '必须在 0 到 5 之间');
    }
    if (requiredReputationRank < 0 || requiredReputationRank > 7) {
      throw ArgumentError.value(
        requiredReputationRank,
        'RequiredReputationRank',
        '必须在 0 到 7 之间',
      );
    }
    _validateSocketColor(socketColor1, 'socketColor_1');
    _validateSocketColor(socketColor2, 'socketColor_2');
    _validateSocketColor(socketColor3, 'socketColor_3');
    if ((flagsCustom & 1) != 0 && duration == 0) {
      throw ArgumentError('启用离线计时标志时 duration 必须大于 0');
    }
    _validateScalingStatValue();
  }

  void _validateStatType(int type, int value, String column) {
    if (value != 0 && (type < 0 || type >= 49)) {
      throw ArgumentError('$column 必须在 0 到 48 之间');
    }
  }

  void _validateSpellTrigger(int trigger, String column) {
    if (!const {0, 1, 2, 4, 5, 6}.contains(trigger)) {
      throw ArgumentError('$column 不是有效触发类型');
    }
  }

  void _validateSocketColor(int color, String column) {
    if ((color & ~0x0F) != 0) {
      throw ArgumentError('$column 包含无效颜色位');
    }
  }

  void _validateScalingStatValue() {
    if (scalingStatValue < 0 ||
        (scalingStatValue & ~kScalingStatValueSupportedMask) != 0) {
      throw ArgumentError('ScalingStatValue 包含 AzerothCore 不消费的位');
    }
    _requireAtMostOneScalingBit(
      kScalingStatValueBudgetMask,
      'ScalingStatValue 只能选择一个预算列',
    );
    _requireAtMostOneScalingBit(
      kScalingStatValueArmorMask,
      'ScalingStatValue 只能选择一个护甲列',
    );
    _requireAtMostOneScalingBit(
      kScalingStatValueDpsMask,
      'ScalingStatValue 只能选择一个 DPS 列',
    );
  }

  void _requireAtMostOneScalingBit(int mask, String message) {
    final selected = scalingStatValue & mask;
    if (selected != 0 && (selected & (selected - 1)) != 0) {
      throw ArgumentError(message);
    }
  }
}
