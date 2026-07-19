import 'package:foxy/entity/game_object_template_addon_entity.dart';

final class GameObjectTemplateAddonKey {
  final int entry;

  const GameObjectTemplateAddonKey({required this.entry});

  factory GameObjectTemplateAddonKey.fromEntity(
    GameObjectTemplateAddonEntity entity,
  ) {
    return GameObjectTemplateAddonKey(entry: entity.entry);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameObjectTemplateAddonKey && other.entry == entry;

  @override
  int get hashCode => entry.hashCode;
}
