import 'package:foxy/entity/gem_property_entity.dart';

class GemPropertyKey {
  final int id;

  const GemPropertyKey({required this.id});

  factory GemPropertyKey.fromEntity(GemPropertyEntity entity) =>
      GemPropertyKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is GemPropertyKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
