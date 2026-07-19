class DbcEmoteEntity {
  final int id;
  final String slashCommand;
  final int animId;
  final int flags;
  final int specProc;
  final int specProcParam;
  final int eventSoundId;

  const DbcEmoteEntity({
    this.id = 0,
    this.slashCommand = '',
    this.animId = 0,
    this.flags = 0,
    this.specProc = 0,
    this.specProcParam = 0,
    this.eventSoundId = 0,
  });

  factory DbcEmoteEntity.fromJson(Map<String, dynamic> json) => DbcEmoteEntity(
    id: json['ID'] ?? 0,
    slashCommand: json['EmoteSlashCommand'] ?? '',
    animId: json['AnimID'] ?? 0,
    flags: json['EmoteFlags'] ?? 0,
    specProc: json['EmoteSpecProc'] ?? 0,
    specProcParam: json['EmoteSpecProcParam'] ?? 0,
    eventSoundId: json['EventSoundID'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'ID': id,
    'EmoteSlashCommand': slashCommand,
    'AnimID': animId,
    'EmoteFlags': flags,
    'EmoteSpecProc': specProc,
    'EmoteSpecProcParam': specProcParam,
    'EventSoundID': eventSoundId,
  };
}
