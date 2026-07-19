import 'package:foxy/entity/dbc_faction_template_entity.dart';

class DbcFactionTemplateKey {
  final int id;

  const DbcFactionTemplateKey({required this.id});

  factory DbcFactionTemplateKey.fromEntity(DbcFactionTemplateEntity entity) =>
      DbcFactionTemplateKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DbcFactionTemplateKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
