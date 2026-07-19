import 'package:flutter/foundation.dart';
import 'package:foxy/entity/holiday_entity.dart';

@immutable
final class HolidayKey {
  final int id;

  const HolidayKey({required this.id});

  factory HolidayKey.fromEntity(HolidayEntity value) {
    return HolidayKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is HolidayKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
