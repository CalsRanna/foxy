import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/entity/area_table_filter_entity.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final areaTablePickerDelegate = EntityPickerDelegate<AreaTableEntity>(
  title: '区域',
  errorLabel: '搜索区域失败',
  filters: const [EntityPickerFilter('区域ID'), EntityPickerFilter('区域名称')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (AreaTableEntity t) => t.id.toString()),
    EntityPickerColumn(header: '名称', text: (AreaTableEntity t) => t.areaNameLangZhCn),
    EntityPickerColumn(header: '地区编号', width: 120, text: (AreaTableEntity t) => t.continentId.toString()),
  ],
  idOf: (AreaTableEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<AreaTableRepository>().getAreaTables(
      filter: AreaTableFilterEntity(id: v[0], name: v[1]), page: page),
  count: (v) => GetIt.instance.get<AreaTableRepository>()
      .countAreaTables(filter: AreaTableFilterEntity(id: v[0], name: v[1])),
);
