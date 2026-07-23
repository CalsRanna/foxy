import 'package:flutter/foundation.dart';
import 'package:foxy/entity/game_object_loot_template_entity.dart';

@immutable
final class GameObjectLootTemplateKey {
  final int entry;
  final int item;

  const GameObjectLootTemplateKey({required this.entry, required this.item});

  factory GameObjectLootTemplateKey.fromEntity(
    GameObjectLootTemplateEntity value,
  ) {
    return GameObjectLootTemplateKey(entry: value.entry, item: value.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hash(entry, item);
}
