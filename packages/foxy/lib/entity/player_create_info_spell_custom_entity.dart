import 'package:foxy/constant/flag_item.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy_annotation/entity_annotations.dart';

part 'player_create_info_spell_custom_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'playercreateinfo_spell_custom')
class PlayerCreateInfoSpellCustomEntity
    with _PlayerCreateInfoSpellCustomEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('racemask', key: true)
  final int raceMask;

  @FoxyBriefField()
  @FoxyFullField('classmask', key: true)
  final int classMask;

  @FoxyBriefField()
  @FoxyFullField('Spell', key: true)
  final int spell;

  @FoxyBriefField()
  @FoxyFullField('Note')
  final String note;

  const PlayerCreateInfoSpellCustomEntity({
    this.raceMask = 0,
    this.classMask = 0,
    this.spell = 0,
    this.note = '',
  });

  factory PlayerCreateInfoSpellCustomEntity.fromJson(
    Map<String, dynamic> json,
  ) => _PlayerCreateInfoSpellCustomEntityMixin.fromJson(json);
}

extension BriefPlayerCreateInfoSpellCustomEntityLabel
    on BriefPlayerCreateInfoSpellCustomEntity {
  /// 种族掩码标签（人类/兽人/…），未命中回退为原始掩码。
  String get raceMaskLabel =>
      flagMaskLabel(raceMask, kPlayerCreateRaceMaskFlags);

  /// 职业掩码标签（战士/圣骑士/…），未命中回退为原始掩码。
  String get classMaskLabel =>
      flagMaskLabel(classMask, kPlayerCreateClassMaskFlags);
}
