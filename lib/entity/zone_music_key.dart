import 'package:flutter/foundation.dart';
import 'package:foxy/entity/zone_music_entity.dart';

@immutable
final class ZoneMusicKey {
  final int id;

  const ZoneMusicKey({required this.id});

  factory ZoneMusicKey.fromEntity(ZoneMusicEntity value) {
    return ZoneMusicKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is ZoneMusicKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
