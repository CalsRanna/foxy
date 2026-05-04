import 'package:signals/signals.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/entity/quest_template_filter_entity.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class QuestTemplateSelectorViewModel {
  final _repository = QuestTemplateRepository();

  final idFilter = signal('');
  final nameFilter = signal('');
  final items = signal<List<BriefQuestTemplateEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final filter = QuestTemplateFilterEntity(
        id: idFilter.value,
        title: nameFilter.value,
      );
      final items = await _repository.getBriefQuestTemplates(
        filter: filter,
        page: page.value,
      );
      final total = await _repository.countQuestTemplates(filter: filter);
      this.items.value = items;
      this.total.value = total;
    } catch (e) {
      LoggerUtil.instance.e('搜索任务失败: $e');
      DialogUtil.instance.error('搜索任务失败: $e');
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
