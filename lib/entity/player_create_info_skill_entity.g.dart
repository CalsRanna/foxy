// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_skill_entity.dart';

mixin _PlayerCreateInfoSkillEntityMixin {
  int get raceMask;
  int get classMask;
  int get skill;
  int get rank;
  String get comment;

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
    return PlayerCreateInfoSkillEntity(
      raceMask: raceMask ?? this.raceMask,
      classMask: classMask ?? this.classMask,
      skill: skill ?? this.skill,
      rank: rank ?? this.rank,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'raceMask': raceMask,
      'classMask': classMask,
      'skill': skill,
      'rank': rank,
      'comment': comment,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoSkillEntity &&
            runtimeType == other.runtimeType &&
            raceMask == other.raceMask &&
            classMask == other.classMask &&
            skill == other.skill &&
            rank == other.rank &&
            comment == other.comment;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      raceMask,
      classMask,
      skill,
      rank,
      comment,
    ]);
  }

  @override
  String toString() {
    return 'PlayerCreateInfoSkillEntity('
        'raceMask: $raceMask, '
        'classMask: $classMask, '
        'skill: $skill, '
        'rank: $rank, '
        'comment: $comment'
        ')';
  }
}
