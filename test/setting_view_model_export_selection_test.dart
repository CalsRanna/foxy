import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/view_model/dbc_export_workflow_view_model.dart';

/// GetIt-free selection-logic verification: build the items list directly
/// and reuse the VM's filtering semantics.
void main() {
  final spellDuration = dbcDefinitionByTable['dbc_spell_duration']!;
  final spellIcon = dbcDefinitionByTable['dbc_spell_icon']!;
  final talent = dbcDefinitionByTable['dbc_talent']!;

  List<DbcExportItem> sampleItems() => [
    DbcExportItem(definition: spellDuration, recordCount: 3, selected: true),
    DbcExportItem(
      definition: spellIcon,
      countError: 'connection refused',
      selected: false,
    ),
    DbcExportItem(definition: talent, recordCount: 0, selected: false),
  ];

  test('selectable / exportable 过滤排除计数失败项', () {
    final items = sampleItems();
    final selectable = items.where((item) => item.canSelect).toList();
    final exportable = items
        .where((item) => item.selected && item.canSelect)
        .toList();

    expect(selectable.map((e) => e.tableName), [
      'dbc_spell_duration',
      'dbc_talent',
    ]);
    expect(exportable.map((e) => e.tableName), ['dbc_spell_duration']);
  });

  test('全选语义：仅可选中表被选中，失败项保持未选', () {
    var items = sampleItems();
    items = [
      for (final item in items)
        if (item.countFailed)
          item.copyWith(selected: false)
        else
          item.copyWith(selected: true),
    ];

    expect(
      items.singleWhere((e) => e.tableName == 'dbc_spell_icon').selected,
      isFalse,
    );
    expect(items.where((e) => e.selected).map((e) => e.tableName), [
      'dbc_spell_duration',
      'dbc_talent',
    ]);
  });

  test('导出拦截：已选且计数失败的表应被识别', () {
    final items = [
      DbcExportItem(definition: spellDuration, recordCount: 1, selected: true),
      // Theoretically impossible via the UI, but if state gets polluted the
      // export must still be blocked.
      DbcExportItem(definition: spellIcon, countError: 'boom', selected: true),
    ];
    final invalid = items
        .where((item) => item.selected && item.countFailed)
        .toList();

    expect(invalid, hasLength(1));
    expect(invalid.single.dbcFileName, spellIcon.fileName);
  });
}
