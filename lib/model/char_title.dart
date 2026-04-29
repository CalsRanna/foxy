class CharTitle {
  int id = 0;
  String nameLangZhCn = '';

  CharTitle();

  factory CharTitle.fromJson(Map<String, dynamic> json) {
    return CharTitle()
      ..id = json['ID'] ?? 0
      ..nameLangZhCn = json['Name_lang_zhCN'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name_lang_zhCN': nameLangZhCn,
    };
  }
}
