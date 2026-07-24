// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_spell_data_entity.dart';

mixin _CreatureSpellDataEntityMixin {
  static CreatureSpellDataEntity fromJson(Map<String, dynamic> json) {
    return CreatureSpellDataEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      spells0: (json['Spells0'] as num?)?.toInt() ?? 0,
      spells1: (json['Spells1'] as num?)?.toInt() ?? 0,
      spells2: (json['Spells2'] as num?)?.toInt() ?? 0,
      spells3: (json['Spells3'] as num?)?.toInt() ?? 0,
      availability0: (json['Availability0'] as num?)?.toInt() ?? 0,
      availability1: (json['Availability1'] as num?)?.toInt() ?? 0,
      availability2: (json['Availability2'] as num?)?.toInt() ?? 0,
      availability3: (json['Availability3'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureSpellDataEntity copyWith({
    int? id,
    int? spells0,
    int? spells1,
    int? spells2,
    int? spells3,
    int? availability0,
    int? availability1,
    int? availability2,
    int? availability3,
  }) {
    final self = this as CreatureSpellDataEntity;
    return CreatureSpellDataEntity(
      id: id ?? self.id,
      spells0: spells0 ?? self.spells0,
      spells1: spells1 ?? self.spells1,
      spells2: spells2 ?? self.spells2,
      spells3: spells3 ?? self.spells3,
      availability0: availability0 ?? self.availability0,
      availability1: availability1 ?? self.availability1,
      availability2: availability2 ?? self.availability2,
      availability3: availability3 ?? self.availability3,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureSpellDataEntity;
    return {
      'ID': self.id,
      'Spells0': self.spells0,
      'Spells1': self.spells1,
      'Spells2': self.spells2,
      'Spells3': self.spells3,
      'Availability0': self.availability0,
      'Availability1': self.availability1,
      'Availability2': self.availability2,
      'Availability3': self.availability3,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureSpellDataEntity;
    return identical(self, other) ||
        other is CreatureSpellDataEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.spells0 == other.spells0 &&
            self.spells1 == other.spells1 &&
            self.spells2 == other.spells2 &&
            self.spells3 == other.spells3 &&
            self.availability0 == other.availability0 &&
            self.availability1 == other.availability1 &&
            self.availability2 == other.availability2 &&
            self.availability3 == other.availability3;
  }

  @override
  int get hashCode {
    final self = this as CreatureSpellDataEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.spells0,
      self.spells1,
      self.spells2,
      self.spells3,
      self.availability0,
      self.availability1,
      self.availability2,
      self.availability3,
    ]);
  }

  @override
  String toString() {
    final self = this as CreatureSpellDataEntity;
    return 'CreatureSpellDataEntity('
        'id: ${self.id}, '
        'spells0: ${self.spells0}, '
        'spells1: ${self.spells1}, '
        'spells2: ${self.spells2}, '
        'spells3: ${self.spells3}, '
        'availability0: ${self.availability0}, '
        'availability1: ${self.availability1}, '
        'availability2: ${self.availability2}, '
        'availability3: ${self.availability3}'
        ')';
  }
}

final class BriefCreatureSpellDataEntity {
  final int id;
  final int spells0;
  final int spells1;
  final int spells2;
  final int spells3;
  final String spellName1;
  final String spellName2;
  final String spellName3;
  final String spellName4;

  const BriefCreatureSpellDataEntity({
    this.id = 0,
    this.spells0 = 0,
    this.spells1 = 0,
    this.spells2 = 0,
    this.spells3 = 0,
    this.spellName1 = '',
    this.spellName2 = '',
    this.spellName3 = '',
    this.spellName4 = '',
  });

  factory BriefCreatureSpellDataEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureSpellDataEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      spells0: (json['Spells0'] as num?)?.toInt() ?? 0,
      spells1: (json['Spells1'] as num?)?.toInt() ?? 0,
      spells2: (json['Spells2'] as num?)?.toInt() ?? 0,
      spells3: (json['Spells3'] as num?)?.toInt() ?? 0,
      spellName1: json['spellName1']?.toString() ?? '',
      spellName2: json['spellName2']?.toString() ?? '',
      spellName3: json['spellName3']?.toString() ?? '',
      spellName4: json['spellName4']?.toString() ?? '',
    );
  }

  int get key => id;
}
