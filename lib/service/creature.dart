import 'package:foxy/model/creature_template.dart';
import 'package:foxy/service/service.dart';
import 'package:mysql_client/mysql_client.dart';

class CreatureTemplateService with Service {
  Future<CreatureTemplate> find(int entry) async {
    final clauses = [
      'SELECT *',
      'FROM creature_template',
      'WHERE entry = $entry',
    ];
    final sql = clauses.join(' ');
    final result = await execute(sql);
    final json = result.rows.first.typedAssoc();
    return CreatureTemplate.fromJson(json);
    // final difficultyEntry1 = result.rows.first.typedColAt<int>(1) ?? 0;
    // final difficultyEntry2 = result.rows.first.typedColAt<int>(2) ?? 0;
    // final difficultyEntry3 = result.rows.first.typedColAt<int>(3) ?? 0;
    // final killCredit1 = result.rows.first.typedColAt<int>(4) ?? 0;
    // final killCredit2 = result.rows.first.typedColAt<int>(5) ?? 0;
    // final modelId1 = result.rows.first.typedColAt<int>(6) ?? 0;
    // final modelId2 = result.rows.first.typedColAt<int>(7) ?? 0;
    // final modelId3 = result.rows.first.typedColAt<int>(8) ?? 0;
    // final modelId4 = result.rows.first.typedColAt<int>(9) ?? 0;
    // final name = result.rows.first.typedColAt<String>(10) ?? '';
    // final subName = result.rows.first.typedColAt<String>(11) ?? '';
    // final iconName = result.rows.first.typedColAt<String>(12) ?? '';
    // final gossipMenuId = result.rows.first.typedColAt<int>(13) ?? 0;
    // final minLevel = result.rows.first.typedColAt<int>(14) ?? 0;
    // final maxLevel = result.rows.first.typedColAt<int>(15) ?? 0;
    // final exp = result.rows.first.typedColAt<int>(16) ?? 0;
    // final faction = result.rows.first.typedColAt<int>(17) ?? 0;
    // final npcFlags = result.rows.first.typedColAt<int>(18) ?? 0;
    // final speedWalk = result.rows.first.typedColAt<double>(19) ?? 0;
    // final speedRun = result.rows.first.typedColAt<double>(20) ?? 0;
    // final scale = result.rows.first.typedColAt<double>(21) ?? 0;
    // final rank = result.rows.first.typedColAt<int>(22) ?? 0;
    // final damageSchool = result.rows.first.typedColAt<int>(23) ?? 0;
    // final baseAttackTime = result.rows.first.typedColAt<int>(24) ?? 0;
    // final rangeAttackTime = result.rows.first.typedColAt<int>(25) ?? 0;
    // final baseVariance = result.rows.first.typedColAt<double>(26) ?? 0;
    // final rangeVariance = result.rows.first.typedColAt<double>(27) ?? 0;
    // final unitClass = result.rows.first.typedColAt<int>(28) ?? 0;
    // final unitFlags = result.rows.first.typedColAt<int>(29) ?? 0;
    // final unitFlags2 = result.rows.first.typedColAt<int>(30) ?? 0;
    // final dynamicFlags = result.rows.first.typedColAt<int>(31) ?? 0;
    // final family = result.rows.first.typedColAt<int>(32) ?? 0;
    // final type = result.rows.first.typedColAt<int>(33) ?? 0;
    // final typeFlags = result.rows.first.typedColAt<int>(34) ?? 0;
    // final lootId = result.rows.first.typedColAt<int>(35) ?? 0;
    // final pickpocketLoot = result.rows.first.typedColAt<int>(36) ?? 0;
    // final skinLoot = result.rows.first.typedColAt<int>(37) ?? 0;
    // final petSpellDataId = result.rows.first.typedColAt<int>(38) ?? 0;
    // final vehicleId = result.rows.first.typedColAt<int>(39) ?? 0;
    // final minGold = result.rows.first.typedColAt<int>(40) ?? 0;
    // final maxGold = result.rows.first.typedColAt<int>(41) ?? 0;
    // final aiName = result.rows.first.typedColAt<String>(42) ?? '';
    // final movementType = result.rows.first.typedColAt<int>(43) ?? 0;
    // final hoverHeight = result.rows.first.typedColAt<double>(44) ?? 0;
    // final healthModifier = result.rows.first.typedColAt<double>(45) ?? 0;
    // final manaModifier = result.rows.first.typedColAt<double>(46) ?? 0;
    // final armorModifier = result.rows.first.typedColAt<double>(47) ?? 0;
    // final damageModifier = result.rows.first.typedColAt<double>(48) ?? 0;
    // final experienceModifier = result.rows.first.typedColAt<double>(49) ?? 0;
    // final racialLeader = result.rows.first.typedColAt<int>(50) ?? 0;
    // final movementId = result.rows.first.typedColAt<int>(51) ?? 0;
    // final regenHealth = result.rows.first.typedColAt<int>(52) ?? 0;
    // final mechanicImmuneMask = result.rows.first.typedColAt<int>(53) ?? 0;
    // final spellSchoolImmuneMask = result.rows.first.typedColAt<int>(54) ?? 0;
    // final flagsExtra = result.rows.first.typedColAt<int>(55) ?? 0;
    // final scriptName = result.rows.first.typedColAt<String>(56) ?? '';
    // final verifiedBuild = result.rows.first.typedColAt<int>(57) ?? 0;
    // return CreatureTemplate()
    //   ..aiName = aiName
    //   ..armorModifier = armorModifier
    //   ..baseAttackTime = baseAttackTime
    //   ..baseVariance = baseVariance
    //   ..damageModifier = damageModifier
    //   ..damageSchool = damageSchool
    //   ..difficultyEntry1 = difficultyEntry1
    //   ..difficultyEntry2 = difficultyEntry2
    //   ..difficultyEntry3 = difficultyEntry3
    //   ..dynamicFlags = dynamicFlags
    //   ..entry = entry
    //   ..exp = exp
    //   ..experienceModifier = experienceModifier
    //   ..faction = faction
    //   ..family = family
    //   ..flagsExtra = flagsExtra
    //   ..gossipMenuId = gossipMenuId
    //   ..healthModifier = healthModifier
    //   ..hoverHeight = hoverHeight
    //   ..iconName = iconName
    //   ..killCredit1 = killCredit1
    //   ..killCredit2 = killCredit2
    //   ..lootId = lootId
    //   ..manaModifier = manaModifier
    //   ..maxGold = maxGold
    //   ..maxLevel = maxLevel
    //   ..mechanicImmuneMask = mechanicImmuneMask
    //   ..minGold = minGold
    //   ..minLevel = minLevel
    //   ..modelId1 = modelId1
    //   ..modelId2 = modelId2
    //   ..modelId3 = modelId3
    //   ..modelId4 = modelId4
    //   ..movementId = movementId
    //   ..movementType = movementType
    //   ..name = name
    //   ..npcFlag = npcFlags
    //   ..petSpellDataId = petSpellDataId
    //   ..pickpocketLoot = pickpocketLoot
    //   ..racialLeader = racialLeader
    //   ..rangeAttackTime = rangeAttackTime
    //   ..rangeVariance = rangeVariance
    //   ..rank = rank
    //   ..regenHealth = regenHealth
    //   ..scale = scale
    //   ..scriptName = scriptName
    //   ..skinLoot = skinLoot
    //   ..speedRun = speedRun
    //   ..speedWalk = speedWalk
    //   ..spellSchoolImmuneMask = spellSchoolImmuneMask
    //   ..subName = subName
    //   ..type = type
    //   ..typeFlags = typeFlags
    //   ..unitClass = unitClass
    //   ..unitFlags = unitFlags
    //   ..unitFlags2 = unitFlags2
    //   ..vehicleId = vehicleId
    //   ..verifiedBuild = verifiedBuild;
  }

  Future<List<BriefCreatureTemplate>> search({
    int page = 1,
    int pageSize = 50,
  }) async {
    const fields = [
      'ct.entry',
      'ct.name',
      'ct.subname',
      'ct.minlevel',
      'ct.maxlevel',
      'ctl.Name',
      'ctl.Title'
    ];
    final clauses = [
      'SELECT ${fields.join(', ')}',
      'FROM creature_template AS ct',
      'LEFT JOIN creature_template_locale AS ctl',
      'ON ct.entry = ctl.entry AND ctl.locale = "zhCN"',
      'LIMIT $pageSize',
      'OFFSET ${(page - 1) * pageSize}',
    ];
    final sql = clauses.join(' ');
    final result = await execute(sql);
    return result.rows.map(_getBriefCreatureTemplate).toList();
  }

  BriefCreatureTemplate _getBriefCreatureTemplate(ResultSetRow row) {
    final entry = row.typedColAt<int>(0) ?? 0;
    final rawName = row.typedColAt<String>(1) ?? '';
    final rawSubName = row.typedColAt<String>(2) ?? '';
    final minLevel = row.typedColAt<int>(3) ?? 0;
    final maxLevel = row.typedColAt<int>(4) ?? 0;
    final localeName = row.typedColAt<String>(5) ?? '';
    final localeSubName = row.typedColAt<String>(6) ?? '';
    final name = localeName.isNotEmpty ? localeName : rawName;
    final subName = localeSubName.isNotEmpty ? localeSubName : rawSubName;
    return BriefCreatureTemplate()
      ..entry = entry
      ..name = name
      ..subName = subName
      ..minLevel = minLevel
      ..maxLevel = maxLevel;
  }

  Future<int> count() async {
    const clause = [
      'SELECT count(*)',
      'FROM creature_template',
    ];
    final sql = clause.join(' ');
    var result = await execute(sql);
    return result.rows.first.typedColAt<int>(0) ?? 0;
  }
}
