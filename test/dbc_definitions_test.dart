import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/di.dart';
import 'package:foxy/util/dbc_export_registry.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUpAll(DI.ensureInitialized);

  test('DBC 定义的表名和文件名唯一', () {
    final tableNames = dbcDefinitions
        .map((definition) => definition.tableName)
        .toSet();
    final fileNames = dbcDefinitions
        .map((definition) => definition.fileName.toLowerCase())
        .toSet();

    expect(tableNames, hasLength(dbcDefinitions.length));
    expect(fileNames, hasLength(dbcDefinitions.length));
    expect(dbcDefinitionByTable, hasLength(dbcDefinitions.length));
    expect(dbcDefinitionByFileName, hasLength(dbcDefinitions.length));
  });

  test('DBC 定义可以通过表名和文件名查找', () {
    final spell = dbcDefinitionByTable['dbc_spell'];

    expect(spell, isNotNull);
    expect(spell!.fileName, 'Spell.dbc');
    expect(dbcDefinitionByFileName['spell.dbc'], same(spell));
    expect(spell.qualifiedTableName, 'foxy.dbc_spell');
  });

  test('所有 DBC 定义都包含 ID 字段', () {
    for (final definition in dbcDefinitions) {
      expect(
        definition.schema.fields.any((field) => field.name == 'ID'),
        isTrue,
        reason: definition.fileName,
      );
    }
  });

  test('所有 DBC 定义都已注册导出 Repository', () {
    final registry = GetIt.instance.get<DbcExportRegistry>();

    for (final definition in dbcDefinitions) {
      expect(
        registry.contains(definition.tableName),
        isTrue,
        reason: definition.tableName,
      );
    }
  });

  test('所有 DBC 定义都有非空 Schema 与 format', () {
    for (final definition in dbcDefinitions) {
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
          contains('未注册的 DBC 导出表'),
        ),
      ),
    );

    final count = await registry.countRows('dbc_not_registered_table');
    expect(count.success, isFalse);
    expect(count.error, isA<StateError>());
    expect(count.error.toString(), contains('未注册的 DBC 导出表'));
  });
}
