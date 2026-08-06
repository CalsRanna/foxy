// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_rank_entity.dart';

final class BriefSpellRankEntity {
  final int firstSpellId;
  final int spellId;
  final int rank;
  final String firstSpellName;
  final String firstSpellSubtext;
  final String spellName;
  final String spellSubtext;

  const BriefSpellRankEntity({
    this.firstSpellId = 0,
    this.spellId = 0,
    this.rank = 0,
    this.firstSpellName = '',
    this.firstSpellSubtext = '',
    this.spellName = '',
    this.spellSubtext = '',
  });

  factory BriefSpellRankEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellRankEntity(
      firstSpellId: json['first_spell_id'] == true
          ? 1
          : json['first_spell_id'] == false
          ? 0
          : (json['first_spell_id'] as num?)?.toInt() ?? 0,
      spellId: json['spell_id'] == true
          ? 1
          : json['spell_id'] == false
          ? 0
          : (json['spell_id'] as num?)?.toInt() ?? 0,
      rank: json['rank'] == true
          ? 1
          : json['rank'] == false
          ? 0
          : (json['rank'] as num?)?.toInt() ?? 0,
      firstSpellName: json['firstSpellName']?.toString() ?? '',
      firstSpellSubtext: json['firstSpellSubtext']?.toString() ?? '',
      spellName: json['spellName']?.toString() ?? '',
      spellSubtext: json['spellSubtext']?.toString() ?? '',
    );
  }

  @override
  int get hashCode => Object.hashAll([
    firstSpellId,
    spellId,
    rank,
    firstSpellName,
    firstSpellSubtext,
    spellName,
    spellSubtext,
  ]);

  SpellRankKey get key {
    return SpellRankKey(firstSpellId: firstSpellId, rank: rank);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefSpellRankEntity &&
            firstSpellId == other.firstSpellId &&
            spellId == other.spellId &&
            rank == other.rank &&
            firstSpellName == other.firstSpellName &&
            firstSpellSubtext == other.firstSpellSubtext &&
            spellName == other.spellName &&
            spellSubtext == other.spellSubtext;
  }

  @override
  String toString() {
    return 'BriefSpellRankEntity('
        'firstSpellId: $firstSpellId, '
        'spellId: $spellId, '
        'rank: $rank, '
        'firstSpellName: $firstSpellName, '
        'firstSpellSubtext: $firstSpellSubtext, '
        'spellName: $spellName, '
        'spellSubtext: $spellSubtext'
        ')';
  }
}

final class SpellRankKey {
  final int firstSpellId;
  final int rank;

  const SpellRankKey({required this.firstSpellId, required this.rank});

  factory SpellRankKey.fromEntity(SpellRankEntity entity) {
    return SpellRankKey(firstSpellId: entity.firstSpellId, rank: entity.rank);
  }

  @override
  int get hashCode => Object.hashAll([firstSpellId, rank]);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellRankKey &&
            firstSpellId == other.firstSpellId &&
            rank == other.rank;
  }

  @override
  String toString() {
    return 'SpellRankKey('
        'firstSpellId: $firstSpellId, '
        'rank: $rank'
        ')';
  }
}

mixin _SpellRankEntityMixin {
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
  bool operator ==(Object other) {
    final self = this as SpellRankEntity;
    return identical(self, other) ||
        other is SpellRankEntity &&
            self.runtimeType == other.runtimeType &&
            self.firstSpellId == other.firstSpellId &&
            self.spellId == other.spellId &&
            self.rank == other.rank;
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
  String toString() {
    final self = this as SpellRankEntity;
    return 'SpellRankEntity('
        'firstSpellId: ${self.firstSpellId}, '
        'spellId: ${self.spellId}, '
        'rank: ${self.rank}'
        ')';
  }

  static SpellRankEntity fromJson(Map<String, dynamic> json) {
    return SpellRankEntity(
      firstSpellId: json['first_spell_id'] == true
          ? 1
          : json['first_spell_id'] == false
          ? 0
          : (json['first_spell_id'] as num?)?.toInt() ?? 0,
      spellId: json['spell_id'] == true
          ? 1
          : json['spell_id'] == false
          ? 0
          : (json['spell_id'] as num?)?.toInt() ?? 0,
      rank: json['rank'] == true
          ? 1
          : json['rank'] == false
          ? 0
          : (json['rank'] as num?)?.toInt() ?? 0,
    );
  }
}
