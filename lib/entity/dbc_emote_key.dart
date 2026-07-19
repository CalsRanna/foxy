import 'package:flutter/foundation.dart';
import 'package:foxy/entity/dbc_emote_entity.dart';

@immutable
final class DbcEmoteKey {
  final int id;

  const DbcEmoteKey({required this.id});

  factory DbcEmoteKey.fromEntity(DbcEmoteEntity value) {
    return DbcEmoteKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is DbcEmoteKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
