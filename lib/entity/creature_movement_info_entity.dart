import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_movement_info_entity.g.dart';

/// DBC 生物移动信息，对应 `foxy.dbc_creature_movement_info` 表。

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_creature_movement_info')
class CreatureMovementInfoEntity with _CreatureMovementInfoEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('SmoothFacingChaseRate')
  final double smoothFacingChaseRate;

  const CreatureMovementInfoEntity({
    this.id = 0,
    this.smoothFacingChaseRate = 0,
  });

  factory CreatureMovementInfoEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureMovementInfoEntityMixin.fromJson(json);
}
