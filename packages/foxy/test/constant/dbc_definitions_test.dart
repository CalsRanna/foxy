import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/di.dart';
import 'package:foxy/repository/dbc_export_registry.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUpAll(DI.ensureInitialized);

  test('DBC definitions have unique table and file names', () {
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

  test('DBC definitions can be found by table name or file name', () {
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
    expect(
      DbcDefinitions.byTable['dbc_liquid_type']?.fileName,
      'LiquidType.dbc',
    );
    expect(DbcDefinitions.byTable['dbc_light']?.fileName, 'Light.dbc');
  });

  test('Every DBC definition includes an ID field', () {
    for (final definition in DbcDefinitions.all) {
      expect(
        definition.schema.fields.any((field) => field.name == 'ID'),
        isTrue,
        reason: definition.fileName,
      );
    }
  });

  test('Every DBC definition has a registered export repository', () {
    final registry = GetIt.instance.get<DbcExportRegistry>();

    for (final definition in DbcDefinitions.all) {
      expect(
        registry.contains(definition.tableName),
        isTrue,
        reason: definition.tableName,
      );
    }
  });

  test('Every DBC definition has a nonempty schema and format', () {
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

  test('loadRows and countRows report a clear error for unregistered export tables', () async {
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
