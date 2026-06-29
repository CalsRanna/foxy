import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/entity/quest_template_filter_entity.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final questTemplatePickerDelegate = EntityPickerDelegate<BriefQuestTemplateEntity>(
  title: '任务',
  errorLabel: '搜索任务失败',
  filters: const [EntityPickerFilter('编号'), EntityPickerFilter('名称')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (BriefQuestTemplateEntity t) => t.id.toString()),
    EntityPickerColumn(header: '名称', text: (BriefQuestTemplateEntity t) => t.displayTitle),
  ],
  idOf: (BriefQuestTemplateEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<QuestTemplateRepository>().getBriefQuestTemplates(
      filter: QuestTemplateFilterEntity(id: v[0], title: v[1]), page: page),
  count: (v) => GetIt.instance.get<QuestTemplateRepository>()
      .countQuestTemplates(filter: QuestTemplateFilterEntity(id: v[0], title: v[1])),
);
