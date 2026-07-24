import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/spell_bonus_data_entity.dart';
import 'package:foxy/entity/spell_custom_attr_entity.dart';

void main() {
  test('两张法术单行子表的 Brief key 直接返回物理标量', () {
    const bonusKey = 11;
    const customKey = 12;
    expect((const SpellBonusDataEntity(entry: 11)).entry, bonusKey);
    expect((const SpellCustomAttrEntity(spellId: 12)).spellId, customKey);
    expect(const BriefSpellBonusDataEntity(entry: 11).key, bonusKey);
    expect(const BriefSpellCustomAttrEntity(spellId: 12).key, customKey);
  });

  test('两张法术单行子表按原始标量 key 更新完整 candidate', () {
    for (final stem in ['spell_bonus_data', 'spell_custom_attr']) {
      final source = File(
        'lib/repository/${stem}_repository.dart',
      ).readAsStringSync();
      expect(source, contains('originalKey'));
      expect(source, contains('.update(json)'));
      expect(source, contains('if (matchedRows == 0)'));
      expect(source, contains('if (deletedRows == 0)'));
      expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
      expect(source, isNot(contains('saveSpell')));
      expect(source, isNot(contains('json.remove(')));
    }
  });

  test('子编辑器使用 editingKey，主键由可编辑 Controller 收集', () {
    for (final stem in ['spell_bonus_data', 'spell_custom_attr']) {
      final viewModel = File(
        'lib/page/spell/${stem}_single_editor_view_model.dart',
      ).readAsStringSync();
      final view = File('lib/page/spell/${stem}_view.dart').readAsStringSync();
      expect(viewModel, contains('editingKey = signal<'));
      expect(viewModel, contains('final originalKey = editingKey.value'));
      expect(viewModel, contains('spellIdController.collect()'));
      expect(view, isNot(contains('readOnly: true')));
      expect(view, isNot(contains('initControllers(data)')));
    }
  });
}
