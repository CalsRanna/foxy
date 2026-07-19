import 'package:flutter/foundation.dart';
import 'package:foxy/entity/sound_ambience_entity.dart';

@immutable
final class SoundAmbienceKey {
  final int id;

  const SoundAmbienceKey({required this.id});

  factory SoundAmbienceKey.fromEntity(SoundAmbienceEntity value) {
    return SoundAmbienceKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SoundAmbienceKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
