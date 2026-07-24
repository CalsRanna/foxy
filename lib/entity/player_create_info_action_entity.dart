// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'player_create_info_action_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'playercreateinfo_action')
class PlayerCreateInfoActionEntity with _PlayerCreateInfoActionEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('race', key: true)
  final int race;

  @FoxyBriefField()
  @FoxyFullField('class', key: true)
  final int class_;

  @FoxyBriefField()
  @FoxyFullField('button', key: true)
  final int button;

  @FoxyBriefField()
  @FoxyFullField('action')
  final int action;

  @FoxyBriefField()
  @FoxyFullField('type')
  final int type;

  const PlayerCreateInfoActionEntity({
    this.race = 0,
    this.class_ = 0,
    this.button = 0,
    this.action = 0,
    this.type = 0,
  });

  factory PlayerCreateInfoActionEntity.fromJson(Map<String, dynamic> json) =>
      _PlayerCreateInfoActionEntityMixin.fromJson(json);
}
