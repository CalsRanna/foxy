import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/entity/area_table_filter_entity.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:get_it/get_it.dart';

class AreaTableSelectorController extends SelectorController<AreaTableEntity> {
  final _repository = GetIt.instance.get<AreaTableRepository>();

  String idFilter = '';
  String nameFilter = '';

  @override
  String get errorLabel => '搜索区域失败';

  @override
  Future<void> performSearch() async {
    final filter = AreaTableFilterEntity(id: idFilter, name: nameFilter);
    final result = await _repository.getAreaTables(filter: filter, page: page);
    final count = await _repository.countAreaTables(filter: filter);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    nameFilter = '';
  }
}
