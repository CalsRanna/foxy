import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'dbc_faction_template_entity.g.dart';

/// DBC 阵营模板，对应 `foxy.dbc_faction_template` 表。

@FoxyBriefEntity()
@FoxyBriefField.text('factionNameZhCN')
@FoxyBriefField.text('factionNameEnUS')
@FoxyFullEntity(table: 'foxy.dbc_faction_template')
class DbcFactionTemplateEntity with _DbcFactionTemplateEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Faction')
  final int faction;

  @FoxyBriefField()
  @FoxyFullField('Flags')
  final int flags;

  @FoxyBriefField()
  @FoxyFullField('FactionGroup')
  final int factionGroup;

  @FoxyBriefField()
  @FoxyFullField('FriendGroup')
  final int friendGroup;

  @FoxyBriefField()
  @FoxyFullField('EnemyGroup')
  final int enemyGroup;

  @FoxyFullField('Enemies0')
  final int enemies0;

  @FoxyFullField('Enemies1')
  final int enemies1;

  @FoxyFullField('Enemies2')
  final int enemies2;

  @FoxyFullField('Enemies3')
  final int enemies3;

  @FoxyFullField('Friend0')
  final int friend0;

  @FoxyFullField('Friend1')
  final int friend1;

  @FoxyFullField('Friend2')
  final int friend2;

  @FoxyFullField('Friend3')
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

  factory DbcFactionTemplateEntity.fromJson(Map<String, dynamic> json) =>
      _DbcFactionTemplateEntityMixin.fromJson(json);
}

extension BriefDbcFactionTemplateEntityDisplay
    on BriefDbcFactionTemplateEntity {
  String get displayName =>
      factionNameZhCN.isNotEmpty ? factionNameZhCN : factionNameEnUS;
}
