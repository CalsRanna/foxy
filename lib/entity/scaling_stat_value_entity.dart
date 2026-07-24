import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'scaling_stat_value_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_scaling_stat_values')
class ScalingStatValueEntity with _ScalingStatValueEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Charlevel')
  final int charlevel;

  @FoxyBriefField()
  @FoxyFullField('ShoulderBudget')
  final int shoulderBudget;

  @FoxyBriefField()
  @FoxyFullField('TrinketBudget')
  final int trinketBudget;

  @FoxyBriefField()
  @FoxyFullField('WeaponBudget1H')
  final int weaponBudget1H;

  @FoxyBriefField()
  @FoxyFullField('RangedBudget')
  final int rangedBudget;

  @FoxyFullField('ClothShoulderArmor')
  final int clothShoulderArmor;

  @FoxyFullField('LeatherShoulderArmor')
  final int leatherShoulderArmor;

  @FoxyFullField('MailShoulderArmor')
  final int mailShoulderArmor;

  @FoxyFullField('PlateShoulderArmor')
  final int plateShoulderArmor;

  @FoxyFullField('WeaponDPS1H')
  final int weaponDPS1H;

  @FoxyFullField('WeaponDPS2H')
  final int weaponDPS2H;

  @FoxyFullField('SpellcasterDPS1H')
  final int spellcasterDPS1H;

  @FoxyFullField('SpellcasterDPS2H')
  final int spellcasterDPS2H;

  @FoxyFullField('RangedDPS')
  final int rangedDPS;

  @FoxyFullField('WandDPS')
  final int wandDPS;

  @FoxyFullField('SpellPower')
  final int spellPower;

  @FoxyBriefField()
  @FoxyFullField('PrimaryBudget')
  final int primaryBudget;

  @FoxyBriefField()
  @FoxyFullField('TertiaryBudget')
  final int tertiaryBudget;

  @FoxyFullField('ClothCloakArmor')
  final int clothCloakArmor;

  @FoxyFullField('ClothChestArmor')
  final int clothChestArmor;

  @FoxyFullField('LeatherChestArmor')
  final int leatherChestArmor;

  @FoxyFullField('MailChestArmor')
  final int mailChestArmor;

  @FoxyFullField('PlateChestArmor')
  final int plateChestArmor;

  const ScalingStatValueEntity({
    this.id = 0,
    this.charlevel = 0,
    this.shoulderBudget = 0,
    this.trinketBudget = 0,
    this.weaponBudget1H = 0,
    this.rangedBudget = 0,
    this.clothShoulderArmor = 0,
    this.leatherShoulderArmor = 0,
    this.mailShoulderArmor = 0,
    this.plateShoulderArmor = 0,
    this.weaponDPS1H = 0,
    this.weaponDPS2H = 0,
    this.spellcasterDPS1H = 0,
    this.spellcasterDPS2H = 0,
    this.rangedDPS = 0,
    this.wandDPS = 0,
    this.spellPower = 0,
    this.primaryBudget = 0,
    this.tertiaryBudget = 0,
    this.clothCloakArmor = 0,
    this.clothChestArmor = 0,
    this.leatherChestArmor = 0,
    this.mailChestArmor = 0,
    this.plateChestArmor = 0,
  });

  factory ScalingStatValueEntity.fromJson(Map<String, dynamic> json) =>
      _ScalingStatValueEntityMixin.fromJson(json);
}
