import 'package:flutter/foundation.dart';
import 'package:foxy/entity/zone_intro_music_entity.dart';

@immutable
final class ZoneIntroMusicKey {
  final int id;

  const ZoneIntroMusicKey({required this.id});

  factory ZoneIntroMusicKey.fromEntity(ZoneIntroMusicEntity value) {
    return ZoneIntroMusicKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ZoneIntroMusicKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
