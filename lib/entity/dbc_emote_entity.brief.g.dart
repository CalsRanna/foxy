// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefDbcEmoteEntity {
  final int id;
  final String slashCommand;
  final int animId;

  const BriefDbcEmoteEntity({
    this.id = 0,
    this.slashCommand = '',
    this.animId = 0,
  });

  factory BriefDbcEmoteEntity.fromJson(Map<String, dynamic> json) {
    return BriefDbcEmoteEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      slashCommand: json['EmoteSlashCommand']?.toString() ?? '',
      animId: (json['AnimID'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
