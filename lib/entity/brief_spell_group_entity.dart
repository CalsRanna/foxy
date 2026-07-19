import 'package:foxy/entity/spell_group_key.dart';

class BriefSpellGroupEntity {
  final int id;
  final int spellId;

  const BriefSpellGroupEntity({this.id = 0, this.spellId = 0});

  factory BriefSpellGroupEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellGroupEntity(
      id: json['id'] ?? 0,
      spellId: json['spell_id'] ?? 0,
    );
  }

  SpellGroupKey get key => SpellGroupKey(id: id, spellId: spellId);
}
