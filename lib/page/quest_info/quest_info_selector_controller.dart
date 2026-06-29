import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/entity/quest_info_filter_entity.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:get_it/get_it.dart';

class QuestInfoSelectorController extends SelectorController<QuestInfoEntity> {
  final _repository = GetIt.instance.get<QuestInfoRepository>();

  String idFilter = '';
  String nameFilter = '';

  @override
  String get errorLabel => '搜索任务信息失败';

  @override
  Future<void> performSearch() async {
    final filter = QuestInfoFilterEntity(id: idFilter, name: nameFilter);
    final result = await _repository.getQuestInfos(filter: filter, page: page);
    final count = await _repository.countQuestInfos(filter: filter);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    nameFilter = '';
  }
}
