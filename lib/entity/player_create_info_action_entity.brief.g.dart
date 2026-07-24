// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'player_create_info_action_entity.key.g.dart';

final class BriefPlayerCreateInfoActionEntity {
  final int race;
  final int class_;
  final int button;
  final int action;
  final int type;

  const BriefPlayerCreateInfoActionEntity({
    this.race = 0,
    this.class_ = 0,
    this.button = 0,
    this.action = 0,
    this.type = 0,
  });

  factory BriefPlayerCreateInfoActionEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefPlayerCreateInfoActionEntity(
      race: (json['race'] as num?)?.toInt() ?? 0,
      class_: (json['class'] as num?)?.toInt() ?? 0,
      button: (json['button'] as num?)?.toInt() ?? 0,
      action: (json['action'] as num?)?.toInt() ?? 0,
      type: (json['type'] as num?)?.toInt() ?? 0,
    );
  }

  PlayerCreateInfoActionKey get key {
    return PlayerCreateInfoActionKey(
      race: race,
      class_: class_,
      button: button,
    );
  }
}
