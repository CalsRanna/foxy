import 'package:foxy/entity/char_title_entity.dart';
import 'package:foxy/repository/char_title_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final charTitlePickerDelegate = EntityPickerDelegate<CharTitleEntity>(
  title: '称号',
  errorLabel: '搜索称号失败',
  filters: const [EntityPickerFilter('称号ID'), EntityPickerFilter('称号名称')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (CharTitleEntity t) => t.id.toString()),
    EntityPickerColumn(header: '名称', text: (CharTitleEntity t) => t.nameLangZhCn),
  ],
  idOf: (CharTitleEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<CharTitleRepository>().getCharTitles(
      id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1], page: page),
  count: (v) => GetIt.instance.get<CharTitleRepository>()
      .countCharTitles(id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1]),
);
