import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin ScalingStatValueValidationMixin on ViewModelValidationMixin {
  void validateScalingStatValueFields(ScalingStatValueEntity value) {
    final id = value.id;
    final charlevel = value.charlevel;
    final shoulderBudget = value.shoulderBudget;
    final trinketBudget = value.trinketBudget;
    final weaponBudget1H = value.weaponBudget1H;
    final rangedBudget = value.rangedBudget;
    final clothShoulderArmor = value.clothShoulderArmor;
    final leatherShoulderArmor = value.leatherShoulderArmor;
    final mailShoulderArmor = value.mailShoulderArmor;
    final plateShoulderArmor = value.plateShoulderArmor;
    final weaponDPS1H = value.weaponDPS1H;
    final weaponDPS2H = value.weaponDPS2H;
    final spellcasterDPS1H = value.spellcasterDPS1H;
    final spellcasterDPS2H = value.spellcasterDPS2H;
    final rangedDPS = value.rangedDPS;
    final wandDPS = value.wandDPS;
    final spellPower = value.spellPower;
    final primaryBudget = value.primaryBudget;
    final tertiaryBudget = value.tertiaryBudget;
    final clothCloakArmor = value.clothCloakArmor;
    final clothChestArmor = value.clothChestArmor;
    final leatherChestArmor = value.leatherChestArmor;
    final mailChestArmor = value.mailChestArmor;
    final plateChestArmor = value.plateChestArmor;

    void requireRange(int value, int minimum, int maximum, String name) {
      if (value < minimum || value > maximum) {
        throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
      }
    }

    void requireUnsignedInt32(int value, String name) {
      requireRange(value, 0, 0x7fffffff, name);
    }

    requireRange(id, 1, 0x7fffffff, 'ID');
    requireRange(charlevel, 1, 0x7fffffff, 'Charlevel');
    requireUnsignedInt32(shoulderBudget, 'ShoulderBudget');
    requireUnsignedInt32(trinketBudget, 'TrinketBudget');
    requireUnsignedInt32(weaponBudget1H, 'WeaponBudget1H');
    requireUnsignedInt32(rangedBudget, 'RangedBudget');
    requireUnsignedInt32(clothShoulderArmor, 'ClothShoulderArmor');
    requireUnsignedInt32(leatherShoulderArmor, 'LeatherShoulderArmor');
    requireUnsignedInt32(mailShoulderArmor, 'MailShoulderArmor');
    requireUnsignedInt32(plateShoulderArmor, 'PlateShoulderArmor');
    requireUnsignedInt32(weaponDPS1H, 'WeaponDPS1H');
    requireUnsignedInt32(weaponDPS2H, 'WeaponDPS2H');
    requireUnsignedInt32(spellcasterDPS1H, 'SpellcasterDPS1H');
    requireUnsignedInt32(spellcasterDPS2H, 'SpellcasterDPS2H');
    requireUnsignedInt32(rangedDPS, 'RangedDPS');
    requireUnsignedInt32(wandDPS, 'WandDPS');
    requireUnsignedInt32(spellPower, 'SpellPower');
    requireUnsignedInt32(primaryBudget, 'PrimaryBudget');
    requireUnsignedInt32(tertiaryBudget, 'TertiaryBudget');
    requireUnsignedInt32(clothCloakArmor, 'ClothCloakArmor');
    requireUnsignedInt32(clothChestArmor, 'ClothChestArmor');
    requireUnsignedInt32(leatherChestArmor, 'LeatherChestArmor');
    requireUnsignedInt32(mailChestArmor, 'MailChestArmor');
    requireUnsignedInt32(plateChestArmor, 'PlateChestArmor');
  }
}
