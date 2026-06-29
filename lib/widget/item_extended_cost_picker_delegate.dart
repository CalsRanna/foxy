import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/entity/item_extended_cost_filter_entity.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final itemExtendedCostPickerDelegate = EntityPickerDelegate<ItemExtendedCostEntity>(
  title: '选择扩展价格',
  errorLabel: '搜索扩展价格失败',
  emptyText: '暂无数据',
  filters: const [EntityPickerFilter('编号')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (ItemExtendedCostEntity t) => t.id.toString()),
    EntityPickerColumn(header: '荣誉点数', width: 120, text: (ItemExtendedCostEntity t) => t.honorPoints.toString()),
    EntityPickerColumn(header: '竞技场点数', width: 120, text: (ItemExtendedCostEntity t) => t.arenaPoints.toString()),
    EntityPickerColumn(header: '竞技场等级', text: (ItemExtendedCostEntity t) => t.arenaBracket.toString()),
  ],
  idOf: (ItemExtendedCostEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<ItemExtendedCostRepository>().getItemExtendedCosts(
      filter: ItemExtendedCostFilterEntity(id: v[0]), page: page),
  count: (v) => GetIt.instance.get<ItemExtendedCostRepository>()
      .countItemExtendedCosts(filter: ItemExtendedCostFilterEntity(id: v[0])),
);
