import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/repository/loot_template_repository.dart';

class LootTemplateSelectorController extends SelectorController<BriefLootTemplateEntity> {
  LootTemplateRepository? _repository;
  final LootTableType tableType;

  LootTemplateSelectorController(this.tableType) {
    _repository = LootTemplateRepository(tableType);
  }

  String entryFilter = '';

  @override
  String get errorLabel => '搜索掉落模板失败';

  @override
  Future<void> performSearch() async {
    final entry = entryFilter.isEmpty ? null : entryFilter;
    final result = await _repository!.getLootTemplateDistinctEntries(entry: entry, page: page);
    final count = await _repository!.countLootTemplates(entry: entry);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    entryFilter = '';
  }
}
