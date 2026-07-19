import 'package:foxy/entity/broadcast_text_entity.dart';

class BroadcastTextKey {
  final int id;

  const BroadcastTextKey({required this.id});

  factory BroadcastTextKey.fromEntity(BroadcastTextEntity entity) =>
      BroadcastTextKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BroadcastTextKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
