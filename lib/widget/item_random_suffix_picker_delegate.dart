import 'package:foxy/entity/item_random_suffix_entity.dart';
import 'package:foxy/repository/item_random_suffix_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final itemRandomSuffixPickerDelegate = EntityPickerDelegate<ItemRandomSuffixEntity>(
  title: '随机后缀',
  errorLabel: '搜索随机后缀失败',
  filters: const [EntityPickerFilter('后缀ID'), EntityPickerFilter('后缀名称')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (ItemRandomSuffixEntity t) => t.id.toString()),
    EntityPickerColumn(header: '名称', text: (ItemRandomSuffixEntity t) => t.nameLangZhCn),
    EntityPickerColumn(header: '内部名称', text: (ItemRandomSuffixEntity t) => t.internalName),
  ],
  idOf: (ItemRandomSuffixEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<ItemRandomSuffixRepository>().getItemRandomSuffixes(
      id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1], page: page),
  count: (v) => GetIt.instance.get<ItemRandomSuffixRepository>().countItemRandomSuffixes(
      id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1]),
);
