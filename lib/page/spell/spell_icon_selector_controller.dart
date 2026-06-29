import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/spell_icon_entity.dart';
import 'package:foxy/repository/spell_icon_repository.dart';
import 'package:get_it/get_it.dart';

class SpellIconSelectorController extends SelectorController<SpellIconEntity> {
  final _repository = GetIt.instance.get<SpellIconRepository>();

  String idFilter = '';
  String nameFilter = '';

  @override
  String get errorLabel => '搜索图标失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final name = nameFilter.isEmpty ? null : nameFilter;
    final result = await _repository.getSpellIcons(id: id, name: name, page: page);
    final count = await _repository.countSpellIcons(id: id, name: name);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    nameFilter = '';
  }
}
