// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'spell_rank_entity.dart';

final class SpellRankKey {
  final int firstSpellId;
  final int rank;

  const SpellRankKey({required this.firstSpellId, required this.rank});

  factory SpellRankKey.fromEntity(SpellRankEntity entity) {
    return SpellRankKey(firstSpellId: entity.firstSpellId, rank: entity.rank);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellRankKey &&
            firstSpellId == other.firstSpellId &&
            rank == other.rank;
  }

  @override
  int get hashCode => Object.hashAll([firstSpellId, rank]);

  @override
  String toString() {
    return 'SpellRankKey('
        'firstSpellId: $firstSpellId, '
        'rank: $rank'
        ')';
  }
}
