import 'package:signals/signals.dart';
import 'package:foxy/entity/creature_spell_data_entity.dart';
import 'package:foxy/repository/creature_spell_data_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class CreatureSpellDataSelectorViewModel {
  final _repository = CreatureSpellDataRepository();

  final idFilter = signal('');
  final spellFilter = signal('');
  final items = signal<List<BriefCreatureSpellDataEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final id = idFilter.value.isEmpty ? null : idFilter.value;
      final spell = spellFilter.value.isEmpty ? null : spellFilter.value;
      final result = await _repository.getCreatureSpellDatas(
        id: id,
        spell: spell,
        page: page.value,
      );
      final count = await _repository.countCreatureSpellDatas(
        id: id,
        spell: spell,
      );
      items.value = result;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('搜索宠物技能失败: $e');
      DialogUtil.instance.error('搜索宠物技能失败: $e');
    }
  }

  Future<void> paginate(int p) async {
    page.value = p;
    await search();
  }

  void reset() {
    idFilter.value = '';
    spellFilter.value = '';
    page.value = 1;
    search();
  }

  void select(int? id) => selectedId.value = id;

  void dispose() {}
}
