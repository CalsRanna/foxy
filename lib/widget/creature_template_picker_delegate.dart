import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/entity/creature_template_filter_entity.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final creatureTemplatePickerDelegate = EntityPickerDelegate<BriefCreatureTemplateEntity>(
  title: '生物模板',
  errorLabel: '搜索生物模板失败',
  filters: const [EntityPickerFilter('编号'), EntityPickerFilter('名称')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (BriefCreatureTemplateEntity t) => t.entry.toString()),
    EntityPickerColumn(header: '名称', text: (BriefCreatureTemplateEntity t) => t.displayName),
    EntityPickerColumn(header: '等级', width: 120, text: (BriefCreatureTemplateEntity t) => '${t.minLevel} / ${t.maxLevel}'),
  ],
  idOf: (BriefCreatureTemplateEntity t) => t.entry,
  fetch: (page, v) => GetIt.instance.get<CreatureTemplateRepository>().getBriefCreatureTemplates(
      page: page, filter: CreatureTemplateFilterEntity(entry: v[0], name: v[1])),
  count: (v) => GetIt.instance.get<CreatureTemplateRepository>()
      .countCreatureTemplates(filter: CreatureTemplateFilterEntity(entry: v[0], name: v[1])),
);
