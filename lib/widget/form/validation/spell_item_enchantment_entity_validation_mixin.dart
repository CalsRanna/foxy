import 'package:foxy/constant/spell_item_enchantment_constants.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin SpellItemEnchantmentValidationMixin on ViewModelValidationMixin {
  void validateSpellItemEnchantmentFields(SpellItemEnchantmentEntity value) =>
      value._validateFields();
}

extension on SpellItemEnchantmentEntity {
  void _validateFields() {
    _requireRange(id, 1, 0xffff, 'ID');
    _requireRange(charges, 0, 0x7fffffff, 'Charges');
    _validateEffect(effect0, effectPointsMin0, effectPointsMax0, effectArg0, 0);
    _validateEffect(effect1, effectPointsMin1, effectPointsMax1, effectArg1, 1);
    _validateEffect(effect2, effectPointsMin2, effectPointsMax2, effectArg2, 2);
    _requireRange(nameLangFlags, -0x80000000, 0x7fffffff, 'Name_lang_Flags');
    _requireRange(itemVisual, -1, 0x7fffffff, 'ItemVisual');
    _requireRange(flags, 0, 0x0f, 'Flags');
    _requireRange(srcItemId, 0, 0x7fffffff, 'Src_itemID');
    _requireRange(conditionId, 0, 0x7fffffff, 'Condition_ID');
    _requireRange(requiredSkillId, 0, 0x7fffffff, 'RequiredSkillID');
    _requireRange(requiredSkillRank, 0, 0x7fffffff, 'RequiredSkillRank');
    _requireRange(minLevel, 0, 0x7fffffff, 'MinLevel');
    if (requiredSkillId == 0 && requiredSkillRank != 0) {
      throw ArgumentError('RequiredSkillID 为 0 时 RequiredSkillRank 必须为 0');
    }
  }

  void _validateEffect(
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
    _requireRange(amount, -0x80000000, 0x7fffffff, 'EffectPointsMin$slot');
    _requireRange(
      clientMaximum,
      -0x80000000,
      0x7fffffff,
      'EffectPointsMax$slot',
    );
    _requireRange(argument, -0x80000000, 0x7fffffff, 'EffectArg$slot');
    if ((type == 1 || type == 3 || type == 7) && argument <= 0) {
      throw ArgumentError('$column 的法术参数必须大于 0');
    }
    if (type == 4 &&
        !kSpellItemEnchantmentSchoolOptions.containsKey(argument)) {
      throw ArgumentError('$column 的抗性参数必须是 SpellSchools 0..6');
    }
    if (type == 5 && !kSpellItemEnchantmentStatOptions.containsKey(argument)) {
      throw ArgumentError('$column 的属性参数未被 AzerothCore 附魔逻辑处理');
    }
  }

  void _requireRange(int value, int minimum, int maximum, String name) {
    if (value < minimum || value > maximum) {
      throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
    }
  }
}
