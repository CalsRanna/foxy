class BriefDbcEmoteEntity {
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
      id: json['ID'] ?? 0,
      slashCommand: json['EmoteSlashCommand'] ?? '',
      animId: json['AnimID'] ?? 0,
    );
  }

  int get key => id;
}
