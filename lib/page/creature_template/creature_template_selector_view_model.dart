import 'package:signals/signals.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/entity/creature_template_filter_entity.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class CreatureTemplateSelectorViewModel {
  final _repository = CreatureTemplateRepository();

  final entryFilter = signal('');
  final nameFilter = signal('');
  final items = signal<List<BriefCreatureTemplateEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final filter = CreatureTemplateFilterEntity(
        entry: entryFilter.value,
        name: nameFilter.value,
      );
      final result = await _repository.getBriefCreatureTemplates(
        page: page.value,
        filter: filter,
      );
      final count = await _repository.countCreatureTemplates(filter: filter);
      items.value = result;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('搜索生物模板失败: $e');
      DialogUtil.instance.error('搜索生物模板失败: $e');
    }
  }

  Future<void> paginate(int p) async {
    page.value = p;
    await search();
  }

  void reset() {
    entryFilter.value = '';
    nameFilter.value = '';
    page.value = 1;
    search();
  }

  void select(int? id) => selectedId.value = id;

  void dispose() {}
}
