import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin ScalingStatValueValidationMixin on ViewModelValidationMixin {
  void validateScalingStatValueFields(ScalingStatValueEntity value) =>
      value._validateFields();
}

extension on ScalingStatValueEntity {
  void _validateFields() {
    _requireRange(id, 1, 0x7fffffff, 'ID');
    _requireRange(charlevel, 1, 0x7fffffff, 'Charlevel');
    _requireUnsignedInt32(shoulderBudget, 'ShoulderBudget');
    _requireUnsignedInt32(trinketBudget, 'TrinketBudget');
    _requireUnsignedInt32(weaponBudget1H, 'WeaponBudget1H');
    _requireUnsignedInt32(rangedBudget, 'RangedBudget');
    _requireUnsignedInt32(clothShoulderArmor, 'ClothShoulderArmor');
    _requireUnsignedInt32(leatherShoulderArmor, 'LeatherShoulderArmor');
    _requireUnsignedInt32(mailShoulderArmor, 'MailShoulderArmor');
    _requireUnsignedInt32(plateShoulderArmor, 'PlateShoulderArmor');
    _requireUnsignedInt32(weaponDPS1H, 'WeaponDPS1H');
    _requireUnsignedInt32(weaponDPS2H, 'WeaponDPS2H');
    _requireUnsignedInt32(spellcasterDPS1H, 'SpellcasterDPS1H');
    _requireUnsignedInt32(spellcasterDPS2H, 'SpellcasterDPS2H');
    _requireUnsignedInt32(rangedDPS, 'RangedDPS');
    _requireUnsignedInt32(wandDPS, 'WandDPS');
    _requireUnsignedInt32(spellPower, 'SpellPower');
    _requireUnsignedInt32(primaryBudget, 'PrimaryBudget');
    _requireUnsignedInt32(tertiaryBudget, 'TertiaryBudget');
    _requireUnsignedInt32(clothCloakArmor, 'ClothCloakArmor');
    _requireUnsignedInt32(clothChestArmor, 'ClothChestArmor');
    _requireUnsignedInt32(leatherChestArmor, 'LeatherChestArmor');
    _requireUnsignedInt32(mailChestArmor, 'MailChestArmor');
    _requireUnsignedInt32(plateChestArmor, 'PlateChestArmor');
  }

  void _requireUnsignedInt32(int value, String name) {
    _requireRange(value, 0, 0x7fffffff, name);
  }

  void _requireRange(int value, int minimum, int maximum, String name) {
    if (value < minimum || value > maximum) {
      throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
    }
  }
}
