class CharTitle {
  int id = 0;
  String nameLangZhCn = '';

  CharTitle();

  CharTitle.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    nameLangZhCn = json['Name_lang_zhCN'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name_lang_zhCN': nameLangZhCn,
    };
  }
}
