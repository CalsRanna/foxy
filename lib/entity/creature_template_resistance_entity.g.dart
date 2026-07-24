// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_resistance_entity.dart';

mixin _CreatureTemplateResistanceEntityMixin {
  static CreatureTemplateResistanceEntity fromJson(Map<String, dynamic> json) {
    return CreatureTemplateResistanceEntity(
      creatureID: (json['CreatureID'] as num?)?.toInt() ?? 0,
      school: (json['School'] as num?)?.toInt() ?? 0,
      resistance: (json['Resistance'] as num?)?.toInt() ?? 0,
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureTemplateResistanceEntity copyWith({
    int? creatureID,
    int? school,
    int? resistance,
    int? verifiedBuild,
  }) {
    final self = this as CreatureTemplateResistanceEntity;
    return CreatureTemplateResistanceEntity(
      creatureID: creatureID ?? self.creatureID,
      school: school ?? self.school,
      resistance: resistance ?? self.resistance,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureTemplateResistanceEntity;
    return {
      'CreatureID': self.creatureID,
      'School': self.school,
      'Resistance': self.resistance,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureTemplateResistanceEntity;
    return identical(self, other) ||
        other is CreatureTemplateResistanceEntity &&
            self.runtimeType == other.runtimeType &&
            self.creatureID == other.creatureID &&
            self.school == other.school &&
            self.resistance == other.resistance &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as CreatureTemplateResistanceEntity;
    return Object.hashAll([
      self.runtimeType,
      self.creatureID,
      self.school,
      self.resistance,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as CreatureTemplateResistanceEntity;
    return 'CreatureTemplateResistanceEntity('
        'creatureID: ${self.creatureID}, '
        'school: ${self.school}, '
        'resistance: ${self.resistance}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

final class CreatureTemplateResistanceKey {
  final int creatureID;
  final int school;

  const CreatureTemplateResistanceKey({
    required this.creatureID,
    required this.school,
  });

  factory CreatureTemplateResistanceKey.fromEntity(
    CreatureTemplateResistanceEntity entity,
  ) {
    return CreatureTemplateResistanceKey(
      creatureID: entity.creatureID,
      school: entity.school,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureTemplateResistanceKey &&
            creatureID == other.creatureID &&
            school == other.school;
  }

  @override
  int get hashCode => Object.hashAll([creatureID, school]);

  @override
  String toString() {
    return 'CreatureTemplateResistanceKey('
        'creatureID: $creatureID, '
        'school: $school'
        ')';
  }
}

final class BriefCreatureTemplateResistanceEntity {
  final int creatureID;
  final int school;
  final int resistance;
  final int verifiedBuild;

  const BriefCreatureTemplateResistanceEntity({
    this.creatureID = 0,
    this.school = 0,
    this.resistance = 0,
    this.verifiedBuild = 0,
  });

  factory BriefCreatureTemplateResistanceEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefCreatureTemplateResistanceEntity(
      creatureID: (json['CreatureID'] as num?)?.toInt() ?? 0,
      school: (json['School'] as num?)?.toInt() ?? 0,
      resistance: (json['Resistance'] as num?)?.toInt() ?? 0,
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureTemplateResistanceKey get key {
    return CreatureTemplateResistanceKey(
      creatureID: creatureID,
      school: school,
    );
  }
}
