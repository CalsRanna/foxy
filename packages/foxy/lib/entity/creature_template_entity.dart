import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';

part 'creature_template_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('localeName')
@FoxyBriefField.text('localeSubName')
@FoxyFullEntity()
class CreatureTemplateEntity with _CreatureTemplateEntityMixin {
  @FoxyFullField('AIName')
  final String aiName;

  @FoxyFullField('ArmorModifier')
  final double armorModifier;

  @FoxyFullField('BaseAttackTime')
  final int baseAttackTime;

  @FoxyFullField('BaseVariance')
  final double baseVariance;

  @FoxyFullField('DamageModifier')
  final double damageModifier;

  @FoxyFullField('difficulty_entry_1')
  final int difficultyEntry1;

  @FoxyFullField('difficulty_entry_2')
  final int difficultyEntry2;

  @FoxyFullField('difficulty_entry_3')
  final int difficultyEntry3;

  @FoxyFieldMeaning.enumValues(
    '伤害学派',
    values: CreatureEnums.damageSchoolOptions,
  )
  @FoxyFullField('dmgschool')
  final int damageSchool;

  @FoxyFullField('detection_range')
  final double detectionRange;

  @FoxyFieldMeaning.flags('动态标志', flags: CreatureFlags.dynamicFlagOptions)
  @FoxyFullField('dynamicflags')
  final int dynamicFlags;

  @FoxyBriefField()
  @FoxyFullField('entry', key: true)
  final int entry;

  @FoxyFullField('exp')
  final int exp;

  @FoxyFullField('ExperienceModifier')
  final double experienceModifier;

  @FoxyFullField('faction')
  final int faction;

  @FoxyFieldMeaning.enumValues(
    '生物科',
    values: CreatureEnums.creatureFamilyOptions,
  )
  @FoxyFullField('family')
  final int family;

  @FoxyFieldMeaning.flags('额外标志', flags: CreatureFlags.flagsExtraOptions)
  @FoxyFullField('flags_extra')
  final int flagsExtra;

  @FoxyFullField('gossip_menu_id')
  final int gossipMenuId;

  @FoxyFullField('HealthModifier')
  final double healthModifier;

  @FoxyFullField('HoverHeight')
  final double hoverHeight;

  @FoxyFullField('IconName')
  final String iconName;

  @FoxyFieldMeaning.reference(
    '击杀计数生物',
    table: 'creature_template',
    column: 'entry',
  )
  @FoxyFullField('KillCredit1')
  final int killCredit1;

  @FoxyFieldMeaning.reference(
    '击杀计数生物',
    table: 'creature_template',
    column: 'entry',
  )
  @FoxyFullField('KillCredit2')
  final int killCredit2;

  @FoxyFieldMeaning.reference(
    '生物掉落模板',
    table: 'creature_loot_template',
    column: 'entry',
  )
  @FoxyFullField('lootid')
  final int lootId;

  @FoxyFullField('maxgold')
  final int maxGold;

  @FoxyBriefField()
  @FoxyFullField('maxlevel')
  final int maxLevel;

  @FoxyFullField('ManaModifier')
  final double manaModifier;

  @FoxyBriefField()
  @FoxyFullField('minlevel')
  final int minLevel;

  @FoxyFullField('mingold')
  final int minGold;

  @FoxyFullField('movementId')
  final int movementId;

  @FoxyFullField('MovementType')
  final int movementType;

  @FoxyBriefField()
  @FoxyFullField('name')
  final String name;

  @FoxyFieldMeaning.flags('NPC 标志', flags: CreatureFlags.npcFlagOptions)
  @FoxyFullField('npcflag')
  final int npcFlag;

  @FoxyFullField('PetSpellDataId')
  final int petSpellDataId;

  @FoxyFieldMeaning.reference(
    '偷窃掉落模板',
    table: 'pickpocketing_loot_template',
    column: 'entry',
  )
  @FoxyFullField('pickpocketloot')
  final int pickpocketLoot;

  @FoxyFullField('RacialLeader')
  final int racialLeader;

  @FoxyFullField('RangeAttackTime')
  final int rangeAttackTime;

  @FoxyFullField('RangeVariance')
  final double rangeVariance;

  @FoxyFieldMeaning.enumValues('生物等级', values: CreatureEnums.rankOptions)
  @FoxyFullField('rank')
  final int rank;

  @FoxyFullField('RegenHealth')
  final int regenHealth;

  @FoxyFullField('ScriptName')
  final String scriptName;

  @FoxyFieldMeaning.reference(
    '剥皮掉落模板',
    table: 'skinning_loot_template',
    column: 'entry',
  )
  @FoxyFullField('skinloot')
  final int skinLoot;

  @FoxyFullField('speed_flight')
  final double speedFlight;

  @FoxyFullField('speed_run')
  final double speedRun;

  @FoxyFullField('speed_swim')
  final double speedSwim;

  @FoxyFullField('speed_walk')
  final double speedWalk;

  @FoxyBriefField()
  @FoxyFullField('subname')
  final String subName;

  @FoxyFieldMeaning.enumValues(
    '生物类型',
    values: CreatureEnums.creatureTypeOptions,
  )
  @FoxyFullField('type')
  final int type;

  @FoxyFieldMeaning.flags('类型标志', flags: CreatureFlags.creatureTypeFlagOptions)
  @FoxyFullField('type_flags')
  final int typeFlags;

  @FoxyFieldMeaning.enumValues('单位职业', values: CreatureEnums.unitClassOptions)
  @FoxyFullField('unit_class')
  final int unitClass;

  @FoxyFieldMeaning.flags('单位标志', flags: CreatureFlags.unitFlagOptions)
  @FoxyFullField('unit_flags')
  final int unitFlags;

  @FoxyFullField('unit_flags2')
  final int unitFlags2;

  @FoxyFullField('VehicleId')
  final int vehicleId;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  @FoxyFullField('CreatureImmunitiesId')
  final int creatureImmunitiesId;

  const CreatureTemplateEntity({
    this.aiName = '',
    this.armorModifier = 1,
    this.baseAttackTime = 0,
    this.baseVariance = 1,
    this.damageModifier = 1,
    this.difficultyEntry1 = 0,
    this.difficultyEntry2 = 0,
    this.difficultyEntry3 = 0,
    this.damageSchool = 0,
    this.detectionRange = 20,
    this.dynamicFlags = 0,
    this.entry = 0,
    this.exp = 0,
    this.experienceModifier = 1,
    this.faction = 0,
    this.family = 0,
    this.flagsExtra = 0,
    this.gossipMenuId = 0,
    this.healthModifier = 1,
    this.hoverHeight = 1,
    this.iconName = '',
    this.killCredit1 = 0,
    this.killCredit2 = 0,
    this.lootId = 0,
    this.maxGold = 0,
    this.maxLevel = 1,
    this.manaModifier = 1,
    this.minLevel = 1,
    this.minGold = 0,
    this.movementId = 0,
    this.movementType = 0,
    this.name = '',
    this.npcFlag = 0,
    this.petSpellDataId = 0,
    this.pickpocketLoot = 0,
    this.racialLeader = 0,
    this.rangeAttackTime = 0,
    this.rangeVariance = 1,
    this.rank = 0,
    this.regenHealth = 1,
    this.scriptName = '',
    this.skinLoot = 0,
    this.speedFlight = 1,
    this.speedRun = 1.14286,
    this.speedSwim = 1,
    this.speedWalk = 1,
    this.subName = '',
    this.type = 0,
    this.typeFlags = 0,
    this.unitClass = 1,
    this.unitFlags = 0,
    this.unitFlags2 = 0,
    this.vehicleId = 0,
    this.verifiedBuild = 0,
    this.creatureImmunitiesId = 0,
  });

  factory CreatureTemplateEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureTemplateEntityMixin.fromJson(json);
}

extension BriefCreatureTemplateEntityDisplay on BriefCreatureTemplateEntity {
  String get displayName => localeName.isNotEmpty ? localeName : name;

  String get displaySubName =>
      localeSubName.isNotEmpty ? localeSubName : subName;
}
