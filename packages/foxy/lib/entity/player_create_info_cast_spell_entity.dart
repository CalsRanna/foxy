import 'package:foxy/constant/flag_item.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy_annotation/entity_annotations.dart';

part 'player_create_info_cast_spell_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'playercreateinfo_cast_spell')
class PlayerCreateInfoCastSpellEntity
    with _PlayerCreateInfoCastSpellEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('raceMask', key: true)
  final int raceMask;

  @FoxyBriefField()
  @FoxyFullField('classMask', key: true)
  final int classMask;

  @FoxyBriefField()
  @FoxyFullField('spell', key: true)
  final int spell;

  @FoxyBriefField()
  @FoxyFullField('note', key: true)
  final String? note;

  const PlayerCreateInfoCastSpellEntity({
    this.raceMask = 0,
    this.classMask = 0,
    this.spell = 0,
    this.note,
  });

  factory PlayerCreateInfoCastSpellEntity.fromJson(Map<String, dynamic> json) =>
      _PlayerCreateInfoCastSpellEntityMixin.fromJson(json);
}

extension BriefPlayerCreateInfoCastSpellEntityLabel
    on BriefPlayerCreateInfoCastSpellEntity {
  /// 种族掩码标签（人类/兽人/…），未命中回退为原始掩码。
  String get raceMaskLabel =>
      flagMaskLabel(raceMask, kPlayerCreateRaceMaskFlags);

  /// 职业掩码标签（战士/圣骑士/…），未命中回退为原始掩码。
  String get classMaskLabel =>
      flagMaskLabel(classMask, kPlayerCreateClassMaskFlags);
}
