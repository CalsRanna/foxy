import 'package:foxy/entity/emote_text_key.dart';

class BriefEmoteTextEntity {
  final int id;
  final String name;
  final int emoteId;

  const BriefEmoteTextEntity({this.id = 0, this.name = '', this.emoteId = 0});

  factory BriefEmoteTextEntity.fromJson(Map<String, dynamic> json) {
    return BriefEmoteTextEntity(
      id: json['ID'] ?? 0,
      name: json['Name'] ?? '',
      emoteId: json['EmoteID'] ?? 0,
    );
  }

  EmoteTextKey get key => EmoteTextKey(id: id);
}
