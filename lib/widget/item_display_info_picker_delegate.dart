import 'package:foxy/entity/item_display_info_entity.dart';
import 'package:foxy/repository/item_display_info_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final itemDisplayInfoPickerDelegate = EntityPickerDelegate<ItemDisplayInfoEntity>(
  title: '物品显示信息',
  errorLabel: '搜索显示信息失败',
  filters: const [EntityPickerFilter('显示信息ID'), EntityPickerFilter('模型名称')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (ItemDisplayInfoEntity t) => t.id.toString()),
    EntityPickerColumn(header: '模型名称', text: (ItemDisplayInfoEntity t) => t.modelName0),
    EntityPickerColumn(header: '图标', text: (ItemDisplayInfoEntity t) => t.inventoryIcon0),
  ],
  idOf: (ItemDisplayInfoEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<ItemDisplayInfoRepository>().getItemDisplayInfos(
      id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1], page: page),
  count: (v) => GetIt.instance.get<ItemDisplayInfoRepository>().countItemDisplayInfos(
      id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1]),
);
