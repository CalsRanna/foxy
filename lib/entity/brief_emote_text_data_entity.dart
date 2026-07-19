import 'package:foxy/entity/emote_text_data_key.dart';

class BriefEmoteTextDataEntity {
  final int id;
  final String textLangZhCN;

  const BriefEmoteTextDataEntity({this.id = 0, this.textLangZhCN = ''});

  factory BriefEmoteTextDataEntity.fromJson(Map<String, dynamic> json) {
    return BriefEmoteTextDataEntity(
      id: json['ID'] ?? 0,
      textLangZhCN: json['Text_lang_zhCN'] ?? '',
    );
  }

  EmoteTextDataKey get key => EmoteTextDataKey(id: id);
}
