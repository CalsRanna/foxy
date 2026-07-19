import 'package:foxy/entity/player_create_info_entity.dart';

final class PlayerCreateInfoKey {
  final int race;
  final int class_;

  const PlayerCreateInfoKey({required this.race, required this.class_});

  factory PlayerCreateInfoKey.fromEntity(PlayerCreateInfoEntity entity) =>
      PlayerCreateInfoKey(race: entity.race, class_: entity.class_);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerCreateInfoKey &&
          other.race == race &&
          other.class_ == class_;

  @override
  int get hashCode => Object.hash(race, class_);
}
