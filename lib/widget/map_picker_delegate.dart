import 'package:foxy/entity/map_info_entity.dart';
import 'package:foxy/repository/map_info_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final mapPickerDelegate = EntityPickerDelegate<MapInfoEntity>(
  title: '地图',
  errorLabel: '搜索地图失败',
  filters: const [EntityPickerFilter('地图ID'), EntityPickerFilter('地图名称')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (MapInfoEntity t) => t.id.toString()),
    EntityPickerColumn(header: '名称', text: (MapInfoEntity t) => t.mapNameLangZhCn),
    EntityPickerColumn(header: '类型', width: 120, text: (MapInfoEntity t) => t.instanceType.toString()),
    EntityPickerColumn(header: 'PVP', width: 120, text: (MapInfoEntity t) => t.pvp.toString()),
  ],
  idOf: (MapInfoEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<MapInfoRepository>().getMapInfos(
      id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1], page: page),
  count: (v) => GetIt.instance.get<MapInfoRepository>()
      .countMapInfos(id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1]),
);
