import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/page/setting/dbc_export_workflow_view_model.dart';

void main() {
  final definition = dbcDefinitionByTable['dbc_spell_duration']!;

  group('DbcExportItem', () {
    test('成功计数：空表与有数据', () {
      final empty = DbcExportItem(definition: definition, recordCount: 0);
      final filled = DbcExportItem(definition: definition, recordCount: 12);

      expect(empty.countFailed, isFalse);
      expect(empty.canSelect, isTrue);
      expect(empty.recordCountLabel, '空表');

      expect(filled.recordCountLabel, '12 条');
      expect(filled.canSelect, isTrue);
    });

    test('计数失败：不可勾选，标签为计数失败', () {
      final failed = DbcExportItem(
        definition: definition,
        countError: 'Table not found',
        selected: false,
      );

      expect(failed.countFailed, isTrue);
      expect(failed.canSelect, isFalse);
      expect(failed.recordCountLabel, '计数失败');
      expect(failed.selected, isFalse);
    });

    test('copyWith 保留 countError 与 recordCount', () {
      final failed = DbcExportItem(
        definition: definition,
        countError: 'boom',
        selected: false,
      );
      final toggled = failed.copyWith(selected: true);

      expect(toggled.countError, 'boom');
      expect(toggled.recordCount, isNull);
      expect(toggled.selected, isTrue);
    });
  });
}
