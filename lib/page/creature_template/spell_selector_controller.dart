import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/entity/spell_filter_entity.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:get_it/get_it.dart';

class SpellSelectorController extends SelectorController<SpellEntity> {
  final _repository = GetIt.instance.get<SpellRepository>();

  String idFilter = '';
  String nameFilter = '';

  @override
  String get errorLabel => '搜索技能失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? '' : idFilter;
    final name = nameFilter.isEmpty ? '' : nameFilter;
    final filter = SpellFilterEntity(id: id, name: name);
    final briefs = await _repository.getBriefSpells(page: page, filter: filter);
    final count = await _repository.countSpells(filter: filter);
    items = briefs
        .map((b) => SpellEntity(
              id: b.id,
              nameLangZhCN: b.name,
              nameSubtextLangZhCN: b.subtext,
              descriptionLangZhCN: b.description,
            ))
        .toList();
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
    nameFilter = '';
  }
}
