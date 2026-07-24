// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'player_create_info_entity.dart';

final class PlayerCreateInfoKey {
  final int race;
  final int class_;

  const PlayerCreateInfoKey({required this.race, required this.class_});

  factory PlayerCreateInfoKey.fromEntity(PlayerCreateInfoEntity entity) {
    return PlayerCreateInfoKey(race: entity.race, class_: entity.class_);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoKey &&
            race == other.race &&
            class_ == other.class_;
  }

  @override
  int get hashCode => Object.hashAll([race, class_]);

  @override
  String toString() {
    return 'PlayerCreateInfoKey('
        'race: $race, '
        'class_: $class_'
        ')';
  }
}
