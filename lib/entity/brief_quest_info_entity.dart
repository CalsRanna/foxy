import 'package:foxy/entity/quest_info_key.dart';

class BriefQuestInfoEntity {
  final int id;
  final String infoNameLangZhCN;

  const BriefQuestInfoEntity({this.id = 0, this.infoNameLangZhCN = ''});

  factory BriefQuestInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestInfoEntity(
      id: json['ID'] ?? 0,
      infoNameLangZhCN: json['InfoName_lang_zhCN'] ?? '',
    );
  }

  QuestInfoKey get key => QuestInfoKey(id: id);
}
