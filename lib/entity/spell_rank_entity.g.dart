// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_rank_entity.dart';

mixin _SpellRankEntityMixin {
  int get firstSpellId;
  int get spellId;
  int get rank;

  static SpellRankEntity fromJson(Map<String, dynamic> json) {
    return SpellRankEntity(
      firstSpellId: (json['first_spell_id'] as num?)?.toInt() ?? 0,
      spellId: (json['spell_id'] as num?)?.toInt() ?? 0,
      rank: (json['rank'] as num?)?.toInt() ?? 0,
    );
  }

  SpellRankEntity copyWith({int? firstSpellId, int? spellId, int? rank}) {
    return SpellRankEntity(
      firstSpellId: firstSpellId ?? this.firstSpellId,
      spellId: spellId ?? this.spellId,
      rank: rank ?? this.rank,
    );
  }

  Map<String, dynamic> toJson() {
    return {'first_spell_id': firstSpellId, 'spell_id': spellId, 'rank': rank};
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellRankEntity &&
            runtimeType == other.runtimeType &&
            firstSpellId == other.firstSpellId &&
            spellId == other.spellId &&
            rank == other.rank;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, firstSpellId, spellId, rank]);
  }

  @override
  String toString() {
    return 'SpellRankEntity('
        'firstSpellId: $firstSpellId, '
        'spellId: $spellId, '
        'rank: $rank'
        ')';
  }
}
