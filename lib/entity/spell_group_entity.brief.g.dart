// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'spell_group_entity.key.g.dart';

final class BriefSpellGroupEntity {
  final int id;
  final int spellId;

  const BriefSpellGroupEntity({this.id = 0, this.spellId = 0});

  factory BriefSpellGroupEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellGroupEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      spellId: (json['spell_id'] as num?)?.toInt() ?? 0,
    );
  }

  SpellGroupKey get key {
    return SpellGroupKey(id: id, spellId: spellId);
  }
}
