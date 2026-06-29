import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/entity/emote_text_filter_entity.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final emotePickerDelegate = EntityPickerDelegate<EmoteTextEntity>(
  title: '表情',
  errorLabel: '搜索表情失败',
  filters: const [EntityPickerFilter('表情ID'), EntityPickerFilter('表情名称')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (EmoteTextEntity t) => t.id.toString()),
    EntityPickerColumn(header: '名称', text: (EmoteTextEntity t) => t.name),
    EntityPickerColumn(header: '表情编号', width: 120, text: (EmoteTextEntity t) => t.emoteId.toString()),
  ],
  idOf: (EmoteTextEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<EmoteTextRepository>().getEmoteTexts(
      filter: EmoteTextFilterEntity(id: v[0], name: v[1]), page: page),
  count: (v) => GetIt.instance.get<EmoteTextRepository>()
      .countEmoteTexts(filter: EmoteTextFilterEntity(id: v[0], name: v[1])),
);
