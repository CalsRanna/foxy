import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/entity/page_text_filter_entity.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final pageTextPickerDelegate = EntityPickerDelegate<PageTextEntity>(
  title: '页面文本',
  errorLabel: '搜索页面文本失败',
  filters: const [EntityPickerFilter('编号')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (PageTextEntity t) => t.id.toString()),
    EntityPickerColumn(header: '文本', text: (PageTextEntity t) => t.text),
  ],
  idOf: (PageTextEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<PageTextRepository>().getPageTexts(
      filter: PageTextFilterEntity(id: v[0], text: ''), page: page),
  count: (v) => GetIt.instance.get<PageTextRepository>()
      .countPageTexts(filter: PageTextFilterEntity(id: v[0], text: '')),
);
