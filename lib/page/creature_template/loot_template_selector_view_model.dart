import 'package:signals/signals.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class LootTemplateSelectorViewModel {
  LootTemplateRepository? _repository;
  final LootTableType tableType;

  LootTemplateSelectorViewModel(this.tableType) {
    _repository = LootTemplateRepository(tableType);
  }

  final entryFilter = signal('');
  final items = signal<List<BriefLootTemplateEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final entry = entryFilter.value.isEmpty ? null : entryFilter.value;
      final result = await _repository!.getLootTemplateDistinctEntries(
        entry: entry,
        page: page.value,
      );
      final count = await _repository!.countLootTemplates(entry: entry);
      items.value = result;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('搜索掉落模板失败: $e');
      DialogUtil.instance.error('搜索掉落模板失败: $e');
    }
  }

  Future<void> paginate(int p) async {
    page.value = p;
    await search();
  }

  void reset() {
    entryFilter.value = '';
    page.value = 1;
    search();
  }

  void select(int? id) => selectedId.value = id;

  void dispose() {}
}
