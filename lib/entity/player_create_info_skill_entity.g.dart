// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_skill_entity.dart';

mixin _PlayerCreateInfoSkillEntityMixin {
  static PlayerCreateInfoSkillEntity fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoSkillEntity(
      raceMask: (json['raceMask'] as num?)?.toInt() ?? 0,
      classMask: (json['classMask'] as num?)?.toInt() ?? 0,
      skill: (json['skill'] as num?)?.toInt() ?? 0,
      rank: (json['rank'] as num?)?.toInt() ?? 0,
      comment: json['comment']?.toString() ?? '',
    );
  }

  PlayerCreateInfoSkillEntity copyWith({
    int? raceMask,
    int? classMask,
    int? skill,
    int? rank,
    String? comment,
  }) {
    final self = this as PlayerCreateInfoSkillEntity;
    return PlayerCreateInfoSkillEntity(
      raceMask: raceMask ?? self.raceMask,
      classMask: classMask ?? self.classMask,
      skill: skill ?? self.skill,
      rank: rank ?? self.rank,
      comment: comment ?? self.comment,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as PlayerCreateInfoSkillEntity;
    return {
      'raceMask': self.raceMask,
      'classMask': self.classMask,
      'skill': self.skill,
      'rank': self.rank,
      'comment': self.comment,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as PlayerCreateInfoSkillEntity;
    return identical(self, other) ||
        other is PlayerCreateInfoSkillEntity &&
            self.runtimeType == other.runtimeType &&
            self.raceMask == other.raceMask &&
            self.classMask == other.classMask &&
            self.skill == other.skill &&
            self.rank == other.rank &&
            self.comment == other.comment;
  }

  @override
  int get hashCode {
    final self = this as PlayerCreateInfoSkillEntity;
    return Object.hashAll([
      self.runtimeType,
      self.raceMask,
      self.classMask,
      self.skill,
      self.rank,
      self.comment,
    ]);
  }

  @override
  String toString() {
    final self = this as PlayerCreateInfoSkillEntity;
    return 'PlayerCreateInfoSkillEntity('
        'raceMask: ${self.raceMask}, '
        'classMask: ${self.classMask}, '
        'skill: ${self.skill}, '
        'rank: ${self.rank}, '
        'comment: ${self.comment}'
        ')';
  }
}
