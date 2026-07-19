import 'package:foxy/entity/creature_display_info_entity.dart';

class CreatureDisplayInfoKey {
  final int id;

  const CreatureDisplayInfoKey({required this.id});

  factory CreatureDisplayInfoKey.fromEntity(CreatureDisplayInfoEntity entity) =>
      CreatureDisplayInfoKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreatureDisplayInfoKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
