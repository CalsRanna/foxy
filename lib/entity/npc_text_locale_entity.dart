/// npc_text_locale 本地化模型（复合键: ID + Locale）
///
/// 每行包含 8 组 × (Text{n}_0 / Text{n}_1) 共 16 个文本字段。
class NpcTextLocaleEntity {
  final int id;
  final String locale;
  final List<List<String>> texts;

  const NpcTextLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.texts = const [],
  });

  factory NpcTextLocaleEntity.fromJson(Map<String, dynamic> json) {
    return NpcTextLocaleEntity(
      id: (json['ID'] ?? json['id'] ?? 0) as int,
      locale: json['Locale']?.toString() ?? 'zhCN',
      texts: List.generate(
        8,
        (n) => [
          json['Text${n}_0']?.toString() ?? '',
          json['Text${n}_1']?.toString() ?? '',
        ],
      ),
    );
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
