import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回完整物理 ID 标量', () {
    const first = 7;
    const same = 7;
    const other = 8;
    const brief = BriefAreaTableEntity(id: 7);

    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(other));
    expect((const AreaTableEntity(id: 7)).id, first);
    expect(brief.key, first);
  });

  test('AreaTable Repository 使用显式创建键、原始键更新和受影响行结果', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/area_table_repository.dart',
    );

    expect(source, contains('Future<int> copyAreaTable('));
    expect(source, contains('Future<AreaTableEntity> createAreaTable()'));
    expect(source, contains("id: await nextMaxPlusOne(_table, 'ID')"));
    expect(source, contains('Future<void> storeAreaTable('));
    expect(source, contains('if (area.id <= 0)'));
    expect(source, contains('insert([area.toJson()])'));
    expect(source, isNot(contains('Future<int> storeAreaTable')));
    expect(source, isNot(contains('insertAndGetId')));
    expect(source, isNot(contains('saveAreaTable(')));

    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(area.toJson())'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, isNot(contains("remove('ID')")));

    expect(source, contains('Future<void> destroyAreaTable(int key)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });

  test('AreaTable 详情以 persistedKey 区分增改并在成功后切换身份', () {
    final viewModel = File(
      'lib/page/area_table/area_table_detail_view_model.dart',
    ).readAsStringSync();
    final page = File(
      'lib/page/area_table/area_table_detail_page.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/area_table/area_table_view.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/area_table/area_table_list_page.dart',
    ).readAsStringSync();

    expect(viewModel, contains('signal<int?>(null)'));
    expect(viewModel, contains('final originalKey = persistedKey.value'));
    expect(viewModel, contains('updateAreaTable(originalKey, candidate)'));
    expect(viewModel, contains('persistedKey.value = newKey'));
    expect(viewModel, isNot(contains('getAreaTable(candidate.id)')));
    expect(page, contains('final int? areaTableKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(view, isNot(contains('readOnly: true')));
    expect(view, contains('viewModel.persistedKey.value'));
    expect(list, contains('areas[row].key'));
  });
}
