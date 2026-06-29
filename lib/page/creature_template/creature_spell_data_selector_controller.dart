import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/creature_spell_data_entity.dart';
import 'package:foxy/repository/creature_spell_data_repository.dart';
import 'package:get_it/get_it.dart';

class CreatureSpellDataSelectorController extends SelectorController<BriefCreatureSpellDataEntity> {
  final _repository = GetIt.instance.get<CreatureSpellDataRepository>();

  String idFilter = '';
  String spellFilter = '';

  @override
  String get errorLabel => '搜索宠物技能失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final spell = spellFilter.isEmpty ? null : spellFilter;
    final result = await _repository.getCreatureSpellDatas(id: id, spell: spell, page: page);
    final count = await _repository.countCreatureSpellDatas(id: id, spell: spell);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    spellFilter = '';
  }
}
