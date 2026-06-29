import 'package:foxy/entity/item_random_properties_entity.dart';
import 'package:foxy/repository/item_random_properties_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final itemRandomPropertiesPickerDelegate = EntityPickerDelegate<ItemRandomPropertiesEntity>(
  title: '随机属性',
  errorLabel: '搜索随机属性失败',
  filters: const [EntityPickerFilter('属性ID'), EntityPickerFilter('属性名称')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (ItemRandomPropertiesEntity t) => t.id.toString()),
    EntityPickerColumn(
      header: '名称',
      text: (ItemRandomPropertiesEntity t) => t.nameLangZhCn.isNotEmpty ? t.nameLangZhCn : t.name,
    ),
  ],
  idOf: (ItemRandomPropertiesEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<ItemRandomPropertiesRepository>().getItemRandomProperties(
      id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1], page: page),
  count: (v) => GetIt.instance.get<ItemRandomPropertiesRepository>().countItemRandomProperties(
      id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1]),
);
