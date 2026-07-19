import 'package:foxy/entity/spell_rank_entity.dart';

final class SpellRankKey {
  final int firstSpellId;
  final int rank;

  const SpellRankKey({required this.firstSpellId, required this.rank});

  factory SpellRankKey.fromEntity(SpellRankEntity entity) {
    return SpellRankKey(firstSpellId: entity.firstSpellId, rank: entity.rank);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpellRankKey &&
          other.firstSpellId == firstSpellId &&
          other.rank == rank;

  @override
  int get hashCode => Object.hash(firstSpellId, rank);
}
