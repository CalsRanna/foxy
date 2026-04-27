class ItemRandomSuffix {
  int id = 0;
  String nameLangZhCn = '';
  String internalName = '';

  ItemRandomSuffix();

  ItemRandomSuffix.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    nameLangZhCn = json['Name_lang_zhCN'] ?? '';
    internalName = json['InternalName'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name_lang_zhCN': nameLangZhCn,
      'InternalName': internalName,
    };
  }
}
