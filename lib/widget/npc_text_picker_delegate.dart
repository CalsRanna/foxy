import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final npcTextPickerDelegate = EntityPickerDelegate<NpcTextEntity>(
  title: 'NPC 文本',
  errorLabel: '搜索NPC文本失败',
  filters: const [EntityPickerFilter('ID'), EntityPickerFilter('文本内容')],
  columns: [
    EntityPickerColumn(header: 'ID', width: 120, text: (NpcTextEntity t) => t.id.toString()),
    EntityPickerColumn(
      header: '文本（text0_0 / text0_1）',
      text: (NpcTextEntity t) => t.entries[0].text0.isNotEmpty ? t.entries[0].text0 : t.entries[0].text1,
    ),
  ],
  idOf: (NpcTextEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<NpcTextRepository>().getNpcTextsPaginated(
      id: v[0].isEmpty ? null : v[0], text: v[1].isEmpty ? null : v[1], page: page),
  count: (v) => GetIt.instance.get<NpcTextRepository>()
      .countNpcTexts(id: v[0].isEmpty ? null : v[0], text: v[1].isEmpty ? null : v[1]),
);
