import 'package:signals/signals.dart';
import 'package:foxy/entity/item_random_suffix_entity.dart';
import 'package:foxy/repository/item_random_suffix_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class ItemRandomSuffixSelectorViewModel {
  final _repository = ItemRandomSuffixRepository();

  final idFilter = signal('');
  final nameFilter = signal('');
  final items = signal<List<ItemRandomSuffixEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final id = idFilter.value.isEmpty ? null : idFilter.value;
      final name = nameFilter.value.isEmpty ? null : nameFilter.value;
      final items = await _repository.getItemRandomSuffixes(
        id: id,
        name: name,
        page: page.value,
      );
      final total = await _repository.countItemRandomSuffixes(
        id: id,
        name: name,
      );
      this.items.value = items;
      this.total.value = total;
    } catch (e) {
      LoggerUtil.instance.e('搜索随机后缀失败: $e');
      DialogUtil.instance.error('搜索随机后缀失败: $e');
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
