// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_emote_entity.dart';

mixin _DbcEmoteEntityMixin {
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
    final self = this as DbcEmoteEntity;
    return DbcEmoteEntity(
      id: id ?? self.id,
      slashCommand: slashCommand ?? self.slashCommand,
      animId: animId ?? self.animId,
      flags: flags ?? self.flags,
      specProc: specProc ?? self.specProc,
      specProcParam: specProcParam ?? self.specProcParam,
      eventSoundId: eventSoundId ?? self.eventSoundId,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as DbcEmoteEntity;
    return {
      'ID': self.id,
      'EmoteSlashCommand': self.slashCommand,
      'AnimID': self.animId,
      'EmoteFlags': self.flags,
      'EmoteSpecProc': self.specProc,
      'EmoteSpecProcParam': self.specProcParam,
      'EventSoundID': self.eventSoundId,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as DbcEmoteEntity;
    return identical(self, other) ||
        other is DbcEmoteEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.slashCommand == other.slashCommand &&
            self.animId == other.animId &&
            self.flags == other.flags &&
            self.specProc == other.specProc &&
            self.specProcParam == other.specProcParam &&
            self.eventSoundId == other.eventSoundId;
  }

  @override
  int get hashCode {
    final self = this as DbcEmoteEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.slashCommand,
      self.animId,
      self.flags,
      self.specProc,
      self.specProcParam,
      self.eventSoundId,
    ]);
  }

  @override
  String toString() {
    final self = this as DbcEmoteEntity;
    return 'DbcEmoteEntity('
        'id: ${self.id}, '
        'slashCommand: ${self.slashCommand}, '
        'animId: ${self.animId}, '
        'flags: ${self.flags}, '
        'specProc: ${self.specProc}, '
        'specProcParam: ${self.specProcParam}, '
        'eventSoundId: ${self.eventSoundId}'
        ')';
  }
}
