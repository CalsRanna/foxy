import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/dbc_faction_entity.dart';
import 'package:foxy/repository/dbc_faction_repository.dart';
import 'package:get_it/get_it.dart';

class DbcFactionSelectorController extends SelectorController<DbcFactionEntity> {
  final _repository = GetIt.instance.get<DbcFactionRepository>();

  String idFilter = '';
  String nameFilter = '';

  @override
  String get errorLabel => '搜索阵营失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final name = nameFilter.isEmpty ? null : nameFilter;
    final result = await _repository.getDbcFactions(id: id, name: name, page: page);
    final count = await _repository.countDbcFactions(id: id, name: name);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    nameFilter = '';
  }
}
