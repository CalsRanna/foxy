import 'package:flutter/foundation.dart';
import 'package:foxy/entity/cinematic_sequence_entity.dart';

@immutable
final class CinematicSequenceKey {
  final int id;

  const CinematicSequenceKey({required this.id});

  factory CinematicSequenceKey.fromEntity(CinematicSequenceEntity value) {
    return CinematicSequenceKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CinematicSequenceKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
