import 'package:foxy/entity/spell_icon_entity.dart';
import 'package:foxy/repository/spell_icon_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final spellIconPickerDelegate = EntityPickerDelegate<SpellIconEntity>(
  title: '技能图标',
  errorLabel: '搜索图标失败',
  filters: const [EntityPickerFilter('图标ID'), EntityPickerFilter('文件名')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (SpellIconEntity t) => t.id.toString()),
    EntityPickerColumn(header: '图标文件', text: (SpellIconEntity t) => t.textureFilename),
  ],
  idOf: (SpellIconEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<SpellIconRepository>().getSpellIcons(
      id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1], page: page),
  count: (v) => GetIt.instance.get<SpellIconRepository>()
      .countSpellIcons(id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1]),
);
