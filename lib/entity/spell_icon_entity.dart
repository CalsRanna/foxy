// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'spell_icon_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_spell_icon')
class SpellIconEntity with _SpellIconEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('TextureFilename')
  final String textureFilename;

  const SpellIconEntity({this.id = 0, this.textureFilename = ''});

  factory SpellIconEntity.fromJson(Map<String, dynamic> json) =>
      _SpellIconEntityMixin.fromJson(json);
}
