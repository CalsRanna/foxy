import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';

void main() {
  test('ItemEnchantmentTemplateKey 和 Brief 覆盖 entry + ench', () {
    const entity = ItemEnchantmentTemplateEntity(entry: 10, ench: 20);
    const key = ItemEnchantmentTemplateKey(entry: 10, ench: 20);
    expect(ItemEnchantmentTemplateKey.fromEntity(entity), key);
    expect(
      const BriefItemEnchantmentTemplateEntity(entry: 10, ench: 20).key,
      key,
    );
    expect(key, isNot(const ItemEnchantmentTemplateKey(entry: 10, ench: 21)));
  });

  test('Repository 使用完整旧 key、完整 candidate 和写入结果', () {
    final source = File(
      'lib/repository/item_enchantment_template_repository.dart',
    ).readAsStringSync();
    expect(source, contains('ItemEnchantmentTemplateKey originalKey'));
    expect(source, contains('.update(model.toJson())'));
    expect(source, contains("where('entry', key.entry)"));
    expect(source, contains("where('ench', key.ench)"));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveItemEnchantmentTemplate(')));
  });

  test('内嵌编辑器使用 Brief、editingKey、分页且两个键都可编辑', () {
    final repository = File(
      'lib/repository/item_enchantment_template_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/item/item_enchantment_template_collection_editor_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/item/item_enchantment_template_view.dart',
    ).readAsStringSync();
    expect(
      repository,
      contains('Future<List<BriefItemEnchantmentTemplateEntity>>'),
    );
    expect(repository, contains('.limit(kPageSize)'));
    expect(
      viewModel,
      contains('editingKey = signal<ItemEnchantmentTemplateKey?>'),
    );
    expect(viewModel, contains('entry: entryController.collect()'));
    expect(viewModel, contains('ench: enchController.collect()'));
    expect(viewModel, contains('final originalKey = editingKey.value'));
    expect(viewModel, contains('selectedKey.value = key'));
    expect(view, contains('FoxyPagination('));
    expect(view, isNot(contains('readOnly: true')));
    expect(view, isNot(contains('readOnly: isEditing')));
  });
}
