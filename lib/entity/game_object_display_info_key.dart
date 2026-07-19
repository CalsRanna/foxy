import 'package:flutter/foundation.dart';
import 'package:foxy/entity/game_object_display_info_entity.dart';

@immutable
final class GameObjectDisplayInfoKey {
  final int id;

  const GameObjectDisplayInfoKey({required this.id});

  factory GameObjectDisplayInfoKey.fromEntity(
    GameObjectDisplayInfoEntity value,
  ) {
    return GameObjectDisplayInfoKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectDisplayInfoKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
