import 'package:flutter_test/flutter_test.dart';
import 'support/entity_validation_test_extensions.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/constant/talent_constants.dart';
import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/entity/talent_tab_entity.dart';

void main() {
  test('Talent Entity 精确覆盖 23 个独立标量物理列', () {
    final json = const TalentEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'TabID',
      'TierID',
      'ColumnIndex',
      'SpellRank0',
      'SpellRank1',
      'SpellRank2',
      'SpellRank3',
      'SpellRank4',
      'SpellRank5',
      'SpellRank6',
      'SpellRank7',
      'SpellRank8',
      'PrereqTalent0',
      'PrereqTalent1',
      'PrereqTalent2',
      'PrereqRank0',
      'PrereqRank1',
      'PrereqRank2',
      'Flags',
      'RequiredSpellID',
      'CategoryMask0',
      'CategoryMask1',
    ]);
    expect(json.values, everyElement(isA<int>()));
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('TalentTab Entity 精确覆盖 24 个独立标量物理列', () {
    final json = const TalentTabEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'Name_lang_enUS',
      'Name_lang_koKR',
      'Name_lang_frFR',
      'Name_lang_deDE',
      'Name_lang_zhCN',
      'Name_lang_zhTW',
      'Name_lang_esES',
      'Name_lang_esMX',
      'Name_lang_ruRU',
      'Name_lang_jaJP',
      'Name_lang_ptPT',
      'Name_lang_ptBR',
      'Name_lang_itIT',
      'Name_lang_unk1',
      'Name_lang_unk2',
      'Name_lang_unk3',
      'Name_lang_Flags',
      'SpellIconID',
      'RaceMask',
      'ClassMask',
      'CategoryEnumID',
      'OrderIndex',
      'BackgroundFile',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('Flags 使用 Talent addToSpellBook 专属 0/1 值', () {
    expect(kTalentAddToSpellBookOptions, {0: '不直接加入法术书', 1: '直接加入法术书'});
    expect(kTalentAddToSpellBookOptions, isNot(contains(2)));
  });

  test('Talent 校验坐标、连续 Rank、专属 Flags 和有符号分类掩码', () {
    expect(
      const TalentEntity(
        id: 1,
        tabId: 41,
        tierId: 10,
        columnIndex: 3,
        spellRank0: 100,
        spellRank1: 101,
        spellRank2: 102,
        flags: 1,
        categoryMask0: -0x80000000,
        categoryMask1: 0x7fffffff,
      ).validate,
      returnsNormally,
    );
    expect(
      () => const TalentEntity(
        id: 1,
        tabId: 41,
        tierId: 11,
        spellRank0: 100,
      ).validate(),
      throwsArgumentError,
    );
    expect(
      () => const TalentEntity(
        id: 1,
        tabId: 41,
        spellRank0: 100,
        spellRank2: 102,
      ).validate(),
      throwsArgumentError,
    );
    expect(
      () => const TalentEntity(
        id: 1,
        tabId: 41,
        spellRank0: 100,
        flags: 2,
      ).validate(),
      throwsArgumentError,
    );
  });

  test('TalentTab 校验页序和物理 int32 值域', () {
    expect(
      const TalentTabEntity(
        id: 1,
        orderIndex: 2,
        raceMask: -0x80000000,
        classMask: 0x7fffffff,
      ).validate,
      returnsNormally,
    );
    expect(
      () => const TalentTabEntity(id: 1, orderIndex: 3).validate(),
      throwsArgumentError,
    );
  });

  test('Talent 与 TalentTab definition 使用 3.3.5.12340 物理格式', () {
    final talent = dbcDefinitionByTable['dbc_talent']!;
    expect(talent.fileName, 'Talent.dbc');
    expect(talent.schema.format, 'niiiiiiiiiiiiiiiiiiiiii');
    expect(talent.schema.fields, hasLength(23));

    final tab = dbcDefinitionByTable['dbc_talent_tab']!;
    expect(tab.fileName, 'TalentTab.dbc');
    expect(tab.schema.format, 'nssssssssssssssssiiiiiis');
    expect(tab.schema.fields, hasLength(24));
    expect(DbcLocaleFields.talentTabName.tableName, 'dbc_talent_tab');
    expect(DbcLocaleFields.talentTabName.columnPrefix, 'Name_lang');
  });
}
