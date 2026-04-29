class ItemRandomPropertiesEntity {
  final int id;
  final String name;
  final String nameLangZhCn;

  const ItemRandomPropertiesEntity({
    this.id = 0,
    this.name = '',
    this.nameLangZhCn = '',
  });

  factory ItemRandomPropertiesEntity.fromJson(Map<String, dynamic> json) {
    return ItemRandomPropertiesEntity(
      id: json['ID'] ?? 0,
      name: json['Name'] ?? '',
      nameLangZhCn: json['Name_lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'Name': name, 'Name_lang_zhCN': nameLangZhCn};
  }
}
