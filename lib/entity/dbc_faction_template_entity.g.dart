// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_faction_template_entity.dart';

mixin _DbcFactionTemplateEntityMixin {
  static DbcFactionTemplateEntity fromJson(Map<String, dynamic> json) {
    return DbcFactionTemplateEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      faction: (json['Faction'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      factionGroup: (json['FactionGroup'] as num?)?.toInt() ?? 0,
      friendGroup: (json['FriendGroup'] as num?)?.toInt() ?? 0,
      enemyGroup: (json['EnemyGroup'] as num?)?.toInt() ?? 0,
      enemies0: (json['Enemies0'] as num?)?.toInt() ?? 0,
      enemies1: (json['Enemies1'] as num?)?.toInt() ?? 0,
      enemies2: (json['Enemies2'] as num?)?.toInt() ?? 0,
      enemies3: (json['Enemies3'] as num?)?.toInt() ?? 0,
      friend0: (json['Friend0'] as num?)?.toInt() ?? 0,
      friend1: (json['Friend1'] as num?)?.toInt() ?? 0,
      friend2: (json['Friend2'] as num?)?.toInt() ?? 0,
      friend3: (json['Friend3'] as num?)?.toInt() ?? 0,
    );
  }

  DbcFactionTemplateEntity copyWith({
    int? id,
    int? faction,
    int? flags,
    int? factionGroup,
    int? friendGroup,
    int? enemyGroup,
    int? enemies0,
    int? enemies1,
    int? enemies2,
    int? enemies3,
    int? friend0,
    int? friend1,
    int? friend2,
    int? friend3,
  }) {
    final self = this as DbcFactionTemplateEntity;
    return DbcFactionTemplateEntity(
      id: id ?? self.id,
      faction: faction ?? self.faction,
      flags: flags ?? self.flags,
      factionGroup: factionGroup ?? self.factionGroup,
      friendGroup: friendGroup ?? self.friendGroup,
      enemyGroup: enemyGroup ?? self.enemyGroup,
      enemies0: enemies0 ?? self.enemies0,
      enemies1: enemies1 ?? self.enemies1,
      enemies2: enemies2 ?? self.enemies2,
      enemies3: enemies3 ?? self.enemies3,
      friend0: friend0 ?? self.friend0,
      friend1: friend1 ?? self.friend1,
      friend2: friend2 ?? self.friend2,
      friend3: friend3 ?? self.friend3,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as DbcFactionTemplateEntity;
    return {
      'ID': self.id,
      'Faction': self.faction,
      'Flags': self.flags,
      'FactionGroup': self.factionGroup,
      'FriendGroup': self.friendGroup,
      'EnemyGroup': self.enemyGroup,
      'Enemies0': self.enemies0,
      'Enemies1': self.enemies1,
      'Enemies2': self.enemies2,
      'Enemies3': self.enemies3,
      'Friend0': self.friend0,
      'Friend1': self.friend1,
      'Friend2': self.friend2,
      'Friend3': self.friend3,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as DbcFactionTemplateEntity;
    return identical(self, other) ||
        other is DbcFactionTemplateEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.faction == other.faction &&
            self.flags == other.flags &&
            self.factionGroup == other.factionGroup &&
            self.friendGroup == other.friendGroup &&
            self.enemyGroup == other.enemyGroup &&
            self.enemies0 == other.enemies0 &&
            self.enemies1 == other.enemies1 &&
            self.enemies2 == other.enemies2 &&
            self.enemies3 == other.enemies3 &&
            self.friend0 == other.friend0 &&
            self.friend1 == other.friend1 &&
            self.friend2 == other.friend2 &&
            self.friend3 == other.friend3;
  }

  @override
  int get hashCode {
    final self = this as DbcFactionTemplateEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.faction,
      self.flags,
      self.factionGroup,
      self.friendGroup,
      self.enemyGroup,
      self.enemies0,
      self.enemies1,
      self.enemies2,
      self.enemies3,
      self.friend0,
      self.friend1,
      self.friend2,
      self.friend3,
    ]);
  }

  @override
  String toString() {
    final self = this as DbcFactionTemplateEntity;
    return 'DbcFactionTemplateEntity('
        'id: ${self.id}, '
        'faction: ${self.faction}, '
        'flags: ${self.flags}, '
        'factionGroup: ${self.factionGroup}, '
        'friendGroup: ${self.friendGroup}, '
        'enemyGroup: ${self.enemyGroup}, '
        'enemies0: ${self.enemies0}, '
        'enemies1: ${self.enemies1}, '
        'enemies2: ${self.enemies2}, '
        'enemies3: ${self.enemies3}, '
        'friend0: ${self.friend0}, '
        'friend1: ${self.friend1}, '
        'friend2: ${self.friend2}, '
        'friend3: ${self.friend3}'
        ')';
  }
}
