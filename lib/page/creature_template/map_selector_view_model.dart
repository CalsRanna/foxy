import 'package:signals/signals.dart';
import 'package:foxy/entity/map_info_entity.dart';
import 'package:foxy/repository/map_info_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class MapSelectorViewModel {
  final _repository = MapInfoRepository();

  final idFilter = signal('');
  final nameFilter = signal('');
  final items = signal<List<MapInfoEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final id = idFilter.value.isEmpty ? null : idFilter.value;
      final name = nameFilter.value.isEmpty ? null : nameFilter.value;
      final items = await _repository.getMapInfos(
        id: id,
        name: name,
        page: page.value,
      );
      final total = await _repository.countMapInfos(id: id, name: name);
      this.items.value = items;
      this.total.value = total;
    } catch (e) {
      LoggerUtil.instance.e('搜索地图失败: $e');
      DialogUtil.instance.error('搜索地图失败: $e');
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
