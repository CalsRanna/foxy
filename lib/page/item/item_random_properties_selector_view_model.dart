import 'package:signals/signals.dart';
import 'package:foxy/entity/item_random_properties_entity.dart';
import 'package:foxy/repository/item_random_properties_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class ItemRandomPropertiesSelectorViewModel {
  final _repository = ItemRandomPropertiesRepository();

  final idFilter = signal('');
  final nameFilter = signal('');
  final items = signal<List<ItemRandomPropertiesEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final id = idFilter.value.isEmpty ? null : idFilter.value;
      final name = nameFilter.value.isEmpty ? null : nameFilter.value;
      final items = await _repository.getItemRandomProperties(
        id: id,
        name: name,
        page: page.value,
      );
      final total = await _repository.countItemRandomProperties(
        id: id,
        name: name,
      );
      this.items.value = items;
      this.total.value = total;
    } catch (e) {
      LoggerUtil.instance.e('搜索随机属性失败: $e');
      DialogUtil.instance.error('搜索随机属性失败: $e');
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
