class CharTitleEntity {
  final int id;
  final String nameLangZhCn;

  const CharTitleEntity({this.id = 0, this.nameLangZhCn = ''});

  factory CharTitleEntity.fromJson(Map<String, dynamic> json) {
    return CharTitleEntity(
      id: json['ID'] ?? 0,
      nameLangZhCn: json['Name_lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'Name_lang_zhCN': nameLangZhCn};
  }
}
