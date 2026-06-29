import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/entity/quest_info_filter_entity.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final questInfoPickerDelegate = EntityPickerDelegate<QuestInfoEntity>(
  title: '任务信息',
  errorLabel: '搜索任务信息失败',
  filters: const [EntityPickerFilter('任务信息ID'), EntityPickerFilter('信息名称')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (QuestInfoEntity t) => t.id.toString()),
    EntityPickerColumn(header: '名称', text: (QuestInfoEntity t) => t.infoNameLangZhCn),
  ],
  idOf: (QuestInfoEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<QuestInfoRepository>().getQuestInfos(
      filter: QuestInfoFilterEntity(id: v[0], name: v[1]), page: page),
  count: (v) => GetIt.instance.get<QuestInfoRepository>()
      .countQuestInfos(filter: QuestInfoFilterEntity(id: v[0], name: v[1])),
);
