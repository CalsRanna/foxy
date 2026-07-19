import 'package:foxy/entity/player_create_info_entity.dart';

final class PlayerCreateInfoItemKey {
  final int race;
  final int class_;
  final int itemId;

  const PlayerCreateInfoItemKey({
    required this.race,
    required this.class_,
    required this.itemId,
  });

  factory PlayerCreateInfoItemKey.fromEntity(
    PlayerCreateInfoItemEntity entity,
  ) => PlayerCreateInfoItemKey(
    race: entity.race,
    class_: entity.class_,
    itemId: entity.itemid,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerCreateInfoItemKey &&
          other.race == race &&
          other.class_ == class_ &&
          other.itemId == itemId;

  @override
  int get hashCode => Object.hash(race, class_, itemId);
}
