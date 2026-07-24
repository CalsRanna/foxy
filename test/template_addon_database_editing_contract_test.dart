import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy/entity/game_object_template_addon_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('两张模板附加表的 Brief key 直接返回物理 entry 标量', () {
    const creatureKey = 11;
    const gameObjectKey = 12;
    expect((const CreatureTemplateAddonEntity(entry: 11)).entry, creatureKey);
    expect(
      (const GameObjectTemplateAddonEntity(entry: 12)).entry,
      gameObjectKey,
    );
    expect(const BriefCreatureTemplateAddonEntity(entry: 11).key, creatureKey);
    expect(
      const BriefGameObjectTemplateAddonEntity(entry: 12).key,
      gameObjectKey,
    );
  });

  test('两张模板附加表按原始标量 key 更新完整 candidate', () {
    for (final stem in [
      'creature_template_addon',
      'game_object_template_addon',
    ]) {
      final source = readLocalDartLibrarySource(
        'lib/repository/${stem}_repository.dart',
      );
      expect(source, contains('originalKey'));
      expect(source, contains('.update(json)'));
      expect(source, contains('if (matchedRows == 0)'));
      expect(source, contains('if (deletedRows == 0)'));
      expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
      expect(source, isNot(contains('saveCreatureTemplateAddon')));
      expect(source, isNot(contains('saveGameObjectTemplateAddon')));
      expect(source, isNot(contains("json.remove('entry')")));
      expect(source, isNot(contains('_validated(')));
    }
  });

  test('子编辑器使用 editingKey、收集可编辑 entry 并在 ViewModel 验证', () {
    for (final stem in [
      'creature_template/creature_template_addon',
      'game_object/game_object_template_addon',
    ]) {
      final viewModel = File(
        'lib/page/${stem}_single_editor_view_model.dart',
      ).readAsStringSync();
      final view = File('lib/page/${stem}_view.dart').readAsStringSync();
      expect(viewModel, contains('editingKey = signal<'));
      expect(viewModel, contains('final originalKey = editingKey.value'));
      expect(viewModel, contains('Controller.collect()'));
      expect(viewModel, contains('validate'));
      expect(view, isNot(contains('readOnly: true')));
    }
  });

  test('Full Entity 不包含旧的 aura 规范化写入行为', () {
    final creatureEntity = File(
      'lib/entity/creature_template_addon_entity.dart',
    ).readAsStringSync();
    expect(creatureEntity, isNot(contains('normalizeAuras')));
  });
}
