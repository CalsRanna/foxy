/// 阵营模板 Picker 的精简展示模型。
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
}

/// DBC 阵营模板，对应 `foxy.dbc_faction_template` 表。
class DbcFactionTemplateEntity {
  final int id;
  final int faction;
  final int flags;
  final int factionGroup;
  final int friendGroup;
  final int enemyGroup;
  final int enemies0;
  final int enemies1;
  final int enemies2;
  final int enemies3;
  final int friend0;
  final int friend1;
  final int friend2;
  final int friend3;

  const DbcFactionTemplateEntity({
    this.id = 0,
    this.faction = 0,
    this.flags = 0,
    this.factionGroup = 0,
    this.friendGroup = 0,
    this.enemyGroup = 0,
    this.enemies0 = 0,
    this.enemies1 = 0,
    this.enemies2 = 0,
    this.enemies3 = 0,
    this.friend0 = 0,
    this.friend1 = 0,
    this.friend2 = 0,
    this.friend3 = 0,
  });

  factory DbcFactionTemplateEntity.fromJson(Map<String, dynamic> json) {
    return DbcFactionTemplateEntity(
      id: json['ID'] ?? 0,
      faction: json['Faction'] ?? 0,
      flags: json['Flags'] ?? 0,
      factionGroup: json['FactionGroup'] ?? 0,
      friendGroup: json['FriendGroup'] ?? 0,
      enemyGroup: json['EnemyGroup'] ?? 0,
      enemies0: json['Enemies0'] ?? 0,
      enemies1: json['Enemies1'] ?? 0,
      enemies2: json['Enemies2'] ?? 0,
      enemies3: json['Enemies3'] ?? 0,
      friend0: json['Friend0'] ?? 0,
      friend1: json['Friend1'] ?? 0,
      friend2: json['Friend2'] ?? 0,
      friend3: json['Friend3'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Faction': faction,
      'Flags': flags,
      'FactionGroup': factionGroup,
      'FriendGroup': friendGroup,
      'EnemyGroup': enemyGroup,
      'Enemies0': enemies0,
      'Enemies1': enemies1,
      'Enemies2': enemies2,
      'Enemies3': enemies3,
      'Friend0': friend0,
      'Friend1': friend1,
      'Friend2': friend2,
      'Friend3': friend3,
    };
  }
}
