import 'package:foxy/entity/creature_spell_data_entity.dart';
import 'package:foxy/repository/creature_spell_data_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final creatureSpellDataPickerDelegate = EntityPickerDelegate<BriefCreatureSpellDataEntity>(
  title: '宠物技能',
  errorLabel: '搜索宠物技能失败',
  filters: const [EntityPickerFilter('编号'), EntityPickerFilter('技能名称')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (BriefCreatureSpellDataEntity t) => t.id.toString()),
    EntityPickerColumn(header: '技能1', text: (BriefCreatureSpellDataEntity t) => t.spellName1),
    EntityPickerColumn(header: '技能2', text: (BriefCreatureSpellDataEntity t) => t.spellName2),
    EntityPickerColumn(header: '技能3', text: (BriefCreatureSpellDataEntity t) => t.spellName3),
    EntityPickerColumn(header: '技能4', text: (BriefCreatureSpellDataEntity t) => t.spellName4),
  ],
  idOf: (BriefCreatureSpellDataEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<CreatureSpellDataRepository>().getCreatureSpellDatas(
      id: v[0].isEmpty ? null : v[0], spell: v[1].isEmpty ? null : v[1], page: page),
  count: (v) => GetIt.instance.get<CreatureSpellDataRepository>().countCreatureSpellDatas(
      id: v[0].isEmpty ? null : v[0], spell: v[1].isEmpty ? null : v[1]),
);
