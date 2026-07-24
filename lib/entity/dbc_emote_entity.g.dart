// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_emote_entity.dart';

mixin _DbcEmoteEntityMixin {
  int get id;
  String get slashCommand;
  int get animId;
  int get flags;
  int get specProc;
  int get specProcParam;
  int get eventSoundId;

  static DbcEmoteEntity fromJson(Map<String, dynamic> json) {
    return DbcEmoteEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      slashCommand: json['EmoteSlashCommand']?.toString() ?? '',
      animId: (json['AnimID'] as num?)?.toInt() ?? 0,
      flags: (json['EmoteFlags'] as num?)?.toInt() ?? 0,
      specProc: (json['EmoteSpecProc'] as num?)?.toInt() ?? 0,
      specProcParam: (json['EmoteSpecProcParam'] as num?)?.toInt() ?? 0,
      eventSoundId: (json['EventSoundID'] as num?)?.toInt() ?? 0,
    );
  }

  DbcEmoteEntity copyWith({
    int? id,
    String? slashCommand,
    int? animId,
    int? flags,
    int? specProc,
    int? specProcParam,
    int? eventSoundId,
  }) {
    return DbcEmoteEntity(
      id: id ?? this.id,
      slashCommand: slashCommand ?? this.slashCommand,
      animId: animId ?? this.animId,
      flags: flags ?? this.flags,
      specProc: specProc ?? this.specProc,
      specProcParam: specProcParam ?? this.specProcParam,
      eventSoundId: eventSoundId ?? this.eventSoundId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'EmoteSlashCommand': slashCommand,
      'AnimID': animId,
      'EmoteFlags': flags,
      'EmoteSpecProc': specProc,
      'EmoteSpecProcParam': specProcParam,
      'EventSoundID': eventSoundId,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DbcEmoteEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            slashCommand == other.slashCommand &&
            animId == other.animId &&
            flags == other.flags &&
            specProc == other.specProc &&
            specProcParam == other.specProcParam &&
            eventSoundId == other.eventSoundId;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      slashCommand,
      animId,
      flags,
      specProc,
      specProcParam,
      eventSoundId,
    ]);
  }

  @override
  String toString() {
    return 'DbcEmoteEntity('
        'id: $id, '
        'slashCommand: $slashCommand, '
        'animId: $animId, '
        'flags: $flags, '
        'specProc: $specProc, '
        'specProcParam: $specProcParam, '
        'eventSoundId: $eventSoundId'
        ')';
  }
}
