import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureTemplateDetailViewModel {
  final _repository = GetIt.instance.get<CreatureTemplateRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final entryField = IntFieldController('编号');
  final nameField = TextFieldController('姓名');
  final subNameField = TextFieldController('称号');
  final iconNameField = TextFieldController('图标');
  final minLevelField = IntFieldController('最低等级');
  final maxLevelField = IntFieldController('最高等级');
  final unitClassField = SelectFieldController<int>('职业', fallback: 0);
  final rankField = SelectFieldController<int>('级别', fallback: 0);
  final racialLeaderField = SelectFieldController<int>('种族领袖', fallback: 0);
  final factionField = IntFieldController('阵营');
  final familyField = SelectFieldController<int>('宠物类别', fallback: 0);
  final typeField = SelectFieldController<int>('类型', fallback: 0);
  final regenerateHealthField = SelectFieldController<int>('生命回复', fallback: 0);
  final petSpellDataIdField = IntFieldController('宠物法术数据');
  final vehicleIdField = IntFieldController('载具');
  final gossipMenuIdField = IntFieldController('对话菜单');

  final npcFlagField = FlagFieldController('NPC 标记');
  final typeFlagField = FlagFieldController('类型标记');
  final dynamicFlagField = FlagFieldController('动态标记');
  final extraFlagField = FlagFieldController('额外标记');
  final unitFlagField = FlagFieldController('单位标记');
  final unitFlag2Field = FlagFieldController('单位标记2');

  final creatureImmunitiesIdField = IntFieldController('免疫组');

  final expField = SelectFieldController<int>('经验', fallback: 0);
  final damageSchoolField = SelectFieldController<int>('伤害类型', fallback: 0);
  final damageModifierField = DoubleFieldController('伤害系数');
  final armorModifierField = DoubleFieldController('护甲系数');
  final baseAttackTimeField = IntFieldController('近战攻击间隔');
  final baseVarianceField = DoubleFieldController('近战攻击浮动');
  final rangeAttackTimeField = IntFieldController('远程攻击间隔');
  final rangeVarianceField = DoubleFieldController('远程攻击浮动');
  final healthModifierField = DoubleFieldController('生命系数');
  final manaModifierField = DoubleFieldController('法力系数');
  final experienceModifierField = DoubleFieldController('经验系数');
  final speedWalkField = DoubleFieldController('行走速度');
  final speedRunField = DoubleFieldController('奔跑速度');
  final speedSwimField = DoubleFieldController('游泳速度');
  final speedFlightField = DoubleFieldController('飞行速度');

  final minGoldField = IntFieldController('最少金钱');
  final maxGoldField = IntFieldController('最多金钱');
  final lootIdField = IntFieldController('战利品');
  final pickpocketLootField = IntFieldController('偷窃战利品');
  final skinLootField = IntFieldController('剥皮战利品');

  final killCredit1Field = IntFieldController('击杀积分1');
  final killCredit2Field = IntFieldController('击杀积分2');
  final difficultyEntry1Field = IntFieldController('难度编号1');
  final difficultyEntry2Field = IntFieldController('难度编号2');
  final difficultyEntry3Field = IntFieldController('难度编号3');
  final aiNameField = TextFieldController('AI 名称');
  final scriptNameField = TextFieldController('脚本名称');

  final movementIdField = IntFieldController('移动模板');
  final movementTypeField = SelectFieldController<int>('移动类型', fallback: 0);
  final hoverHeightField = DoubleFieldController('悬浮高度');
  final detectionRangeField = DoubleFieldController('侦测范围');

  final verifiedBuildField = IntFieldController('验证版本');

  late final _fields = <FieldController>[
    entryField,
    nameField,
    subNameField,
    iconNameField,
    minLevelField,
    maxLevelField,
    unitClassField,
    rankField,
    racialLeaderField,
    factionField,
    familyField,
    typeField,
    regenerateHealthField,
    petSpellDataIdField,
    vehicleIdField,
    gossipMenuIdField,
    npcFlagField,
    typeFlagField,
    dynamicFlagField,
    extraFlagField,
    unitFlagField,
    unitFlag2Field,
    creatureImmunitiesIdField,
    expField,
    damageSchoolField,
    damageModifierField,
    armorModifierField,
    baseAttackTimeField,
    baseVarianceField,
    rangeAttackTimeField,
    rangeVarianceField,
    healthModifierField,
    manaModifierField,
    experienceModifierField,
    speedWalkField,
    speedRunField,
    speedSwimField,
    speedFlightField,
    minGoldField,
    maxGoldField,
    lootIdField,
    pickpocketLootField,
    skinLootField,
    killCredit1Field,
    killCredit2Field,
    difficultyEntry1Field,
    difficultyEntry2Field,
    difficultyEntry3Field,
    aiNameField,
    scriptNameField,
    movementIdField,
    movementTypeField,
    hoverHeightField,
    detectionRangeField,
    verifiedBuildField,
  ];

  final entry = signal(0);
  final template = signal(CreatureTemplateEntity());

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      // 不能用 entry==0 判断新建：create* 已预填 MAX+1
      final existed = await _repository.getCreatureTemplate(t.entry);
      if (existed == null) {
        final id = await _repository.storeCreatureTemplate(t);
        entryField.init(id);
        template.value = t.copyWith(entry: id);
        entry.value = id;
        _logActivity(ActivityActionType.create, template.value);
      } else {
        await _repository.updateCreatureTemplate(t);
        template.value = t;
        _logActivity(ActivityActionType.update, t);
      }
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('模板数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有字段收集数据构建 CreatureTemplate
  CreatureTemplateEntity _collectFromControllers() {
    return CreatureTemplateEntity(
      entry: entryField.collect(),
      name: nameField.collect(),
      subName: subNameField.collect(),
      iconName: iconNameField.collect(),
      minLevel: minLevelField.collect(),
      maxLevel: maxLevelField.collect(),
      unitClass: unitClassField.collect(),
      rank: rankField.collect(),
      racialLeader: racialLeaderField.collect(),
      faction: factionField.collect(),
      family: familyField.collect(),
      type: typeField.collect(),
      regenHealth: regenerateHealthField.collect(),
      petSpellDataId: petSpellDataIdField.collect(),
      vehicleId: vehicleIdField.collect(),
      gossipMenuId: gossipMenuIdField.collect(),
      npcFlag: npcFlagField.collect(),
      typeFlags: typeFlagField.collect(),
      dynamicFlags: dynamicFlagField.collect(),
      flagsExtra: extraFlagField.collect(),
      unitFlags: unitFlagField.collect(),
      unitFlags2: unitFlag2Field.collect(),
      creatureImmunitiesId: creatureImmunitiesIdField.collect(),
      exp: expField.collect(),
      damageSchool: damageSchoolField.collect(),
      damageModifier: damageModifierField.collect(),
      armorModifier: armorModifierField.collect(),
      baseAttackTime: baseAttackTimeField.collect(),
      baseVariance: baseVarianceField.collect(),
      rangeAttackTime: rangeAttackTimeField.collect(),
      rangeVariance: rangeVarianceField.collect(),
      healthModifier: healthModifierField.collect(),
      manaModifier: manaModifierField.collect(),
      experienceModifier: experienceModifierField.collect(),
      speedWalk: speedWalkField.collect(),
      speedRun: speedRunField.collect(),
      speedSwim: speedSwimField.collect(),
      speedFlight: speedFlightField.collect(),
      minGold: minGoldField.collect(),
      maxGold: maxGoldField.collect(),
      lootId: lootIdField.collect(),
      pickpocketLoot: pickpocketLootField.collect(),
      skinLoot: skinLootField.collect(),
      killCredit1: killCredit1Field.collect(),
      killCredit2: killCredit2Field.collect(),
      difficultyEntry1: difficultyEntry1Field.collect(),
      difficultyEntry2: difficultyEntry2Field.collect(),
      difficultyEntry3: difficultyEntry3Field.collect(),
      movementId: movementIdField.collect(),
      movementType: movementTypeField.collect(),
      hoverHeight: hoverHeightField.collect(),
      detectionRange: detectionRangeField.collect(),
      aiName: aiNameField.collect(),
      scriptName: scriptNameField.collect(),
      verifiedBuild: verifiedBuildField.collect(),
    );
  }

  void dispose() {
    for (final field in _fields) {
      field.dispose();
    }
  }

  Future<void> initSignals({int? entry}) async {
    try {
      // 路由/页面常把 null 落成 0，一律视为新建
      if (entry == null || entry <= 0) {
        final blank = await _repository.createCreatureTemplate();
        template.value = blank;
        this.entry.value = blank.entry;
        _initControllers(blank);
        return;
      }
      final result = await _repository.getCreatureTemplate(entry);
      if (result == null) return;
      template.value = result;
      this.entry.value = result.entry;
      _initControllers(result);
    } catch (e, s) {
      LoggerUtil.instance.e('加载生物模板(entry=$entry)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(CreatureTemplateEntity template) {
    entryField.init(template.entry);
    nameField.init(template.name);
    subNameField.init(template.subName);
    iconNameField.init(template.iconName);
    minLevelField.init(template.minLevel);
    maxLevelField.init(template.maxLevel);
    unitClassField.init(template.unitClass);
    rankField.init(template.rank);
    racialLeaderField.init(template.racialLeader);
    factionField.init(template.faction);
    familyField.init(template.family);
    typeField.init(template.type);
    regenerateHealthField.init(template.regenHealth);
    petSpellDataIdField.init(template.petSpellDataId);
    vehicleIdField.init(template.vehicleId);
    gossipMenuIdField.init(template.gossipMenuId);

    npcFlagField.init(template.npcFlag);
    typeFlagField.init(template.typeFlags);
    dynamicFlagField.init(template.dynamicFlags);
    extraFlagField.init(template.flagsExtra);
    unitFlagField.init(template.unitFlags);
    unitFlag2Field.init(template.unitFlags2);

    creatureImmunitiesIdField.init(template.creatureImmunitiesId);

    expField.init(template.exp);
    damageSchoolField.init(template.damageSchool);
    damageModifierField.init(template.damageModifier);
    armorModifierField.init(template.armorModifier);
    baseAttackTimeField.init(template.baseAttackTime);
    baseVarianceField.init(template.baseVariance);
    rangeAttackTimeField.init(template.rangeAttackTime);
    rangeVarianceField.init(template.rangeVariance);
    healthModifierField.init(template.healthModifier);
    manaModifierField.init(template.manaModifier);
    experienceModifierField.init(template.experienceModifier);
    speedWalkField.init(template.speedWalk);
    speedRunField.init(template.speedRun);
    speedSwimField.init(template.speedSwim);
    speedFlightField.init(template.speedFlight);

    minGoldField.init(template.minGold);
    maxGoldField.init(template.maxGold);
    lootIdField.init(template.lootId);
    pickpocketLootField.init(template.pickpocketLoot);
    skinLootField.init(template.skinLoot);

    killCredit1Field.init(template.killCredit1);
    killCredit2Field.init(template.killCredit2);
    difficultyEntry1Field.init(template.difficultyEntry1);
    difficultyEntry2Field.init(template.difficultyEntry2);
    difficultyEntry3Field.init(template.difficultyEntry3);

    movementIdField.init(template.movementId);
    movementTypeField.init(template.movementType);
    hoverHeightField.init(template.hoverHeight);
    detectionRangeField.init(template.detectionRange);

    aiNameField.init(template.aiName);
    scriptNameField.init(template.scriptName);
    verifiedBuildField.init(template.verifiedBuild);
  }

  void _logActivity(ActivityActionType action, CreatureTemplateEntity t) {
    final log = ActivityLogEntity(
      module: 'creature_template',
      actionType: action,
      entityId: t.entry,
      entityName: t.name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }
}
