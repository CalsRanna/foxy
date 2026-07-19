import 'package:foxy/entity/dbc_faction_template_key.dart';

class BriefDbcFactionTemplateEntity {
  final int id;
  final int faction;
  final String factionNameZhCN;
  final String factionNameEnUS;
  final int flags;
  final int factionGroup;
  final int friendGroup;
  final int enemyGroup;

  const BriefDbcFactionTemplateEntity({
    this.id = 0,
    this.faction = 0,
    this.factionNameZhCN = '',
    this.factionNameEnUS = '',
    this.flags = 0,
    this.factionGroup = 0,
    this.friendGroup = 0,
    this.enemyGroup = 0,
  });

  factory BriefDbcFactionTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefDbcFactionTemplateEntity(
      id: json['ID'] ?? 0,
      faction: json['Faction'] ?? 0,
      factionNameZhCN: json['FactionNameZhCN'] ?? '',
      factionNameEnUS: json['FactionNameEnUS'] ?? '',
      flags: json['Flags'] ?? 0,
      factionGroup: json['FactionGroup'] ?? 0,
      friendGroup: json['FriendGroup'] ?? 0,
      enemyGroup: json['EnemyGroup'] ?? 0,
    );
  }

  String get displayName =>
      factionNameZhCN.isNotEmpty ? factionNameZhCN : factionNameEnUS;

  DbcFactionTemplateKey get key => DbcFactionTemplateKey(id: id);
}
