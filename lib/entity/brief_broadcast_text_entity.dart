import 'package:foxy/entity/broadcast_text_key.dart';

class BriefBroadcastTextEntity {
  final int id;
  final String maleText;
  final int languageId;

  const BriefBroadcastTextEntity({
    this.id = 0,
    this.maleText = '',
    this.languageId = 0,
  });

  factory BriefBroadcastTextEntity.fromJson(Map<String, dynamic> json) {
    return BriefBroadcastTextEntity(
      id: json['ID'] ?? 0,
      maleText: json['MaleText'] ?? json['display_text'] ?? '',
      languageId: json['LanguageID'] ?? 0,
    );
  }

  BroadcastTextKey get key => BroadcastTextKey(id: id);
}
