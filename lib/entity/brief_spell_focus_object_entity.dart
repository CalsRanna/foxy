import 'package:foxy/entity/spell_focus_object_key.dart';

class BriefSpellFocusObjectEntity {
  final int id;
  final String nameLangZhCN;
  final String nameLangEnUS;

  const BriefSpellFocusObjectEntity({
    this.id = 0,
    this.nameLangZhCN = '',
    this.nameLangEnUS = '',
  });

  factory BriefSpellFocusObjectEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellFocusObjectEntity(
      id: json['ID'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      nameLangEnUS: json['Name_lang_enUS'] ?? '',
    );
  }

  String get displayName =>
      nameLangZhCN.isNotEmpty ? nameLangZhCN : nameLangEnUS;

  SpellFocusObjectKey get key => SpellFocusObjectKey(id: id);
}
