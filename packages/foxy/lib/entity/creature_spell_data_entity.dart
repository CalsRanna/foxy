import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'creature_spell_data_entity.g.dart';

/// Pet spell data — maps to the foxy.dbc_creature_spell_data table

@FoxyBriefEntity()
@FoxyBriefField.text('spellName1')
@FoxyBriefField.text('spellName2')
@FoxyBriefField.text('spellName3')
@FoxyBriefField.text('spellName4')
@FoxyBriefField.text('textureFilename1')
@FoxyBriefField.text('textureFilename2')
@FoxyBriefField.text('textureFilename3')
@FoxyBriefField.text('textureFilename4')
@FoxyFullEntity(table: 'foxy.dbc_creature_spell_data')
class CreatureSpellDataEntity with _CreatureSpellDataEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('法术0', table: 'foxy.dbc_spell', column: 'ID')
  @FoxyFullField('Spells0')
  final int spells0;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('法术1', table: 'foxy.dbc_spell', column: 'ID')
  @FoxyFullField('Spells1')
  final int spells1;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('法术2', table: 'foxy.dbc_spell', column: 'ID')
  @FoxyFullField('Spells2')
  final int spells2;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('法术3', table: 'foxy.dbc_spell', column: 'ID')
  @FoxyFullField('Spells3')
  final int spells3;

  @FoxyFullField('Availability0')
  final int availability0;

  @FoxyFullField('Availability1')
  final int availability1;

  @FoxyFullField('Availability2')
  final int availability2;

  @FoxyFullField('Availability3')
  final int availability3;

  const CreatureSpellDataEntity({
    this.id = 0,
    this.spells0 = 0,
    this.spells1 = 0,
    this.spells2 = 0,
    this.spells3 = 0,
    this.availability0 = 0,
    this.availability1 = 0,
    this.availability2 = 0,
    this.availability3 = 0,
  });

  factory CreatureSpellDataEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureSpellDataEntityMixin.fromJson(json);
}
