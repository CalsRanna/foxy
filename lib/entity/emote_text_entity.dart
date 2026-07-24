// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'emote_text_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_emotes_text')
class EmoteTextEntity with _EmoteTextEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('Name')
  final String name;

  @FoxyBriefField()
  @FoxyFullField('EmoteID')
  final int emoteId;

  @FoxyFullField('EmoteText0')
  final int emoteText0;

  @FoxyFullField('EmoteText1')
  final int emoteText1;

  @FoxyFullField('EmoteText2')
  final int emoteText2;

  @FoxyFullField('EmoteText3')
  final int emoteText3;

  @FoxyFullField('EmoteText4')
  final int emoteText4;

  @FoxyFullField('EmoteText5')
  final int emoteText5;

  @FoxyFullField('EmoteText6')
  final int emoteText6;

  @FoxyFullField('EmoteText7')
  final int emoteText7;

  @FoxyFullField('EmoteText8')
  final int emoteText8;

  @FoxyFullField('EmoteText9')
  final int emoteText9;

  @FoxyFullField('EmoteText10')
  final int emoteText10;

  @FoxyFullField('EmoteText11')
  final int emoteText11;

  @FoxyFullField('EmoteText12')
  final int emoteText12;

  @FoxyFullField('EmoteText13')
  final int emoteText13;

  @FoxyFullField('EmoteText14')
  final int emoteText14;

  @FoxyFullField('EmoteText15')
  final int emoteText15;

  const EmoteTextEntity({
    this.id = 0,
    this.name = '',
    this.emoteId = 0,
    this.emoteText0 = 0,
    this.emoteText1 = 0,
    this.emoteText2 = 0,
    this.emoteText3 = 0,
    this.emoteText4 = 0,
    this.emoteText5 = 0,
    this.emoteText6 = 0,
    this.emoteText7 = 0,
    this.emoteText8 = 0,
    this.emoteText9 = 0,
    this.emoteText10 = 0,
    this.emoteText11 = 0,
    this.emoteText12 = 0,
    this.emoteText13 = 0,
    this.emoteText14 = 0,
    this.emoteText15 = 0,
  });

  factory EmoteTextEntity.fromJson(Map<String, dynamic> json) =>
      _EmoteTextEntityMixin.fromJson(json);
}
