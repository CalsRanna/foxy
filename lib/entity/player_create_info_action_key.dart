import 'package:foxy/entity/player_create_info_entity.dart';

final class PlayerCreateInfoActionKey {
  final int race;
  final int class_;
  final int button;

  const PlayerCreateInfoActionKey({
    required this.race,
    required this.class_,
    required this.button,
  });

  factory PlayerCreateInfoActionKey.fromEntity(
    PlayerCreateInfoActionEntity entity,
  ) => PlayerCreateInfoActionKey(
    race: entity.race,
    class_: entity.class_,
    button: entity.button,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerCreateInfoActionKey &&
          other.race == race &&
          other.class_ == class_ &&
          other.button == button;

  @override
  int get hashCode => Object.hash(race, class_, button);
}
