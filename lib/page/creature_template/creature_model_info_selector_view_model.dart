import 'package:signals/signals.dart';
import 'package:foxy/entity/creature_model_info_entity.dart';
import 'package:foxy/repository/creature_model_info_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class CreatureModelInfoSelectorViewModel {
  final _repository = CreatureModelInfoRepository();

  final idFilter = signal('');
  final items = signal<List<CreatureModelInfoEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final id = idFilter.value.isEmpty ? null : idFilter.value;
      final result = await _repository.getCreatureModelInfos(
        id: id,
        page: page.value,
      );
      final count = await _repository.countCreatureModelInfos(id: id);
      items.value = result;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('搜索生物模型信息失败: $e');
      DialogUtil.instance.error('搜索生物模型信息失败: $e');
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
