import 'package:signals/signals.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/entity/spell_filter_entity.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class SpellSelectorViewModel {
  final _repository = SpellRepository();

  final idFilter = signal('');
  final nameFilter = signal('');
  final items = signal<List<SpellEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final id = idFilter.value.isEmpty ? '' : idFilter.value;
      final name = nameFilter.value.isEmpty ? '' : nameFilter.value;
      final filter = SpellFilterEntity(id: id, name: name);
      final briefs = await _repository.getBriefSpells(
        page: page.value,
        filter: filter,
      );
      final count = await _repository.countSpells(filter: filter);
      final items = briefs
          .map(
            (b) => SpellEntity(
              id: b.id,
              nameLangZhCN: b.name,
              nameSubtextLangZhCN: b.subtext,
              descriptionLangZhCN: b.description,
            ),
          )
          .toList();
      this.items.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('搜索技能失败: $e');
      DialogUtil.instance.error('搜索技能失败: $e');
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
