import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/creature_model_info_entity.dart';
import 'package:foxy/repository/creature_model_info_repository.dart';
import 'package:get_it/get_it.dart';

class CreatureModelInfoSelectorController extends SelectorController<CreatureModelInfoEntity> {
  final _repository = GetIt.instance.get<CreatureModelInfoRepository>();

  String idFilter = '';

  @override
  String get errorLabel => '搜索生物模型信息失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final result = await _repository.getCreatureModelInfos(id: id, page: page);
    final count = await _repository.countCreatureModelInfos(id: id);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
  }
}
