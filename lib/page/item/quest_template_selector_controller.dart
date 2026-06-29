import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/entity/quest_template_filter_entity.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:get_it/get_it.dart';

class QuestTemplateSelectorController extends SelectorController<BriefQuestTemplateEntity> {
  final _repository = GetIt.instance.get<QuestTemplateRepository>();

  String idFilter = '';
  String nameFilter = '';

  @override
  String get errorLabel => '搜索任务失败';

  @override
  Future<void> performSearch() async {
    final filter = QuestTemplateFilterEntity(id: idFilter, title: nameFilter);
    final result = await _repository.getBriefQuestTemplates(filter: filter, page: page);
    final count = await _repository.countQuestTemplates(filter: filter);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    nameFilter = '';
  }
}
