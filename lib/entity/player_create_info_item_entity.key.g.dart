// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'player_create_info_item_entity.dart';

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
  ) {
    return PlayerCreateInfoItemKey(
      race: entity.race,
      class_: entity.class_,
      itemId: entity.itemId,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoItemKey &&
            race == other.race &&
            class_ == other.class_ &&
            itemId == other.itemId;
  }

  @override
  int get hashCode => Object.hashAll([race, class_, itemId]);

  @override
  String toString() {
    return 'PlayerCreateInfoItemKey('
        'race: $race, '
        'class_: $class_, '
        'itemId: $itemId'
        ')';
  }
}
