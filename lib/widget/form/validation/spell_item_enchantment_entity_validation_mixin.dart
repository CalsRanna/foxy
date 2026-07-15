import 'package:foxy/constant/spell_item_enchantment_constants.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin SpellItemEnchantmentValidationMixin on ViewModelValidationMixin {
  void validateSpellItemEnchantmentFields(SpellItemEnchantmentEntity value) {
    final id = value.id;
    final charges = value.charges;
    final effect0 = value.effect0;
    final effect1 = value.effect1;
    final effect2 = value.effect2;
    final effectPointsMin0 = value.effectPointsMin0;
    final effectPointsMin1 = value.effectPointsMin1;
    final effectPointsMin2 = value.effectPointsMin2;
    final effectPointsMax0 = value.effectPointsMax0;
    final effectPointsMax1 = value.effectPointsMax1;
    final effectPointsMax2 = value.effectPointsMax2;
    final effectArg0 = value.effectArg0;
    final effectArg1 = value.effectArg1;
    final effectArg2 = value.effectArg2;
    final nameLangFlags = value.nameLangFlags;
    final itemVisual = value.itemVisual;
    final flags = value.flags;
    final srcItemId = value.srcItemId;
    final conditionId = value.conditionId;
    final requiredSkillId = value.requiredSkillId;
    final requiredSkillRank = value.requiredSkillRank;
    final minLevel = value.minLevel;

    void requireRange(int value, int minimum, int maximum, String name) {
      if (value < minimum || value > maximum) {
        throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
      }
    }

    void validateEffect(
      int type,
      int amount,
      int clientMaximum,
      int argument,
      int slot,
    ) {
      final column = 'Effect$slot';
      if (!kSpellItemEnchantmentEffectTypeOptions.containsKey(type)) {
        throw ArgumentError('$column 必须是 AzerothCore ItemEnchantmentType 0..8');
      }
      requireRange(amount, -0x80000000, 0x7fffffff, 'EffectPointsMin$slot');
      requireRange(
        clientMaximum,
        -0x80000000,
        0x7fffffff,
        'EffectPointsMax$slot',
      );
      requireRange(argument, -0x80000000, 0x7fffffff, 'EffectArg$slot');
      if ((type == 1 || type == 3 || type == 7) && argument <= 0) {
        throw ArgumentError('$column 的法术参数必须大于 0');
      }
      if (type == 4 &&
          !kSpellItemEnchantmentSchoolOptions.containsKey(argument)) {
        throw ArgumentError('$column 的抗性参数必须是 SpellSchools 0..6');
      }
      if (type == 5 &&
          !kSpellItemEnchantmentStatOptions.containsKey(argument)) {
        throw ArgumentError('$column 的属性参数未被 AzerothCore 附魔逻辑处理');
      }
    }

    requireRange(id, 1, 0xffff, 'ID');
    requireRange(charges, 0, 0x7fffffff, 'Charges');
    validateEffect(effect0, effectPointsMin0, effectPointsMax0, effectArg0, 0);
    validateEffect(effect1, effectPointsMin1, effectPointsMax1, effectArg1, 1);
    validateEffect(effect2, effectPointsMin2, effectPointsMax2, effectArg2, 2);
    requireRange(nameLangFlags, -0x80000000, 0x7fffffff, 'Name_lang_Flags');
    requireRange(itemVisual, -1, 0x7fffffff, 'ItemVisual');
    requireRange(flags, 0, 0x0f, 'Flags');
    requireRange(srcItemId, 0, 0x7fffffff, 'Src_itemID');
    requireRange(conditionId, 0, 0x7fffffff, 'Condition_ID');
    requireRange(requiredSkillId, 0, 0x7fffffff, 'RequiredSkillID');
    requireRange(requiredSkillRank, 0, 0x7fffffff, 'RequiredSkillRank');
    requireRange(minLevel, 0, 0x7fffffff, 'MinLevel');
    if (requiredSkillId == 0 && requiredSkillRank != 0) {
      throw ArgumentError('RequiredSkillID 为 0 时 RequiredSkillRank 必须为 0');
    }
  }
}
