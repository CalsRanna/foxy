import 'package:signals/signals.dart';
import 'package:foxy/entity/creature_display_info_entity.dart';
import 'package:foxy/repository/creature_display_info_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class CreatureDisplayInfoSelectorViewModel {
  final _repository = CreatureDisplayInfoRepository();

  final idFilter = signal('');
  final modelNameFilter = signal('');
  final items = signal<List<BriefCreatureDisplayInfoEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final id = idFilter.value.isEmpty ? null : idFilter.value;
      final modelName =
          modelNameFilter.value.isEmpty ? null : modelNameFilter.value;
      final result = await _repository.getCreatureDisplayInfos(
        id: id,
        modelName: modelName,
        page: page.value,
      );
      final count = await _repository.countCreatureDisplayInfos(
        id: id,
        modelName: modelName,
      );
      items.value = result;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('搜索生物模型失败: $e');
      DialogUtil.instance.error('搜索生物模型失败: $e');
    }
  }

  Future<void> paginate(int p) async {
    page.value = p;
    await search();
  }

  void reset() {
    idFilter.value = '';
    modelNameFilter.value = '';
    page.value = 1;
    search();
  }

  void select(int? id) => selectedId.value = id;

  void dispose() {}
}
