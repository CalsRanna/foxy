// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_faction_template_entity.dart';

mixin _DbcFactionTemplateEntityMixin {
  int get id;
  int get faction;
  int get flags;
  int get factionGroup;
  int get friendGroup;
  int get enemyGroup;
  int get enemies0;
  int get enemies1;
  int get enemies2;
  int get enemies3;
  int get friend0;
  int get friend1;
  int get friend2;
  int get friend3;

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
    return DbcFactionTemplateEntity(
      id: id ?? this.id,
      faction: faction ?? this.faction,
      flags: flags ?? this.flags,
      factionGroup: factionGroup ?? this.factionGroup,
      friendGroup: friendGroup ?? this.friendGroup,
      enemyGroup: enemyGroup ?? this.enemyGroup,
      enemies0: enemies0 ?? this.enemies0,
      enemies1: enemies1 ?? this.enemies1,
      enemies2: enemies2 ?? this.enemies2,
      enemies3: enemies3 ?? this.enemies3,
      friend0: friend0 ?? this.friend0,
      friend1: friend1 ?? this.friend1,
      friend2: friend2 ?? this.friend2,
      friend3: friend3 ?? this.friend3,
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DbcFactionTemplateEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            faction == other.faction &&
            flags == other.flags &&
            factionGroup == other.factionGroup &&
            friendGroup == other.friendGroup &&
            enemyGroup == other.enemyGroup &&
            enemies0 == other.enemies0 &&
            enemies1 == other.enemies1 &&
            enemies2 == other.enemies2 &&
            enemies3 == other.enemies3 &&
            friend0 == other.friend0 &&
            friend1 == other.friend1 &&
            friend2 == other.friend2 &&
            friend3 == other.friend3;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      faction,
      flags,
      factionGroup,
      friendGroup,
      enemyGroup,
      enemies0,
      enemies1,
      enemies2,
      enemies3,
      friend0,
      friend1,
      friend2,
      friend3,
    ]);
  }

  @override
  String toString() {
    return 'DbcFactionTemplateEntity('
        'id: $id, '
        'faction: $faction, '
        'flags: $flags, '
        'factionGroup: $factionGroup, '
        'friendGroup: $friendGroup, '
        'enemyGroup: $enemyGroup, '
        'enemies0: $enemies0, '
        'enemies1: $enemies1, '
        'enemies2: $enemies2, '
        'enemies3: $enemies3, '
        'friend0: $friend0, '
        'friend1: $friend1, '
        'friend2: $friend2, '
        'friend3: $friend3'
        ')';
  }
}
