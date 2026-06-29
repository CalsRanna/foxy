import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/lock_entity.dart';
import 'package:foxy/repository/lock_repository.dart';
import 'package:get_it/get_it.dart';

class LockSelectorController extends SelectorController<LockEntity> {
  final _repository = GetIt.instance.get<LockRepository>();

  String idFilter = '';

  @override
  String get errorLabel => '搜索锁失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final result = await _repository.getLocks(id: id, page: page);
    final count = await _repository.countLocks(id: id);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
  }
}
