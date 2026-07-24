import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_template_addon_entity.g.dart';

/// 生物模板附加数据

@FoxyBriefEntity()
@FoxyFullEntity(table: 'creature_template_addon')
class CreatureTemplateAddonEntity with _CreatureTemplateAddonEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('entry', key: true)
  final int entry;

  @FoxyBriefField()
  @FoxyFullField('path_id')
  final int pathId;

  @FoxyBriefField()
  @FoxyFullField('mount')
  final int mount;

  @FoxyBriefField()
  @FoxyFullField('emote')
  final int emote;

  @FoxyFullField('bytes1')
  final int bytes1;

  @FoxyFullField('bytes2')
  final int bytes2;

  @FoxyFullField('visibilityDistanceType')
  final int visibilityDistanceType;

  @FoxyBriefField()
  @FoxyFullField('auras')
  final String auras;

  const CreatureTemplateAddonEntity({
    this.entry = 0,
    this.pathId = 0,
    this.mount = 0,
    this.emote = 0,
    this.bytes1 = 0,
    this.bytes2 = 0,
    this.visibilityDistanceType = 0,
    this.auras = '',
  });

  factory CreatureTemplateAddonEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureTemplateAddonEntityMixin.fromJson(json);
}
