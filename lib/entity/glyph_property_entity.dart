import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'glyph_property_entity.g.dart';

@FoxyBriefEntity()
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
