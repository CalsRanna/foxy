import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'dbc_faction_template_entity.g.dart';

/// DBC faction template, maps to the `foxy.dbc_faction_template` table.

@FoxyBriefEntity()
@FoxyBriefField.text('factionNameZhCN')
@FoxyBriefField.text('factionNameEnUS')
@FoxyFullEntity(table: 'foxy.dbc_faction_template')
class DbcFactionTemplateEntity with _DbcFactionTemplateEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('阵营', table: 'foxy.dbc_faction', column: 'ID')
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

  @FoxyFieldMeaning.reference('敌对阵营0', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Enemies0')
  final int enemies0;

  @FoxyFieldMeaning.reference('敌对阵营1', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Enemies1')
  final int enemies1;

  @FoxyFieldMeaning.reference('敌对阵营2', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Enemies2')
  final int enemies2;

  @FoxyFieldMeaning.reference('敌对阵营3', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Enemies3')
  final int enemies3;

  @FoxyFieldMeaning.reference('友好阵营0', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Friend0')
  final int friend0;

  @FoxyFieldMeaning.reference('友好阵营1', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Friend1')
  final int friend1;

  @FoxyFieldMeaning.reference('友好阵营2', table: 'foxy.dbc_faction', column: 'ID')
  @FoxyFullField('Friend2')
  final int friend2;

  @FoxyFieldMeaning.reference('友好阵营3', table: 'foxy.dbc_faction', column: 'ID')
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
