// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'game_object_loot_template_entity.dart';

final class GameObjectLootTemplateKey {
  final int entry;
  final int item;

  const GameObjectLootTemplateKey({required this.entry, required this.item});

  factory GameObjectLootTemplateKey.fromEntity(
    GameObjectLootTemplateEntity entity,
  ) {
    return GameObjectLootTemplateKey(entry: entity.entry, item: entity.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hashAll([entry, item]);

  @override
  String toString() {
    return 'GameObjectLootTemplateKey('
        'entry: $entry, '
        'item: $item'
        ')';
  }
}
