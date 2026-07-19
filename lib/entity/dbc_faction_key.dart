import 'package:foxy/entity/dbc_faction_entity.dart';

class DbcFactionKey {
  final int id;

  const DbcFactionKey({required this.id});

  factory DbcFactionKey.fromEntity(DbcFactionEntity entity) =>
      DbcFactionKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DbcFactionKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
