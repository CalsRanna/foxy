import 'package:foxy/entity/char_title_key.dart';

class BriefCharTitleEntity {
  final int id;
  final String nameLangZhCN;

  const BriefCharTitleEntity({this.id = 0, this.nameLangZhCN = ''});

  factory BriefCharTitleEntity.fromJson(Map<String, dynamic> json) {
    return BriefCharTitleEntity(
      id: json['ID'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
    );
  }

  CharTitleKey get key => CharTitleKey(id: id);
}
