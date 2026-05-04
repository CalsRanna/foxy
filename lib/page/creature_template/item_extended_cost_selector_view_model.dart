import 'package:signals/signals.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/entity/item_extended_cost_filter_entity.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class ItemExtendedCostSelectorViewModel {
  final _repository = ItemExtendedCostRepository();

  final idFilter = signal('');
  final items = signal<List<ItemExtendedCostEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final filter = ItemExtendedCostFilterEntity(id: idFilter.value);
      final result = await _repository.getItemExtendedCosts(
        filter: filter,
        page: page.value,
      );
      final count = await _repository.countItemExtendedCosts(filter: filter);
      items.value = result;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('搜索扩展价格失败: $e');
      DialogUtil.instance.error('搜索扩展价格失败: $e');
    }
  }

  Future<void> paginate(int p) async {
    page.value = p;
    await search();
  }

  void reset() {
    idFilter.value = '';
    page.value = 1;
    search();
  }

  void select(int? id) => selectedId.value = id;

  void dispose() {}
}
