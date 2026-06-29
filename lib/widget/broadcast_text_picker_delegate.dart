import 'package:foxy/entity/broadcast_text_entity.dart';
import 'package:foxy/repository/broadcast_text_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final broadcastTextPickerDelegate = EntityPickerDelegate<BroadcastTextEntity>(
  title: '广播文本',
  errorLabel: '搜索广播文本失败',
  filters: const [EntityPickerFilter('广播文本ID'), EntityPickerFilter('文本内容')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (BroadcastTextEntity t) => t.id.toString()),
    EntityPickerColumn(header: '文本', text: (BroadcastTextEntity t) => t.maleText),
    EntityPickerColumn(header: '语言', width: 120, text: (BroadcastTextEntity t) => t.languageId.toString()),
  ],
  idOf: (BroadcastTextEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<BroadcastTextRepository>().getBroadcastTexts(
      id: v[0].isEmpty ? null : v[0], text: v[1].isEmpty ? null : v[1], page: page),
  count: (v) => GetIt.instance.get<BroadcastTextRepository>().countBroadcastTexts(
      id: v[0].isEmpty ? null : v[0], text: v[1].isEmpty ? null : v[1]),
);
