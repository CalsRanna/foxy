import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/entity/emote_text_data_entity.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/page/emote_text/emote_text_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

class _EmoteTextValidationViewModel
    with ViewModelValidationMixin, EmoteTextValidationMixin {}

void main() {
  test('EmotesText Entity 精确覆盖 19 个物理列且全部为标量', () {
    final json = const EmoteTextEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'Name',
      'EmoteID',
      'EmoteText0',
      'EmoteText1',
      'EmoteText2',
      'EmoteText3',
      'EmoteText4',
      'EmoteText5',
      'EmoteText6',
      'EmoteText7',
      'EmoteText8',
      'EmoteText9',
      'EmoteText10',
      'EmoteText11',
      'EmoteText12',
      'EmoteText13',
      'EmoteText14',
      'EmoteText15',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('EmotesTextData Entity 精确覆盖 18 个物理列且全部为标量', () {
    final json = const EmoteTextDataEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'Text_lang_enUS',
      'Text_lang_koKR',
      'Text_lang_frFR',
      'Text_lang_deDE',
      'Text_lang_zhCN',
      'Text_lang_zhTW',
      'Text_lang_esES',
      'Text_lang_esMX',
      'Text_lang_ruRU',
      'Text_lang_jaJP',
      'Text_lang_ptPT',
      'Text_lang_ptBR',
      'Text_lang_itIT',
      'Text_lang_unk1',
      'Text_lang_unk2',
      'Text_lang_unk3',
      'Text_lang_Flags',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
    expect(
      DbcLocaleFields.emotesTextDataText.tableName,
      'dbc_emotes_text_data',
    );
    expect(DbcLocaleFields.emotesTextDataText.columnPrefix, 'Text_lang');
  });

  test('EmotesText 与引用 DBC Schema 对应 3.3.5.12340', () {
    final emotesText = dbcDefinitionByTable['dbc_emotes_text']!;
    final emotes = dbcDefinitionByTable['dbc_emotes']!;
    final textData = dbcDefinitionByTable['dbc_emotes_text_data']!;
    expect(emotesText.fileName, 'EmotesText.dbc');
    expect(emotesText.schema.fields, hasLength(19));
    expect(emotes.fileName, 'Emotes.dbc');
    expect(textData.fileName, 'EmotesTextData.dbc');
    expect(textData.schema.fields, hasLength(18));
    expect(requiredDbcTableNames, contains('dbc_emotes_text_data'));
  });

  test('引用字段拒绝负数并允许零值', () {
    final viewModel = _EmoteTextValidationViewModel();
    const valid = EmoteTextEntity(id: 1);
    expect(() => viewModel.validateEmoteTextFields(valid), returnsNormally);
    expect(
      () => viewModel.validateEmoteTextFields(valid.copyWith(emoteId: -1)),
      throwsStateError,
    );
    expect(
      () => viewModel.validateEmoteTextFields(valid.copyWith(emoteText0: -1)),
      throwsStateError,
    );
    expect(
      () => viewModel.validateEmoteTextFields(valid.copyWith(emoteText15: -1)),
      throwsStateError,
    );
  });
}
