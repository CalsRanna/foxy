import 'package:foxy/entity/spell_entity.dart';

final class SpellKey {
  final int id;

  const SpellKey({required this.id});

  factory SpellKey.fromEntity(SpellEntity entity) {
    return SpellKey(id: entity.id);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SpellKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
