import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/di.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_registry.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUpAll(DI.ensureInitialized);

  test('DBC 定义的表名和文件名唯一', () {
    final tableNames = DbcDefinitions.all
        .map((definition) => definition.tableName)
        .toSet();
    final fileNames = DbcDefinitions.all
        .map((definition) => definition.fileName.toLowerCase())
        .toSet();

    expect(tableNames, hasLength(DbcDefinitions.all.length));
    expect(fileNames, hasLength(DbcDefinitions.all.length));
    expect(DbcDefinitions.byTable, hasLength(DbcDefinitions.all.length));
    expect(DbcDefinitions.byFileName, hasLength(DbcDefinitions.all.length));
  });

  test('DBC 定义可以通过表名和文件名查找', () {
    final spell = DbcDefinitions.byTable['dbc_spell'];

    expect(spell, isNotNull);
    expect(spell!.fileName, 'Spell.dbc');
    expect(DbcDefinitions.byFileName['spell.dbc'], same(spell));
    expect(spell.qualifiedTableName, 'foxy.dbc_spell');
    expect(DbcDefinitions.byTable['dbc_emotes']?.fileName, 'Emotes.dbc');
    expect(
      DbcDefinitions.byTable['dbc_emotes_text_data']?.fileName,
      'EmotesTextData.dbc',
    );
    expect(DbcDefinitions.byTable['dbc_item']?.fileName, 'Item.dbc');
    expect(DbcDefinitions.byTable['dbc_skill_line']?.fileName, 'SkillLine.dbc');
    expect(
      DbcDefinitions.byTable['dbc_mail_template']?.fileName,
      'MailTemplate.dbc',
    );
    expect(
      DbcDefinitions.byTable['dbc_sound_provider_preferences']?.fileName,
      'SoundProviderPreferences.dbc',
    );
    expect(
      DbcDefinitions.byTable['dbc_sound_ambience']?.fileName,
      'SoundAmbience.dbc',
    );
    expect(DbcDefinitions.byTable['dbc_zone_music']?.fileName, 'ZoneMusic.dbc');
    expect(
      DbcDefinitions.byTable['dbc_zone_intro_music_table']?.fileName,
      'ZoneIntroMusicTable.dbc',
    );
    expect(DbcDefinitions.byTable['dbc_liquid_type']?.fileName, 'LiquidType.dbc');
    expect(DbcDefinitions.byTable['dbc_light']?.fileName, 'Light.dbc');
  });

  test('所有 DBC 定义都包含 ID 字段', () {
    for (final definition in DbcDefinitions.all) {
      expect(
        definition.schema.fields.any((field) => field.name == 'ID'),
        isTrue,
        reason: definition.fileName,
      );
    }
  });

  test('所有 DBC 定义都已注册导出 Repository', () {
    final registry = GetIt.instance.get<DbcExportRegistry>();

    for (final definition in DbcDefinitions.all) {
      expect(
        registry.contains(definition.tableName),
        isTrue,
        reason: definition.tableName,
      );
    }
  });

  test('所有 DBC 定义都有非空 Schema 与 format', () {
    for (final definition in DbcDefinitions.all) {
      expect(
        definition.schema.fields,
        isNotEmpty,
        reason: definition.tableName,
      );
      expect(
        definition.schema.format,
        isNotEmpty,
        reason: definition.tableName,
      );
      expect(definition.schema.name, isNotEmpty, reason: definition.tableName);
    }
  });

  test('未注册的导出表 loadRows/countRows 返回明确错误', () async {
    final registry = GetIt.instance.get<DbcExportRegistry>();

    await expectLater(
      registry.loadRows('dbc_not_registered_table'),
      throwsA(
        isA<StateError>().having(
          (error) => error.message,
          'message',
          contains('unregistered DBC export table'),
        ),
      ),
    );

    final count = await registry.countRows('dbc_not_registered_table');
    expect(count.success, isFalse);
    expect(count.error, isA<StateError>());
    expect(count.error.toString(), contains('unregistered DBC export table'));
  });
}
