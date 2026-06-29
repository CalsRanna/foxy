import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/repository/item_enchantment_template_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final itemEnchantmentTemplatePickerDelegate = EntityPickerDelegate<BriefItemEnchantmentTemplateEntity>(
  title: '附魔',
  errorLabel: '搜索附魔失败',
  filters: const [EntityPickerFilter('编号'), EntityPickerFilter('名称')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (BriefItemEnchantmentTemplateEntity t) => t.entry.toString()),
    EntityPickerColumn(header: '名称', text: (BriefItemEnchantmentTemplateEntity t) => t.name),
  ],
  idOf: (BriefItemEnchantmentTemplateEntity t) => t.entry,
  fetch: (page, v) => GetIt.instance.get<ItemEnchantmentTemplateRepository>().getItemEnchantmentTemplates(
      entry: v[0].isEmpty ? null : v[0], page: page),
  count: (v) => GetIt.instance.get<ItemEnchantmentTemplateRepository>()
      .countItemEnchantmentTemplates(entry: v[0].isEmpty ? null : v[0]),
);
