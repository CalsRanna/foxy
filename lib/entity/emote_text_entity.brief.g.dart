// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefEmoteTextEntity {
  final int id;
  final String name;
  final int emoteId;

  const BriefEmoteTextEntity({this.id = 0, this.name = '', this.emoteId = 0});

  factory BriefEmoteTextEntity.fromJson(Map<String, dynamic> json) {
    return BriefEmoteTextEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      name: json['Name']?.toString() ?? '',
      emoteId: (json['EmoteID'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
