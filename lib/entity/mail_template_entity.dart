import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'mail_template_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_mail_template')
class MailTemplateEntity with _MailTemplateEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('Subject_lang_enUS')
  final String subjectLangEnUS;

  @FoxyFullField('Subject_lang_koKR')
  final String subjectLangKoKR;

  @FoxyFullField('Subject_lang_frFR')
  final String subjectLangFrFR;

  @FoxyFullField('Subject_lang_deDE')
  final String subjectLangDeDE;

  @FoxyBriefField()
  @FoxyFullField('Subject_lang_zhCN')
  final String subjectLangZhCN;

  @FoxyFullField('Subject_lang_zhTW')
  final String subjectLangZhTW;

  @FoxyFullField('Subject_lang_esES')
  final String subjectLangEsES;

  @FoxyFullField('Subject_lang_esMX')
  final String subjectLangEsMX;

  @FoxyFullField('Subject_lang_ruRU')
  final String subjectLangRuRU;

  @FoxyFullField('Subject_lang_jaJP')
  final String subjectLangJaJP;

  @FoxyFullField('Subject_lang_ptPT')
  final String subjectLangPtPT;

  @FoxyFullField('Subject_lang_ptBR')
  final String subjectLangPtBR;

  @FoxyFullField('Subject_lang_itIT')
  final String subjectLangItIT;

  @FoxyFullField('Subject_lang_unk1')
  final String subjectLangUnk1;

  @FoxyFullField('Subject_lang_unk2')
  final String subjectLangUnk2;

  @FoxyFullField('Subject_lang_unk3')
  final String subjectLangUnk3;

  @FoxyFullField('Subject_lang_Flags')
  final int subjectLangFlags;

  @FoxyFullField('Body_lang_enUS')
  final String bodyLangEnUS;

  @FoxyFullField('Body_lang_koKR')
  final String bodyLangKoKR;

  @FoxyFullField('Body_lang_frFR')
  final String bodyLangFrFR;

  @FoxyFullField('Body_lang_deDE')
  final String bodyLangDeDE;

  @FoxyBriefField()
  @FoxyFullField('Body_lang_zhCN')
  final String bodyLangZhCN;

  @FoxyFullField('Body_lang_zhTW')
  final String bodyLangZhTW;

  @FoxyFullField('Body_lang_esES')
  final String bodyLangEsES;

  @FoxyFullField('Body_lang_esMX')
  final String bodyLangEsMX;

  @FoxyFullField('Body_lang_ruRU')
  final String bodyLangRuRU;

  @FoxyFullField('Body_lang_jaJP')
  final String bodyLangJaJP;

  @FoxyFullField('Body_lang_ptPT')
  final String bodyLangPtPT;

  @FoxyFullField('Body_lang_ptBR')
  final String bodyLangPtBR;

  @FoxyFullField('Body_lang_itIT')
  final String bodyLangItIT;

  @FoxyFullField('Body_lang_unk1')
  final String bodyLangUnk1;

  @FoxyFullField('Body_lang_unk2')
  final String bodyLangUnk2;

  @FoxyFullField('Body_lang_unk3')
  final String bodyLangUnk3;

  @FoxyFullField('Body_lang_Flags')
  final int bodyLangFlags;

  const MailTemplateEntity({
    this.id = 0,
    this.subjectLangEnUS = '',
    this.subjectLangKoKR = '',
    this.subjectLangFrFR = '',
    this.subjectLangDeDE = '',
    this.subjectLangZhCN = '',
    this.subjectLangZhTW = '',
    this.subjectLangEsES = '',
    this.subjectLangEsMX = '',
    this.subjectLangRuRU = '',
    this.subjectLangJaJP = '',
    this.subjectLangPtPT = '',
    this.subjectLangPtBR = '',
    this.subjectLangItIT = '',
    this.subjectLangUnk1 = '',
    this.subjectLangUnk2 = '',
    this.subjectLangUnk3 = '',
    this.subjectLangFlags = 0,
    this.bodyLangEnUS = '',
    this.bodyLangKoKR = '',
    this.bodyLangFrFR = '',
    this.bodyLangDeDE = '',
    this.bodyLangZhCN = '',
    this.bodyLangZhTW = '',
    this.bodyLangEsES = '',
    this.bodyLangEsMX = '',
    this.bodyLangRuRU = '',
    this.bodyLangJaJP = '',
    this.bodyLangPtPT = '',
    this.bodyLangPtBR = '',
    this.bodyLangItIT = '',
    this.bodyLangUnk1 = '',
    this.bodyLangUnk2 = '',
    this.bodyLangUnk3 = '',
    this.bodyLangFlags = 0,
  });

  factory MailTemplateEntity.fromJson(Map<String, dynamic> json) =>
      _MailTemplateEntityMixin.fromJson(json);
}
