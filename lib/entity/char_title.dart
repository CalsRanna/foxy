class CharTitle {
  final int id;
  final String nameLangZhCn;

  const CharTitle({this.id = 0, this.nameLangZhCn = ''});

  factory CharTitle.fromJson(Map<String, dynamic> json) {
    return CharTitle(
      id: json['ID'] ?? 0,
      nameLangZhCn: json['Name_lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'Name_lang_zhCN': nameLangZhCn};
  }
}
