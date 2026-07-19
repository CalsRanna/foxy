import 'package:foxy/entity/npc_text_entity.dart';

final class NpcTextKey {
  final int id;

  const NpcTextKey({required this.id});

  factory NpcTextKey.fromEntity(NpcTextEntity entity) =>
      NpcTextKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NpcTextKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
