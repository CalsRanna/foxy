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
}
