import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';

EntityPickerDelegate<BriefLootTemplateEntity> lootTemplatePickerDelegate(
  LootTableType tableType,
  String title,
) {
  final repository = LootTemplateRepository(tableType);
  return EntityPickerDelegate<BriefLootTemplateEntity>(
    title: title,
    errorLabel: '搜索掉落模板失败',
    filters: const [EntityPickerFilter('掉落编号')],
    columns: [
      EntityPickerColumn(header: '掉落编号', width: 120, text: (BriefLootTemplateEntity t) => t.entry.toString()),
      EntityPickerColumn(header: '物品数量', text: (BriefLootTemplateEntity t) => t.itemCount.toString()),
    ],
    idOf: (BriefLootTemplateEntity t) => t.entry,
    fetch: (page, v) =>
        repository.getLootTemplateDistinctEntries(entry: v[0].isEmpty ? null : v[0], page: page),
    count: (v) => repository.countLootTemplates(entry: v[0].isEmpty ? null : v[0]),
  );
}
