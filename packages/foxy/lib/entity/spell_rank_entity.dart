import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'spell_rank_entity.g.dart';

/// Spell ranks

@FoxyBriefEntity()
@FoxyBriefField.text('firstSpellName')
@FoxyBriefField.text('firstSpellSubtext')
@FoxyBriefField.text('firstSpellTextureFilename')
@FoxyBriefField.text('spellName')
@FoxyBriefField.text('spellSubtext')
@FoxyBriefField.text('textureFilename')
@FoxyFullEntity(table: 'spell_ranks')
class SpellRankEntity with _SpellRankEntityMixin {
  @FoxyBriefField()
  @FoxyFieldMeaning.reference('首个法术', table: 'foxy.dbc_spell', column: 'ID')
  @FoxyFullField('first_spell_id', key: true)
  final int firstSpellId;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('法术', table: 'foxy.dbc_spell', column: 'ID')
  @FoxyFullField('spell_id')
  final int spellId;

  @FoxyBriefField()
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
