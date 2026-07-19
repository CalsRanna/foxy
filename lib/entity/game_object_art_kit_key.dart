import 'package:flutter/foundation.dart';
import 'package:foxy/entity/game_object_art_kit_entity.dart';

@immutable
final class GameObjectArtKitKey {
  final int id;

  const GameObjectArtKitKey({required this.id});

  factory GameObjectArtKitKey.fromEntity(GameObjectArtKitEntity value) {
    return GameObjectArtKitKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GameObjectArtKitKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
