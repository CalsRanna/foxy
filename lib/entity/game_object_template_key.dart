import 'package:foxy/entity/game_object_template_entity.dart';

class GameObjectTemplateKey {
  final int entry;

  const GameObjectTemplateKey({required this.entry});

  factory GameObjectTemplateKey.fromEntity(GameObjectTemplateEntity entity) {
    return GameObjectTemplateKey(entry: entity.entry);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameObjectTemplateKey && other.entry == entry;

  @override
  int get hashCode => entry.hashCode;
}
