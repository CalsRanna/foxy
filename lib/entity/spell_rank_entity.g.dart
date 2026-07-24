// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_rank_entity.dart';

mixin _SpellRankEntityMixin {
  static SpellRankEntity fromJson(Map<String, dynamic> json) {
    return SpellRankEntity(
      firstSpellId: (json['first_spell_id'] as num?)?.toInt() ?? 0,
      spellId: (json['spell_id'] as num?)?.toInt() ?? 0,
      rank: (json['rank'] as num?)?.toInt() ?? 0,
    );
  }

  SpellRankEntity copyWith({int? firstSpellId, int? spellId, int? rank}) {
    final self = this as SpellRankEntity;
    return SpellRankEntity(
      firstSpellId: firstSpellId ?? self.firstSpellId,
      spellId: spellId ?? self.spellId,
      rank: rank ?? self.rank,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SpellRankEntity;
    return {
      'first_spell_id': self.firstSpellId,
      'spell_id': self.spellId,
      'rank': self.rank,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as SpellRankEntity;
    return identical(self, other) ||
        other is SpellRankEntity &&
            self.runtimeType == other.runtimeType &&
            self.firstSpellId == other.firstSpellId &&
            self.spellId == other.spellId &&
            self.rank == other.rank;
  }

  @override
  int get hashCode {
    final self = this as SpellRankEntity;
    return Object.hashAll([
      self.runtimeType,
      self.firstSpellId,
      self.spellId,
      self.rank,
    ]);
  }

  @override
  String toString() {
    final self = this as SpellRankEntity;
    return 'SpellRankEntity('
        'firstSpellId: ${self.firstSpellId}, '
        'spellId: ${self.spellId}, '
        'rank: ${self.rank}'
        ')';
  }
}
