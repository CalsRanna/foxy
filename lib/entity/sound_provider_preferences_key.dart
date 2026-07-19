import 'package:flutter/foundation.dart';
import 'package:foxy/entity/sound_provider_preferences_entity.dart';

@immutable
final class SoundProviderPreferencesKey {
  final int id;

  const SoundProviderPreferencesKey({required this.id});

  factory SoundProviderPreferencesKey.fromEntity(
    SoundProviderPreferencesEntity value,
  ) {
    return SoundProviderPreferencesKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SoundProviderPreferencesKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
