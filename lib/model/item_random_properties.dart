class ItemRandomProperties {
  int id = 0;
  String name = '';
  String nameLangZhCn = '';

  ItemRandomProperties();

  factory ItemRandomProperties.fromJson(Map<String, dynamic> json) {
    return ItemRandomProperties()
      ..id = json['ID'] ?? 0
      ..name = json['Name'] ?? ''
      ..nameLangZhCn = json['Name_lang_zhCN'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'Name_lang_zhCN': nameLangZhCn,
    };
  }
}
