import 'package:signals/signals.dart';
import 'package:foxy/entity/dbc_faction_entity.dart';
import 'package:foxy/repository/dbc_faction_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class DbcFactionSelectorViewModel {
  final _repository = DbcFactionRepository();

  final idFilter = signal('');
  final nameFilter = signal('');
  final items = signal<List<DbcFactionEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final id = idFilter.value.isEmpty ? null : idFilter.value;
      final name = nameFilter.value.isEmpty ? null : nameFilter.value;
      final result = await _repository.getDbcFactions(
        id: id,
        name: name,
        page: page.value,
      );
      final count = await _repository.countDbcFactions(id: id, name: name);
      items.value = result;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('搜索阵营失败: $e');
      DialogUtil.instance.error('搜索阵营失败: $e');
    }
  }

  Future<void> paginate(int p) async {
    page.value = p;
    await search();
  }

  void reset() {
    idFilter.value = '';
    nameFilter.value = '';
    page.value = 1;
    search();
  }

  void select(int? id) => selectedId.value = id;

  void dispose() {}
}
