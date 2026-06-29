import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/map_info_entity.dart';
import 'package:foxy/repository/map_info_repository.dart';
import 'package:get_it/get_it.dart';

class MapSelectorController extends SelectorController<MapInfoEntity> {
  final _repository = GetIt.instance.get<MapInfoRepository>();

  String idFilter = '';
  String nameFilter = '';

  @override
  String get errorLabel => '搜索地图失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final name = nameFilter.isEmpty ? null : nameFilter;
    final result = await _repository.getMapInfos(id: id, name: name, page: page);
    final count = await _repository.countMapInfos(id: id, name: name);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    nameFilter = '';
  }
}
