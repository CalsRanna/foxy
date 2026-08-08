import 'package:foxy_annotation/entity_annotations.dart';

part 'spell_group_entity.g.dart';

/// Spell groups

@FoxyBriefEntity()
@FoxyFullEntity()
class SpellGroupEntity with _SpellGroupEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('id', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('spell_id', key: true)
  final int spellId;

  const SpellGroupEntity({this.id = 0, this.spellId = 0});

  factory SpellGroupEntity.fromJson(Map<String, dynamic> json) =>
      _SpellGroupEntityMixin.fromJson(json);
}
