import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'game_object_template_addon_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'gameobject_template_addon')
class GameObjectTemplateAddonEntity with _GameObjectTemplateAddonEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('entry', key: true)
  final int entry;

  @FoxyBriefField()
  @FoxyFullField('faction')
  final int faction;

  @FoxyBriefField()
  @FoxyFullField('flags')
  final int flags;

  @FoxyBriefField()
  @FoxyFullField('mingold')
  final int minGold;

  @FoxyBriefField()
  @FoxyFullField('maxgold')
  final int maxGold;

  @FoxyFullField('artkit0')
  final int artkit0;

  @FoxyFullField('artkit1')
  final int artkit1;

  @FoxyFullField('artkit2')
  final int artkit2;

  @FoxyFullField('artkit3')
  final int artkit3;

  const GameObjectTemplateAddonEntity({
    this.entry = 0,
    this.faction = 0,
    this.flags = 0,
    this.minGold = 0,
    this.maxGold = 0,
    this.artkit0 = 0,
    this.artkit1 = 0,
    this.artkit2 = 0,
    this.artkit3 = 0,
  });

  factory GameObjectTemplateAddonEntity.fromJson(Map<String, dynamic> json) =>
      _GameObjectTemplateAddonEntityMixin.fromJson(json);
}
