import 'package:foxy/entity/spell_range_entity.dart';
import 'package:foxy/repository/spell_range_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final spellRangePickerDelegate = EntityPickerDelegate<SpellRangeEntity>(
  title: '技能射程',
  errorLabel: '搜索射程失败',
  filters: const [EntityPickerFilter('射程ID'), EntityPickerFilter('射程名称')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (SpellRangeEntity t) => t.id.toString()),
    EntityPickerColumn(header: '名称', text: (SpellRangeEntity t) => t.displayNameLangZhCn),
    EntityPickerColumn(header: '最小射程', width: 120, text: (SpellRangeEntity t) => t.rangeMin0.toStringAsFixed(1)),
    EntityPickerColumn(header: '最大射程', width: 120, text: (SpellRangeEntity t) => t.rangeMax0.toStringAsFixed(1)),
  ],
  idOf: (SpellRangeEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<SpellRangeRepository>().getSpellRanges(
      id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1], page: page),
  count: (v) => GetIt.instance.get<SpellRangeRepository>()
      .countSpellRanges(id: v[0].isEmpty ? null : v[0], name: v[1].isEmpty ? null : v[1]),
);
