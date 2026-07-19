import 'package:flutter/foundation.dart';
import 'package:foxy/entity/taxi_path_entity.dart';

@immutable
final class TaxiPathKey {
  final int id;

  const TaxiPathKey({required this.id});

  factory TaxiPathKey.fromEntity(TaxiPathEntity value) {
    return TaxiPathKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is TaxiPathKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
