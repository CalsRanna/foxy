import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/waypoint_data_entity.dart';
import 'package:foxy/repository/waypoint_data_repository.dart';
import 'package:get_it/get_it.dart';

class WaypointDataSelectorController extends SelectorController<WaypointDataEntity> {
  final _repository = GetIt.instance.get<WaypointDataRepository>();

  String idFilter = '';

  @override
  String get errorLabel => '搜索路径点失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final result = await _repository.getWaypointDatas(id: id, page: page);
    final count = await _repository.countWaypointDatas(id: id);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
  }
}
