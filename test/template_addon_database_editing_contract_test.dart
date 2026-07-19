import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_creature_template_addon_entity.dart';
import 'package:foxy/entity/brief_game_object_template_addon_entity.dart';
import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy/entity/creature_template_addon_key.dart';
import 'package:foxy/entity/game_object_template_addon_entity.dart';
import 'package:foxy/entity/game_object_template_addon_key.dart';

void main() {
  test('两张模板附加表的 Key 和 Brief 精确暴露 entry 定位器', () {
    const creatureKey = CreatureTemplateAddonKey(entry: 11);
    const gameObjectKey = GameObjectTemplateAddonKey(entry: 12);
    expect(
      CreatureTemplateAddonKey.fromEntity(
        const CreatureTemplateAddonEntity(entry: 11),
      ),
      creatureKey,
    );
    expect(
      GameObjectTemplateAddonKey.fromEntity(
        const GameObjectTemplateAddonEntity(entry: 12),
      ),
      gameObjectKey,
    );
    expect(const BriefCreatureTemplateAddonEntity(entry: 11).key, creatureKey);
    expect(
      const BriefGameObjectTemplateAddonEntity(entry: 12).key,
      gameObjectKey,
    );
  });

  test('两张模板附加表按原 typed key 更新完整 candidate', () {
    for (final stem in [
      'creature_template_addon',
      'game_object_template_addon',
    ]) {
      final source = File(
        'lib/repository/${stem}_repository.dart',
      ).readAsStringSync();
      expect(source, contains('originalKey'));
      expect(source, contains('.update(addon.toJson())'));
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
        'lib/page/${stem}_view_model.dart',
      ).readAsStringSync();
      final view = File('lib/page/${stem}_view.dart').readAsStringSync();
      expect(viewModel, contains('editingKey = signal<'));
      expect(viewModel, contains('final originalKey = editingKey.value'));
      expect(viewModel, contains('Controller.collect()'));
      expect(viewModel, contains('validate'));
      expect(view, isNot(contains('readOnly: true')));
    }
  });

  test('Brief 与 Full Entity 不混用写入职责', () {
    for (final stem in [
      'brief_creature_template_addon_entity',
      'brief_game_object_template_addon_entity',
    ]) {
      final source = File('lib/entity/$stem.dart').readAsStringSync();
      expect(source, isNot(contains('toJson(')));
      expect(source, isNot(contains('copyWith(')));
    }
    final creatureEntity = File(
      'lib/entity/creature_template_addon_entity.dart',
    ).readAsStringSync();
    expect(creatureEntity, isNot(contains('normalizeAuras')));
  });
}
