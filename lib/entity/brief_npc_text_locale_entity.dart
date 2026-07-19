import 'package:foxy/entity/npc_text_locale_key.dart';

/// NPC 文本本地化列表展示模型。
class BriefNpcTextLocaleEntity {
  final int id;
  final String locale;

  const BriefNpcTextLocaleEntity({this.id = 0, this.locale = 'zhCN'});

  factory BriefNpcTextLocaleEntity.fromJson(Map<String, dynamic> json) {
    return BriefNpcTextLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['Locale']?.toString() ?? 'zhCN',
    );
  }

  NpcTextLocaleKey get key => NpcTextLocaleKey(id: id, locale: locale);
}
