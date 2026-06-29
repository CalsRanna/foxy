import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/spell_duration_entity.dart';
import 'package:foxy/repository/spell_duration_repository.dart';
import 'package:get_it/get_it.dart';

class SpellDurationSelectorController extends SelectorController<SpellDurationEntity> {
  final _repository = GetIt.instance.get<SpellDurationRepository>();

  String idFilter = '';

  @override
  String get errorLabel => '搜索持续时间失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final result = await _repository.getSpellDurations(id: id, page: page);
    final count = await _repository.countSpellDurations(id: id);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
  }
}
