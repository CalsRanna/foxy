import 'package:foxy_annotation/entity_annotations.dart';

part 'glyph_property_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('spellName')
@FoxyBriefField.text('localeSpellName')
@FoxyBriefField.text('textureFilename')
@FoxyFullEntity(table: 'foxy.dbc_glyph_properties')
class GlyphPropertyEntity with _GlyphPropertyEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('SpellID')
  final int spellId;

  @FoxyBriefField()
  @FoxyFullField('GlyphSlotFlags')
  final int glyphSlotFlags;

  @FoxyBriefField()
  @FoxyFullField('SpellIconID')
  final int spellIconId;

  const GlyphPropertyEntity({
    this.id = 0,
    this.spellId = 0,
    this.glyphSlotFlags = 0,
    this.spellIconId = 0,
  });

  factory GlyphPropertyEntity.fromJson(Map<String, dynamic> json) =>
      _GlyphPropertyEntityMixin.fromJson(json);
}

extension BriefGlyphPropertyEntityDisplay on BriefGlyphPropertyEntity {
  /// Display spell name: zhCN when available, enUS otherwise.
  String get displaySpellName =>
      localeSpellName.isNotEmpty ? localeSpellName : spellName;
}
