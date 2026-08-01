// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scaling_stat_value_detail_view_model.dart';

mixin _ScalingStatValueDetailViewModelMixin on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final charlevelController = registerController(IntFieldController());
  late final shoulderBudgetController = registerController(
    IntFieldController(),
  );
  late final trinketBudgetController = registerController(IntFieldController());
  late final weaponBudget1HController = registerController(
    IntFieldController(),
  );
  late final rangedBudgetController = registerController(IntFieldController());
  late final clothShoulderArmorController = registerController(
    IntFieldController(),
  );
  late final leatherShoulderArmorController = registerController(
    IntFieldController(),
  );
  late final mailShoulderArmorController = registerController(
    IntFieldController(),
  );
  late final plateShoulderArmorController = registerController(
    IntFieldController(),
  );
  late final weaponDPS1HController = registerController(IntFieldController());
  late final weaponDPS2HController = registerController(IntFieldController());
  late final spellcasterDPS1HController = registerController(
    IntFieldController(),
  );
  late final spellcasterDPS2HController = registerController(
    IntFieldController(),
  );
  late final rangedDPSController = registerController(IntFieldController());
  late final wandDPSController = registerController(IntFieldController());
  late final spellPowerController = registerController(IntFieldController());
  late final primaryBudgetController = registerController(IntFieldController());
  late final tertiaryBudgetController = registerController(
    IntFieldController(),
  );
  late final clothCloakArmorController = registerController(
    IntFieldController(),
  );
  late final clothChestArmorController = registerController(
    IntFieldController(),
  );
  late final leatherChestArmorController = registerController(
    IntFieldController(),
  );
  late final mailChestArmorController = registerController(
    IntFieldController(),
  );
  late final plateChestArmorController = registerController(
    IntFieldController(),
  );

  ScalingStatValueEntity _collectCandidate() {
    return ScalingStatValueEntity(
      id: idController.collect(),
      charlevel: charlevelController.collect(),
      shoulderBudget: shoulderBudgetController.collect(),
      trinketBudget: trinketBudgetController.collect(),
      weaponBudget1H: weaponBudget1HController.collect(),
      rangedBudget: rangedBudgetController.collect(),
      clothShoulderArmor: clothShoulderArmorController.collect(),
      leatherShoulderArmor: leatherShoulderArmorController.collect(),
      mailShoulderArmor: mailShoulderArmorController.collect(),
      plateShoulderArmor: plateShoulderArmorController.collect(),
      weaponDPS1H: weaponDPS1HController.collect(),
      weaponDPS2H: weaponDPS2HController.collect(),
      spellcasterDPS1H: spellcasterDPS1HController.collect(),
      spellcasterDPS2H: spellcasterDPS2HController.collect(),
      rangedDPS: rangedDPSController.collect(),
      wandDPS: wandDPSController.collect(),
      spellPower: spellPowerController.collect(),
      primaryBudget: primaryBudgetController.collect(),
      tertiaryBudget: tertiaryBudgetController.collect(),
      clothCloakArmor: clothCloakArmorController.collect(),
      clothChestArmor: clothChestArmorController.collect(),
      leatherChestArmor: leatherChestArmorController.collect(),
      mailChestArmor: mailChestArmorController.collect(),
      plateChestArmor: plateChestArmorController.collect(),
    );
  }

  void _applyCandidate(ScalingStatValueEntity scalingStatValue) {
    idController.init(scalingStatValue.id);
    charlevelController.init(scalingStatValue.charlevel);
    shoulderBudgetController.init(scalingStatValue.shoulderBudget);
    trinketBudgetController.init(scalingStatValue.trinketBudget);
    weaponBudget1HController.init(scalingStatValue.weaponBudget1H);
    rangedBudgetController.init(scalingStatValue.rangedBudget);
    clothShoulderArmorController.init(scalingStatValue.clothShoulderArmor);
    leatherShoulderArmorController.init(scalingStatValue.leatherShoulderArmor);
    mailShoulderArmorController.init(scalingStatValue.mailShoulderArmor);
    plateShoulderArmorController.init(scalingStatValue.plateShoulderArmor);
    weaponDPS1HController.init(scalingStatValue.weaponDPS1H);
    weaponDPS2HController.init(scalingStatValue.weaponDPS2H);
    spellcasterDPS1HController.init(scalingStatValue.spellcasterDPS1H);
    spellcasterDPS2HController.init(scalingStatValue.spellcasterDPS2H);
    rangedDPSController.init(scalingStatValue.rangedDPS);
    wandDPSController.init(scalingStatValue.wandDPS);
    spellPowerController.init(scalingStatValue.spellPower);
    primaryBudgetController.init(scalingStatValue.primaryBudget);
    tertiaryBudgetController.init(scalingStatValue.tertiaryBudget);
    clothCloakArmorController.init(scalingStatValue.clothCloakArmor);
    clothChestArmorController.init(scalingStatValue.clothChestArmor);
    leatherChestArmorController.init(scalingStatValue.leatherChestArmor);
    mailChestArmorController.init(scalingStatValue.mailChestArmor);
    plateChestArmorController.init(scalingStatValue.plateChestArmor);
    _afterApplyCandidate(scalingStatValue);
  }

  void _afterApplyCandidate(ScalingStatValueEntity scalingStatValue) {}
}
