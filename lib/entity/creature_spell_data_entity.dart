// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_spell_data_entity.g.dart';

/// 宠物技能数据 — 对应 foxy.dbc_creature_spell_data 表

@FoxyFullEntity(table: 'foxy.dbc_creature_spell_data')
class CreatureSpellDataEntity with _CreatureSpellDataEntityMixin {
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('Spells0')
  final int spells0;

  @FoxyFullField('Spells1')
  final int spells1;

  @FoxyFullField('Spells2')
  final int spells2;

  @FoxyFullField('Spells3')
  final int spells3;

  @FoxyFullField('Availability0')
  final int availability0;

  @FoxyFullField('Availability1')
  final int availability1;

  @FoxyFullField('Availability2')
  final int availability2;

  @FoxyFullField('Availability3')
  final int availability3;

  const CreatureSpellDataEntity({
    this.id = 0,
    this.spells0 = 0,
    this.spells1 = 0,
    this.spells2 = 0,
    this.spells3 = 0,
    this.availability0 = 0,
    this.availability1 = 0,
    this.availability2 = 0,
    this.availability3 = 0,
  });

  factory CreatureSpellDataEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureSpellDataEntityMixin.fromJson(json);
}
