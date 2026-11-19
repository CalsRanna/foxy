import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'emote_text_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_emotes_text')
class EmoteTextEntity with _EmoteTextEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Name')
  final String name;

  @FoxyBriefField()
  @FoxyFieldMeaning.reference('表情', table: 'foxy.dbc_emotes', column: 'ID')
  @FoxyFullField('EmoteID')
  final int emoteId;

  @FoxyFieldMeaning.reference(
    '表情文本0',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
  @FoxyFullField('EmoteText0')
  final int emoteText0;

  @FoxyFieldMeaning.reference(
    '表情文本1',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
  @FoxyFullField('EmoteText1')
  final int emoteText1;

  @FoxyFieldMeaning.reference(
    '表情文本2',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
  @FoxyFullField('EmoteText2')
  final int emoteText2;

  @FoxyFieldMeaning.reference(
    '表情文本3',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
  @FoxyFullField('EmoteText3')
  final int emoteText3;

  @FoxyFieldMeaning.reference(
    '表情文本4',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
  @FoxyFullField('EmoteText4')
  final int emoteText4;

  @FoxyFieldMeaning.reference(
    '表情文本5',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
  @FoxyFullField('EmoteText5')
  final int emoteText5;

  @FoxyFieldMeaning.reference(
    '表情文本6',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
  @FoxyFullField('EmoteText6')
  final int emoteText6;

  @FoxyFieldMeaning.reference(
    '表情文本7',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
  @FoxyFullField('EmoteText7')
  final int emoteText7;

  @FoxyFieldMeaning.reference(
    '表情文本8',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
  @FoxyFullField('EmoteText8')
  final int emoteText8;

  @FoxyFieldMeaning.reference(
    '表情文本9',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
  @FoxyFullField('EmoteText9')
  final int emoteText9;

  @FoxyFieldMeaning.reference(
    '表情文本10',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
  @FoxyFullField('EmoteText10')
  final int emoteText10;

  @FoxyFieldMeaning.reference(
    '表情文本11',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
  @FoxyFullField('EmoteText11')
  final int emoteText11;

  @FoxyFieldMeaning.reference(
    '表情文本12',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
  @FoxyFullField('EmoteText12')
  final int emoteText12;

  @FoxyFieldMeaning.reference(
    '表情文本13',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
  @FoxyFullField('EmoteText13')
  final int emoteText13;

  @FoxyFieldMeaning.reference(
    '表情文本14',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
  @FoxyFullField('EmoteText14')
  final int emoteText14;

  @FoxyFieldMeaning.reference(
    '表情文本15',
    table: 'foxy.dbc_emotes_text_data',
    column: 'ID',
  )
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
