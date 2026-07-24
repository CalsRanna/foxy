// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scaling_stat_value_entity.dart';

mixin _ScalingStatValueEntityMixin {
  int get id;
  int get charlevel;
  int get shoulderBudget;
  int get trinketBudget;
  int get weaponBudget1H;
  int get rangedBudget;
  int get clothShoulderArmor;
  int get leatherShoulderArmor;
  int get mailShoulderArmor;
  int get plateShoulderArmor;
  int get weaponDPS1H;
  int get weaponDPS2H;
  int get spellcasterDPS1H;
  int get spellcasterDPS2H;
  int get rangedDPS;
  int get wandDPS;
  int get spellPower;
  int get primaryBudget;
  int get tertiaryBudget;
  int get clothCloakArmor;
  int get clothChestArmor;
  int get leatherChestArmor;
  int get mailChestArmor;
  int get plateChestArmor;

  static ScalingStatValueEntity fromJson(Map<String, dynamic> json) {
    return ScalingStatValueEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      charlevel: (json['Charlevel'] as num?)?.toInt() ?? 0,
      shoulderBudget: (json['ShoulderBudget'] as num?)?.toInt() ?? 0,
      trinketBudget: (json['TrinketBudget'] as num?)?.toInt() ?? 0,
      weaponBudget1H: (json['WeaponBudget1H'] as num?)?.toInt() ?? 0,
      rangedBudget: (json['RangedBudget'] as num?)?.toInt() ?? 0,
      clothShoulderArmor: (json['ClothShoulderArmor'] as num?)?.toInt() ?? 0,
      leatherShoulderArmor:
          (json['LeatherShoulderArmor'] as num?)?.toInt() ?? 0,
      mailShoulderArmor: (json['MailShoulderArmor'] as num?)?.toInt() ?? 0,
      plateShoulderArmor: (json['PlateShoulderArmor'] as num?)?.toInt() ?? 0,
      weaponDPS1H: (json['WeaponDPS1H'] as num?)?.toInt() ?? 0,
      weaponDPS2H: (json['WeaponDPS2H'] as num?)?.toInt() ?? 0,
      spellcasterDPS1H: (json['SpellcasterDPS1H'] as num?)?.toInt() ?? 0,
      spellcasterDPS2H: (json['SpellcasterDPS2H'] as num?)?.toInt() ?? 0,
      rangedDPS: (json['RangedDPS'] as num?)?.toInt() ?? 0,
      wandDPS: (json['WandDPS'] as num?)?.toInt() ?? 0,
      spellPower: (json['SpellPower'] as num?)?.toInt() ?? 0,
      primaryBudget: (json['PrimaryBudget'] as num?)?.toInt() ?? 0,
      tertiaryBudget: (json['TertiaryBudget'] as num?)?.toInt() ?? 0,
      clothCloakArmor: (json['ClothCloakArmor'] as num?)?.toInt() ?? 0,
      clothChestArmor: (json['ClothChestArmor'] as num?)?.toInt() ?? 0,
      leatherChestArmor: (json['LeatherChestArmor'] as num?)?.toInt() ?? 0,
      mailChestArmor: (json['MailChestArmor'] as num?)?.toInt() ?? 0,
      plateChestArmor: (json['PlateChestArmor'] as num?)?.toInt() ?? 0,
    );
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
    return ScalingStatValueEntity(
      id: id ?? this.id,
      charlevel: charlevel ?? this.charlevel,
      shoulderBudget: shoulderBudget ?? this.shoulderBudget,
      trinketBudget: trinketBudget ?? this.trinketBudget,
      weaponBudget1H: weaponBudget1H ?? this.weaponBudget1H,
      rangedBudget: rangedBudget ?? this.rangedBudget,
      clothShoulderArmor: clothShoulderArmor ?? this.clothShoulderArmor,
      leatherShoulderArmor: leatherShoulderArmor ?? this.leatherShoulderArmor,
      mailShoulderArmor: mailShoulderArmor ?? this.mailShoulderArmor,
      plateShoulderArmor: plateShoulderArmor ?? this.plateShoulderArmor,
      weaponDPS1H: weaponDPS1H ?? this.weaponDPS1H,
      weaponDPS2H: weaponDPS2H ?? this.weaponDPS2H,
      spellcasterDPS1H: spellcasterDPS1H ?? this.spellcasterDPS1H,
      spellcasterDPS2H: spellcasterDPS2H ?? this.spellcasterDPS2H,
      rangedDPS: rangedDPS ?? this.rangedDPS,
      wandDPS: wandDPS ?? this.wandDPS,
      spellPower: spellPower ?? this.spellPower,
      primaryBudget: primaryBudget ?? this.primaryBudget,
      tertiaryBudget: tertiaryBudget ?? this.tertiaryBudget,
      clothCloakArmor: clothCloakArmor ?? this.clothCloakArmor,
      clothChestArmor: clothChestArmor ?? this.clothChestArmor,
      leatherChestArmor: leatherChestArmor ?? this.leatherChestArmor,
      mailChestArmor: mailChestArmor ?? this.mailChestArmor,
      plateChestArmor: plateChestArmor ?? this.plateChestArmor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Charlevel': charlevel,
      'ShoulderBudget': shoulderBudget,
      'TrinketBudget': trinketBudget,
      'WeaponBudget1H': weaponBudget1H,
      'RangedBudget': rangedBudget,
      'ClothShoulderArmor': clothShoulderArmor,
      'LeatherShoulderArmor': leatherShoulderArmor,
      'MailShoulderArmor': mailShoulderArmor,
      'PlateShoulderArmor': plateShoulderArmor,
      'WeaponDPS1H': weaponDPS1H,
      'WeaponDPS2H': weaponDPS2H,
      'SpellcasterDPS1H': spellcasterDPS1H,
      'SpellcasterDPS2H': spellcasterDPS2H,
      'RangedDPS': rangedDPS,
      'WandDPS': wandDPS,
      'SpellPower': spellPower,
      'PrimaryBudget': primaryBudget,
      'TertiaryBudget': tertiaryBudget,
      'ClothCloakArmor': clothCloakArmor,
      'ClothChestArmor': clothChestArmor,
      'LeatherChestArmor': leatherChestArmor,
      'MailChestArmor': mailChestArmor,
      'PlateChestArmor': plateChestArmor,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ScalingStatValueEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            charlevel == other.charlevel &&
            shoulderBudget == other.shoulderBudget &&
            trinketBudget == other.trinketBudget &&
            weaponBudget1H == other.weaponBudget1H &&
            rangedBudget == other.rangedBudget &&
            clothShoulderArmor == other.clothShoulderArmor &&
            leatherShoulderArmor == other.leatherShoulderArmor &&
            mailShoulderArmor == other.mailShoulderArmor &&
            plateShoulderArmor == other.plateShoulderArmor &&
            weaponDPS1H == other.weaponDPS1H &&
            weaponDPS2H == other.weaponDPS2H &&
            spellcasterDPS1H == other.spellcasterDPS1H &&
            spellcasterDPS2H == other.spellcasterDPS2H &&
            rangedDPS == other.rangedDPS &&
            wandDPS == other.wandDPS &&
            spellPower == other.spellPower &&
            primaryBudget == other.primaryBudget &&
            tertiaryBudget == other.tertiaryBudget &&
            clothCloakArmor == other.clothCloakArmor &&
            clothChestArmor == other.clothChestArmor &&
            leatherChestArmor == other.leatherChestArmor &&
            mailChestArmor == other.mailChestArmor &&
            plateChestArmor == other.plateChestArmor;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      charlevel,
      shoulderBudget,
      trinketBudget,
      weaponBudget1H,
      rangedBudget,
      clothShoulderArmor,
      leatherShoulderArmor,
      mailShoulderArmor,
      plateShoulderArmor,
      weaponDPS1H,
      weaponDPS2H,
      spellcasterDPS1H,
      spellcasterDPS2H,
      rangedDPS,
      wandDPS,
      spellPower,
      primaryBudget,
      tertiaryBudget,
      clothCloakArmor,
      clothChestArmor,
      leatherChestArmor,
      mailChestArmor,
      plateChestArmor,
    ]);
  }

  @override
  String toString() {
    return 'ScalingStatValueEntity('
        'id: $id, '
        'charlevel: $charlevel, '
        'shoulderBudget: $shoulderBudget, '
        'trinketBudget: $trinketBudget, '
        'weaponBudget1H: $weaponBudget1H, '
        'rangedBudget: $rangedBudget, '
        'clothShoulderArmor: $clothShoulderArmor, '
        'leatherShoulderArmor: $leatherShoulderArmor, '
        'mailShoulderArmor: $mailShoulderArmor, '
        'plateShoulderArmor: $plateShoulderArmor, '
        'weaponDPS1H: $weaponDPS1H, '
        'weaponDPS2H: $weaponDPS2H, '
        'spellcasterDPS1H: $spellcasterDPS1H, '
        'spellcasterDPS2H: $spellcasterDPS2H, '
        'rangedDPS: $rangedDPS, '
        'wandDPS: $wandDPS, '
        'spellPower: $spellPower, '
        'primaryBudget: $primaryBudget, '
        'tertiaryBudget: $tertiaryBudget, '
        'clothCloakArmor: $clothCloakArmor, '
        'clothChestArmor: $clothChestArmor, '
        'leatherChestArmor: $leatherChestArmor, '
        'mailChestArmor: $mailChestArmor, '
        'plateChestArmor: $plateChestArmor'
        ')';
  }
}
