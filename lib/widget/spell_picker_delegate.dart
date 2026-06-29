import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/entity/spell_filter_entity.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final spellPickerDelegate = EntityPickerDelegate<SpellEntity>(
  title: '技能',
  errorLabel: '搜索技能失败',
  filters: const [EntityPickerFilter('编号'), EntityPickerFilter('名称')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (SpellEntity t) => t.id.toString()),
    EntityPickerColumn(header: '名称', width: 240, text: (SpellEntity t) => t.nameLangZhCN),
    EntityPickerColumn(header: '子名称', width: 120, text: (SpellEntity t) => t.nameSubtextLangZhCN),
    EntityPickerColumn(header: '描述', text: (SpellEntity t) => t.descriptionLangZhCN),
  ],
  idOf: (SpellEntity t) => t.id,
  fetch: (page, v) async {
    final repo = GetIt.instance.get<SpellRepository>();
    final filter = SpellFilterEntity(id: v[0].isEmpty ? '' : v[0], name: v[1].isEmpty ? '' : v[1]);
    final briefs = await repo.getBriefSpells(page: page, filter: filter);
    return briefs
        .map((b) => SpellEntity(
              id: b.id,
              nameLangZhCN: b.name,
              nameSubtextLangZhCN: b.subtext,
              descriptionLangZhCN: b.description,
            ))
        .toList();
  },
  count: (v) {
    final repo = GetIt.instance.get<SpellRepository>();
    final filter = SpellFilterEntity(id: v[0].isEmpty ? '' : v[0], name: v[1].isEmpty ? '' : v[1]);
    return repo.countSpells(filter: filter);
  },
);
