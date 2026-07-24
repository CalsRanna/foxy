import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'talent_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_talent')
class TalentEntity with _TalentEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('TabID')
  final int tabId;

  @FoxyBriefField()
  @FoxyFullField('TierID')
  final int tierId;

  @FoxyBriefField()
  @FoxyFullField('ColumnIndex')
  final int columnIndex;

  @FoxyBriefField()
  @FoxyFullField('SpellRank0')
  final int spellRank0;

  @FoxyFullField('SpellRank1')
  final int spellRank1;

  @FoxyFullField('SpellRank2')
  final int spellRank2;

  @FoxyFullField('SpellRank3')
  final int spellRank3;

  @FoxyFullField('SpellRank4')
  final int spellRank4;

  @FoxyFullField('SpellRank5')
  final int spellRank5;

  @FoxyFullField('SpellRank6')
  final int spellRank6;

  @FoxyFullField('SpellRank7')
  final int spellRank7;

  @FoxyFullField('SpellRank8')
  final int spellRank8;

  @FoxyFullField('PrereqTalent0')
  final int prereqTalent0;

  @FoxyFullField('PrereqTalent1')
  final int prereqTalent1;

  @FoxyFullField('PrereqTalent2')
  final int prereqTalent2;

  @FoxyFullField('PrereqRank0')
  final int prereqRank0;

  @FoxyFullField('PrereqRank1')
  final int prereqRank1;

  @FoxyFullField('PrereqRank2')
  final int prereqRank2;

  @FoxyFullField('Flags')
  final int flags;

  @FoxyFullField('RequiredSpellID')
  final int requiredSpellId;

  @FoxyFullField('CategoryMask0')
  final int categoryMask0;

  @FoxyFullField('CategoryMask1')
  final int categoryMask1;

  const TalentEntity({
    this.id = 0,
    this.tabId = 0,
    this.tierId = 0,
    this.columnIndex = 0,
    this.spellRank0 = 0,
    this.spellRank1 = 0,
    this.spellRank2 = 0,
    this.spellRank3 = 0,
    this.spellRank4 = 0,
    this.spellRank5 = 0,
    this.spellRank6 = 0,
    this.spellRank7 = 0,
    this.spellRank8 = 0,
    this.prereqTalent0 = 0,
    this.prereqTalent1 = 0,
    this.prereqTalent2 = 0,
    this.prereqRank0 = 0,
    this.prereqRank1 = 0,
    this.prereqRank2 = 0,
    this.flags = 0,
    this.requiredSpellId = 0,
    this.categoryMask0 = 0,
    this.categoryMask1 = 0,
  });

  factory TalentEntity.fromJson(Map<String, dynamic> json) =>
      _TalentEntityMixin.fromJson(json);
}
