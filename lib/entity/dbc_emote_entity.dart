import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'dbc_emote_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_emotes')
class DbcEmoteEntity with _DbcEmoteEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('EmoteSlashCommand')
  final String slashCommand;

  @FoxyBriefField()
  @FoxyFullField('AnimID')
  final int animId;

  @FoxyFullField('EmoteFlags')
  final int flags;

  @FoxyFullField('EmoteSpecProc')
  final int specProc;

  @FoxyFullField('EmoteSpecProcParam')
  final int specProcParam;

  @FoxyFullField('EventSoundID')
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

  factory DbcEmoteEntity.fromJson(Map<String, dynamic> json) =>
      _DbcEmoteEntityMixin.fromJson(json);
}
