// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_spell_data_entity.dart';

mixin _CreatureSpellDataEntityMixin {
  int get id;
  int get spells0;
  int get spells1;
  int get spells2;
  int get spells3;
  int get availability0;
  int get availability1;
  int get availability2;
  int get availability3;

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
    return CreatureSpellDataEntity(
      id: id ?? this.id,
      spells0: spells0 ?? this.spells0,
      spells1: spells1 ?? this.spells1,
      spells2: spells2 ?? this.spells2,
      spells3: spells3 ?? this.spells3,
      availability0: availability0 ?? this.availability0,
      availability1: availability1 ?? this.availability1,
      availability2: availability2 ?? this.availability2,
      availability3: availability3 ?? this.availability3,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Spells0': spells0,
      'Spells1': spells1,
      'Spells2': spells2,
      'Spells3': spells3,
      'Availability0': availability0,
      'Availability1': availability1,
      'Availability2': availability2,
      'Availability3': availability3,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureSpellDataEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            spells0 == other.spells0 &&
            spells1 == other.spells1 &&
            spells2 == other.spells2 &&
            spells3 == other.spells3 &&
            availability0 == other.availability0 &&
            availability1 == other.availability1 &&
            availability2 == other.availability2 &&
            availability3 == other.availability3;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      spells0,
      spells1,
      spells2,
      spells3,
      availability0,
      availability1,
      availability2,
      availability3,
    ]);
  }

  @override
  String toString() {
    return 'CreatureSpellDataEntity('
        'id: $id, '
        'spells0: $spells0, '
        'spells1: $spells1, '
        'spells2: $spells2, '
        'spells3: $spells3, '
        'availability0: $availability0, '
        'availability1: $availability1, '
        'availability2: $availability2, '
        'availability3: $availability3'
        ')';
  }
}
