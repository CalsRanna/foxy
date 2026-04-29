class ItemRandomSuffix {
  final int id;
  final String nameLangZhCn;
  final String internalName;

  const ItemRandomSuffix({
    this.id = 0,
    this.nameLangZhCn = '',
    this.internalName = '',
  });

  factory ItemRandomSuffix.fromJson(Map<String, dynamic> json) {
    return ItemRandomSuffix(
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
