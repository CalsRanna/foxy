// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'player_create_info_action_entity.dart';

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
  ) {
    return PlayerCreateInfoActionKey(
      race: entity.race,
      class_: entity.class_,
      button: entity.button,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoActionKey &&
            race == other.race &&
            class_ == other.class_ &&
            button == other.button;
  }

  @override
  int get hashCode => Object.hashAll([race, class_, button]);

  @override
  String toString() {
    return 'PlayerCreateInfoActionKey('
        'race: $race, '
        'class_: $class_, '
        'button: $button'
        ')';
  }
}
