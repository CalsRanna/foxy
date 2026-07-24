import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'spell_rank_entity.g.dart';

/// 法术技能排行

@FoxyFullEntity(table: 'spell_ranks')
class SpellRankEntity with _SpellRankEntityMixin {
  @FoxyFullField('first_spell_id', key: true)
  final int firstSpellId;

  @FoxyFullField('spell_id')
  final int spellId;

  @FoxyFullField('rank', key: true)
  final int rank;

  const SpellRankEntity({
    this.firstSpellId = 0,
    this.spellId = 0,
    this.rank = 0,
  });

  factory SpellRankEntity.fromJson(Map<String, dynamic> json) =>
      _SpellRankEntityMixin.fromJson(json);
}
