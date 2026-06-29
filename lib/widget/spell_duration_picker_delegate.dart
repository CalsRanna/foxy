import 'package:foxy/entity/spell_duration_entity.dart';
import 'package:foxy/repository/spell_duration_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final spellDurationPickerDelegate = EntityPickerDelegate<SpellDurationEntity>(
  title: '施法时间',
  errorLabel: '搜索持续时间失败',
  filters: const [EntityPickerFilter('持续时间ID')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (SpellDurationEntity t) => t.id.toString()),
    EntityPickerColumn(header: '持续时间', width: 120, text: (SpellDurationEntity t) => t.duration.toString()),
    EntityPickerColumn(header: '每级增加值', width: 120, text: (SpellDurationEntity t) => t.durationPerLevel.toString()),
    EntityPickerColumn(header: '最大持续时间', text: (SpellDurationEntity t) => t.maxDuration.toString()),
  ],
  idOf: (SpellDurationEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<SpellDurationRepository>()
      .getSpellDurations(id: v[0].isEmpty ? null : v[0], page: page),
  count: (v) => GetIt.instance.get<SpellDurationRepository>().countSpellDurations(id: v[0].isEmpty ? null : v[0]),
);
