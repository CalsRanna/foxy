// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scaling_stat_value_entity.dart';

final class BriefScalingStatValueEntity {
  final int id;
  final int charlevel;
  final int shoulderBudget;
  final int trinketBudget;
  final int weaponBudget1H;
  final int rangedBudget;
  final int primaryBudget;
  final int tertiaryBudget;

  const BriefScalingStatValueEntity({
    this.id = 0,
    this.charlevel = 0,
    this.shoulderBudget = 0,
    this.trinketBudget = 0,
    this.weaponBudget1H = 0,
    this.rangedBudget = 0,
    this.primaryBudget = 0,
    this.tertiaryBudget = 0,
  });

  factory BriefScalingStatValueEntity.fromJson(Map<String, dynamic> json) {
    return BriefScalingStatValueEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      charlevel: json['Charlevel'] == true
          ? 1
          : json['Charlevel'] == false
          ? 0
          : (json['Charlevel'] as num?)?.toInt() ?? 0,
      shoulderBudget: json['ShoulderBudget'] == true
          ? 1
          : json['ShoulderBudget'] == false
          ? 0
          : (json['ShoulderBudget'] as num?)?.toInt() ?? 0,
      trinketBudget: json['TrinketBudget'] == true
          ? 1
          : json['TrinketBudget'] == false
          ? 0
          : (json['TrinketBudget'] as num?)?.toInt() ?? 0,
      weaponBudget1H: json['WeaponBudget1H'] == true
          ? 1
          : json['WeaponBudget1H'] == false
          ? 0
          : (json['WeaponBudget1H'] as num?)?.toInt() ?? 0,
      rangedBudget: json['RangedBudget'] == true
          ? 1
          : json['RangedBudget'] == false
          ? 0
          : (json['RangedBudget'] as num?)?.toInt() ?? 0,
      primaryBudget: json['PrimaryBudget'] == true
          ? 1
          : json['PrimaryBudget'] == false
          ? 0
          : (json['PrimaryBudget'] as num?)?.toInt() ?? 0,
      tertiaryBudget: json['TertiaryBudget'] == true
          ? 1
          : json['TertiaryBudget'] == false
          ? 0
          : (json['TertiaryBudget'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    charlevel,
    shoulderBudget,
    trinketBudget,
    weaponBudget1H,
    rangedBudget,
    primaryBudget,
    tertiaryBudget,
  ]);

  int get key => id;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefScalingStatValueEntity &&
            id == other.id &&
            charlevel == other.charlevel &&
            shoulderBudget == other.shoulderBudget &&
            trinketBudget == other.trinketBudget &&
            weaponBudget1H == other.weaponBudget1H &&
            rangedBudget == other.rangedBudget &&
            primaryBudget == other.primaryBudget &&
            tertiaryBudget == other.tertiaryBudget;
  }

  @override
  String toString() {
    return 'BriefScalingStatValueEntity('
        'id: $id, '
        'charlevel: $charlevel, '
        'shoulderBudget: $shoulderBudget, '
        'trinketBudget: $trinketBudget, '
        'weaponBudget1H: $weaponBudget1H, '
        'rangedBudget: $rangedBudget, '
        'primaryBudget: $primaryBudget, '
        'tertiaryBudget: $tertiaryBudget'
        ')';
  }
}

mixin _ScalingStatValueEntityMixin {
  @override
  int get hashCode {
    final self = this as ScalingStatValueEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.charlevel,
      self.shoulderBudget,
      self.trinketBudget,
      self.weaponBudget1H,
      self.rangedBudget,
      self.clothShoulderArmor,
      self.leatherShoulderArmor,
      self.mailShoulderArmor,
      self.plateShoulderArmor,
      self.weaponDPS1H,
      self.weaponDPS2H,
      self.spellcasterDPS1H,
      self.spellcasterDPS2H,
      self.rangedDPS,
      self.wandDPS,
      self.spellPower,
      self.primaryBudget,
      self.tertiaryBudget,
      self.clothCloakArmor,
      self.clothChestArmor,
      self.leatherChestArmor,
      self.mailChestArmor,
      self.plateChestArmor,
    ]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as ScalingStatValueEntity;
    return identical(self, other) ||
        other is ScalingStatValueEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.charlevel == other.charlevel &&
            self.shoulderBudget == other.shoulderBudget &&
            self.trinketBudget == other.trinketBudget &&
            self.weaponBudget1H == other.weaponBudget1H &&
            self.rangedBudget == other.rangedBudget &&
            self.clothShoulderArmor == other.clothShoulderArmor &&
            self.leatherShoulderArmor == other.leatherShoulderArmor &&
            self.mailShoulderArmor == other.mailShoulderArmor &&
            self.plateShoulderArmor == other.plateShoulderArmor &&
            self.weaponDPS1H == other.weaponDPS1H &&
            self.weaponDPS2H == other.weaponDPS2H &&
            self.spellcasterDPS1H == other.spellcasterDPS1H &&
            self.spellcasterDPS2H == other.spellcasterDPS2H &&
            self.rangedDPS == other.rangedDPS &&
            self.wandDPS == other.wandDPS &&
            self.spellPower == other.spellPower &&
            self.primaryBudget == other.primaryBudget &&
            self.tertiaryBudget == other.tertiaryBudget &&
            self.clothCloakArmor == other.clothCloakArmor &&
            self.clothChestArmor == other.clothChestArmor &&
            self.leatherChestArmor == other.leatherChestArmor &&
            self.mailChestArmor == other.mailChestArmor &&
            self.plateChestArmor == other.plateChestArmor;
  }

  ScalingStatValueEntity copyWith({
    int? id,
    int? charlevel,
    int? shoulderBudget,
    int? trinketBudget,
    int? weaponBudget1H,
    int? rangedBudget,
    int? clothShoulderArmor,
    int? leatherShoulderArmor,
    int? mailShoulderArmor,
    int? plateShoulderArmor,
    int? weaponDPS1H,
    int? weaponDPS2H,
    int? spellcasterDPS1H,
    int? spellcasterDPS2H,
    int? rangedDPS,
    int? wandDPS,
    int? spellPower,
    int? primaryBudget,
    int? tertiaryBudget,
    int? clothCloakArmor,
    int? clothChestArmor,
    int? leatherChestArmor,
    int? mailChestArmor,
    int? plateChestArmor,
  }) {
    final self = this as ScalingStatValueEntity;
    return ScalingStatValueEntity(
      id: id ?? self.id,
      charlevel: charlevel ?? self.charlevel,
      shoulderBudget: shoulderBudget ?? self.shoulderBudget,
      trinketBudget: trinketBudget ?? self.trinketBudget,
      weaponBudget1H: weaponBudget1H ?? self.weaponBudget1H,
      rangedBudget: rangedBudget ?? self.rangedBudget,
      clothShoulderArmor: clothShoulderArmor ?? self.clothShoulderArmor,
      leatherShoulderArmor: leatherShoulderArmor ?? self.leatherShoulderArmor,
      mailShoulderArmor: mailShoulderArmor ?? self.mailShoulderArmor,
      plateShoulderArmor: plateShoulderArmor ?? self.plateShoulderArmor,
      weaponDPS1H: weaponDPS1H ?? self.weaponDPS1H,
      weaponDPS2H: weaponDPS2H ?? self.weaponDPS2H,
      spellcasterDPS1H: spellcasterDPS1H ?? self.spellcasterDPS1H,
      spellcasterDPS2H: spellcasterDPS2H ?? self.spellcasterDPS2H,
      rangedDPS: rangedDPS ?? self.rangedDPS,
      wandDPS: wandDPS ?? self.wandDPS,
      spellPower: spellPower ?? self.spellPower,
      primaryBudget: primaryBudget ?? self.primaryBudget,
      tertiaryBudget: tertiaryBudget ?? self.tertiaryBudget,
      clothCloakArmor: clothCloakArmor ?? self.clothCloakArmor,
      clothChestArmor: clothChestArmor ?? self.clothChestArmor,
      leatherChestArmor: leatherChestArmor ?? self.leatherChestArmor,
      mailChestArmor: mailChestArmor ?? self.mailChestArmor,
      plateChestArmor: plateChestArmor ?? self.plateChestArmor,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as ScalingStatValueEntity;
    return {
      'ID': self.id,
      'Charlevel': self.charlevel,
      'ShoulderBudget': self.shoulderBudget,
      'TrinketBudget': self.trinketBudget,
      'WeaponBudget1H': self.weaponBudget1H,
      'RangedBudget': self.rangedBudget,
      'ClothShoulderArmor': self.clothShoulderArmor,
      'LeatherShoulderArmor': self.leatherShoulderArmor,
      'MailShoulderArmor': self.mailShoulderArmor,
      'PlateShoulderArmor': self.plateShoulderArmor,
      'WeaponDPS1H': self.weaponDPS1H,
      'WeaponDPS2H': self.weaponDPS2H,
      'SpellcasterDPS1H': self.spellcasterDPS1H,
      'SpellcasterDPS2H': self.spellcasterDPS2H,
      'RangedDPS': self.rangedDPS,
      'WandDPS': self.wandDPS,
      'SpellPower': self.spellPower,
      'PrimaryBudget': self.primaryBudget,
      'TertiaryBudget': self.tertiaryBudget,
      'ClothCloakArmor': self.clothCloakArmor,
      'ClothChestArmor': self.clothChestArmor,
      'LeatherChestArmor': self.leatherChestArmor,
      'MailChestArmor': self.mailChestArmor,
      'PlateChestArmor': self.plateChestArmor,
    };
  }

  @override
  String toString() {
    final self = this as ScalingStatValueEntity;
    return 'ScalingStatValueEntity('
        'id: ${self.id}, '
        'charlevel: ${self.charlevel}, '
        'shoulderBudget: ${self.shoulderBudget}, '
        'trinketBudget: ${self.trinketBudget}, '
        'weaponBudget1H: ${self.weaponBudget1H}, '
        'rangedBudget: ${self.rangedBudget}, '
        'clothShoulderArmor: ${self.clothShoulderArmor}, '
        'leatherShoulderArmor: ${self.leatherShoulderArmor}, '
        'mailShoulderArmor: ${self.mailShoulderArmor}, '
        'plateShoulderArmor: ${self.plateShoulderArmor}, '
        'weaponDPS1H: ${self.weaponDPS1H}, '
        'weaponDPS2H: ${self.weaponDPS2H}, '
        'spellcasterDPS1H: ${self.spellcasterDPS1H}, '
        'spellcasterDPS2H: ${self.spellcasterDPS2H}, '
        'rangedDPS: ${self.rangedDPS}, '
        'wandDPS: ${self.wandDPS}, '
        'spellPower: ${self.spellPower}, '
        'primaryBudget: ${self.primaryBudget}, '
        'tertiaryBudget: ${self.tertiaryBudget}, '
        'clothCloakArmor: ${self.clothCloakArmor}, '
        'clothChestArmor: ${self.clothChestArmor}, '
        'leatherChestArmor: ${self.leatherChestArmor}, '
        'mailChestArmor: ${self.mailChestArmor}, '
        'plateChestArmor: ${self.plateChestArmor}'
        ')';
  }

  static ScalingStatValueEntity fromJson(Map<String, dynamic> json) {
    return ScalingStatValueEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      charlevel: json['Charlevel'] == true
          ? 1
          : json['Charlevel'] == false
          ? 0
          : (json['Charlevel'] as num?)?.toInt() ?? 0,
      shoulderBudget: json['ShoulderBudget'] == true
          ? 1
          : json['ShoulderBudget'] == false
          ? 0
          : (json['ShoulderBudget'] as num?)?.toInt() ?? 0,
      trinketBudget: json['TrinketBudget'] == true
          ? 1
          : json['TrinketBudget'] == false
          ? 0
          : (json['TrinketBudget'] as num?)?.toInt() ?? 0,
      weaponBudget1H: json['WeaponBudget1H'] == true
          ? 1
          : json['WeaponBudget1H'] == false
          ? 0
          : (json['WeaponBudget1H'] as num?)?.toInt() ?? 0,
      rangedBudget: json['RangedBudget'] == true
          ? 1
          : json['RangedBudget'] == false
          ? 0
          : (json['RangedBudget'] as num?)?.toInt() ?? 0,
      clothShoulderArmor: json['ClothShoulderArmor'] == true
          ? 1
          : json['ClothShoulderArmor'] == false
          ? 0
          : (json['ClothShoulderArmor'] as num?)?.toInt() ?? 0,
      leatherShoulderArmor: json['LeatherShoulderArmor'] == true
          ? 1
          : json['LeatherShoulderArmor'] == false
          ? 0
          : (json['LeatherShoulderArmor'] as num?)?.toInt() ?? 0,
      mailShoulderArmor: json['MailShoulderArmor'] == true
          ? 1
          : json['MailShoulderArmor'] == false
          ? 0
          : (json['MailShoulderArmor'] as num?)?.toInt() ?? 0,
      plateShoulderArmor: json['PlateShoulderArmor'] == true
          ? 1
          : json['PlateShoulderArmor'] == false
          ? 0
          : (json['PlateShoulderArmor'] as num?)?.toInt() ?? 0,
      weaponDPS1H: json['WeaponDPS1H'] == true
          ? 1
          : json['WeaponDPS1H'] == false
          ? 0
          : (json['WeaponDPS1H'] as num?)?.toInt() ?? 0,
      weaponDPS2H: json['WeaponDPS2H'] == true
          ? 1
          : json['WeaponDPS2H'] == false
          ? 0
          : (json['WeaponDPS2H'] as num?)?.toInt() ?? 0,
      spellcasterDPS1H: json['SpellcasterDPS1H'] == true
          ? 1
          : json['SpellcasterDPS1H'] == false
          ? 0
          : (json['SpellcasterDPS1H'] as num?)?.toInt() ?? 0,
      spellcasterDPS2H: json['SpellcasterDPS2H'] == true
          ? 1
          : json['SpellcasterDPS2H'] == false
          ? 0
          : (json['SpellcasterDPS2H'] as num?)?.toInt() ?? 0,
      rangedDPS: json['RangedDPS'] == true
          ? 1
          : json['RangedDPS'] == false
          ? 0
          : (json['RangedDPS'] as num?)?.toInt() ?? 0,
      wandDPS: json['WandDPS'] == true
          ? 1
          : json['WandDPS'] == false
          ? 0
          : (json['WandDPS'] as num?)?.toInt() ?? 0,
      spellPower: json['SpellPower'] == true
          ? 1
          : json['SpellPower'] == false
          ? 0
          : (json['SpellPower'] as num?)?.toInt() ?? 0,
      primaryBudget: json['PrimaryBudget'] == true
          ? 1
          : json['PrimaryBudget'] == false
          ? 0
          : (json['PrimaryBudget'] as num?)?.toInt() ?? 0,
      tertiaryBudget: json['TertiaryBudget'] == true
          ? 1
          : json['TertiaryBudget'] == false
          ? 0
          : (json['TertiaryBudget'] as num?)?.toInt() ?? 0,
      clothCloakArmor: json['ClothCloakArmor'] == true
          ? 1
          : json['ClothCloakArmor'] == false
          ? 0
          : (json['ClothCloakArmor'] as num?)?.toInt() ?? 0,
      clothChestArmor: json['ClothChestArmor'] == true
          ? 1
          : json['ClothChestArmor'] == false
          ? 0
          : (json['ClothChestArmor'] as num?)?.toInt() ?? 0,
      leatherChestArmor: json['LeatherChestArmor'] == true
          ? 1
          : json['LeatherChestArmor'] == false
          ? 0
          : (json['LeatherChestArmor'] as num?)?.toInt() ?? 0,
      mailChestArmor: json['MailChestArmor'] == true
          ? 1
          : json['MailChestArmor'] == false
          ? 0
          : (json['MailChestArmor'] as num?)?.toInt() ?? 0,
      plateChestArmor: json['PlateChestArmor'] == true
          ? 1
          : json['PlateChestArmor'] == false
          ? 0
          : (json['PlateChestArmor'] as num?)?.toInt() ?? 0,
    );
  }
}
