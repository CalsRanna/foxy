import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'npc_text_locale_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'npc_text_locale')
class NpcTextLocaleEntity with _NpcTextLocaleEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Locale', key: true)
  final String locale;

  @FoxyFullField('Text0_0')
  final String text00;

  @FoxyFullField('Text0_1')
  final String text01;

  @FoxyFullField('Text1_0')
  final String text10;

  @FoxyFullField('Text1_1')
  final String text11;

  @FoxyFullField('Text2_0')
  final String text20;

  @FoxyFullField('Text2_1')
  final String text21;

  @FoxyFullField('Text3_0')
  final String text30;

  @FoxyFullField('Text3_1')
  final String text31;

  @FoxyFullField('Text4_0')
  final String text40;

  @FoxyFullField('Text4_1')
  final String text41;

  @FoxyFullField('Text5_0')
  final String text50;

  @FoxyFullField('Text5_1')
  final String text51;

  @FoxyFullField('Text6_0')
  final String text60;

  @FoxyFullField('Text6_1')
  final String text61;

  @FoxyFullField('Text7_0')
  final String text70;

  @FoxyFullField('Text7_1')
  final String text71;

  const NpcTextLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.text00 = '',
    this.text01 = '',
    this.text10 = '',
    this.text11 = '',
    this.text20 = '',
    this.text21 = '',
    this.text30 = '',
    this.text31 = '',
    this.text40 = '',
    this.text41 = '',
    this.text50 = '',
    this.text51 = '',
    this.text60 = '',
    this.text61 = '',
    this.text70 = '',
    this.text71 = '',
  });

  factory NpcTextLocaleEntity.fromJson(Map<String, dynamic> json) =>
      _NpcTextLocaleEntityMixin.fromJson(json);
}
