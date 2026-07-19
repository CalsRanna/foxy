import 'package:foxy/entity/player_create_info_action_key.dart';

class BriefPlayerCreateInfoActionEntity {
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
  ) => BriefPlayerCreateInfoActionEntity(
    race: json['race'] ?? 0,
    class_: json['class'] ?? 0,
    button: json['button'] ?? 0,
    action: json['action'] ?? 0,
    type: json['type'] ?? 0,
  );

  PlayerCreateInfoActionKey get key =>
      PlayerCreateInfoActionKey(race: race, class_: class_, button: button);
}
