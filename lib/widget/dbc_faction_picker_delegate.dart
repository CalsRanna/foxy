import 'package:foxy/entity/dbc_faction_entity.dart';
import 'package:foxy/repository/dbc_faction_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final dbcFactionPickerDelegate = EntityPickerDelegate<DbcFactionEntity>(
  title: '阵营',
  errorLabel: '搜索阵营失败',
  filters: const [EntityPickerFilter('阵营ID'), EntityPickerFilter('阵营名称')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (DbcFactionEntity t) => t.id.toString()),
    EntityPickerColumn(header: '名称', text: (DbcFactionEntity t) => t.nameLangZhCn),
    EntityPickerColumn(header: '描述', text: (DbcFactionEntity t) => t.descriptionLangZhCn),
  ],
  idOf: (DbcFactionEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<DbcFactionRepository>().getDbcFactions(
      id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1], page: page),
  count: (v) => GetIt.instance.get<DbcFactionRepository>()
      .countDbcFactions(id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1]),
);
