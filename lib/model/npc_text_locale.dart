/// npc_text_locale 本地化模型（复合键: ID + Locale）
///
/// 每行包含 8 组 × (Text{n}_0 / Text{n}_1) 共 16 个文本字段。
class NpcTextLocale {
  int id = 0;
  String locale = 'zhCN';

  /// 8 组 × 2 个文本：texts[n][0] = Text{n}_0, texts[n][1] = Text{n}_1
  final List<List<String>> texts = List.generate(8, (_) => List.filled(2, ''));

  NpcTextLocale();

  NpcTextLocale.fromJson(Map<String, dynamic> json) {
    id = (json['ID'] ?? json['id'] ?? 0) as int;
    locale = json['Locale']?.toString() ?? 'zhCN';
    for (var n = 0; n < 8; n++) {
      texts[n][0] = json['Text${n}_0']?.toString() ?? '';
      texts[n][1] = json['Text${n}_1']?.toString() ?? '';
    }
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{'ID': id, 'Locale': locale};
    for (var n = 0; n < 8; n++) {
      result['Text${n}_0'] = texts[n][0];
      result['Text${n}_1'] = texts[n][1];
    }
    return result;
  }
}
