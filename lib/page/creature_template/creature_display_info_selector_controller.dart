import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/creature_display_info_entity.dart';
import 'package:foxy/repository/creature_display_info_repository.dart';
import 'package:get_it/get_it.dart';

class CreatureDisplayInfoSelectorController extends SelectorController<BriefCreatureDisplayInfoEntity> {
  final _repository = GetIt.instance.get<CreatureDisplayInfoRepository>();

  String idFilter = '';
  String modelNameFilter = '';

  @override
  String get errorLabel => '搜索生物模型失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final modelName = modelNameFilter.isEmpty ? null : modelNameFilter;
    final result = await _repository.getCreatureDisplayInfos(id: id, modelName: modelName, page: page);
    final count = await _repository.countCreatureDisplayInfos(id: id, modelName: modelName);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    modelNameFilter = '';
  }
}
