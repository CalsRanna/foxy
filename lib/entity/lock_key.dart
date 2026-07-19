import 'package:foxy/entity/lock_entity.dart';

class LockKey {
  final int id;

  const LockKey({required this.id});

  factory LockKey.fromEntity(LockEntity entity) => LockKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is LockKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
