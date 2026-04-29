class ItemRandomSuffixEntity {
  final int id;
  final String nameLangZhCn;
  final String internalName;

  const ItemRandomSuffixEntity({
    this.id = 0,
    this.nameLangZhCn = '',
    this.internalName = '',
  });

  factory ItemRandomSuffixEntity.fromJson(Map<String, dynamic> json) {
    return ItemRandomSuffixEntity(
      id: json['ID'] ?? 0,
      nameLangZhCn: json['Name_lang_zhCN'] ?? '',
      internalName: json['InternalName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name_lang_zhCN': nameLangZhCn,
      'InternalName': internalName,
    };
  }
}
