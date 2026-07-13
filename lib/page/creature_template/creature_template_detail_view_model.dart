import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureTemplateDetailViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<CreatureTemplateRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  late final entryController = registerController(IntFieldController());
  late final nameController = registerController(StringFieldController());
  late final subNameController = registerController(StringFieldController());
  late final iconNameController = registerController(StringFieldController());
  late final minLevelController = registerController(IntFieldController());
  late final maxLevelController = registerController(IntFieldController());
  late final unitClassController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final rankController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final racialLeaderController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final factionController = registerController(IntFieldController());
  late final familyController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final typeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final regenerateHealthController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final petSpellDataIdController = registerController(
    IntFieldController(),
  );
  late final vehicleIdController = registerController(IntFieldController());
  late final gossipMenuIdController = registerController(IntFieldController());

  late final npcFlagController = registerController(FlagFieldController());
  late final typeFlagController = registerController(FlagFieldController());
  late final dynamicFlagController = registerController(FlagFieldController());
  late final extraFlagController = registerController(FlagFieldController());
  late final unitFlagController = registerController(FlagFieldController());
  late final unitFlag2Controller = registerController(FlagFieldController());

  late final creatureImmunitiesIdController = registerController(
    IntFieldController(),
  );

  late final expController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final damageSchoolController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final damageModifierController = registerController(
    DoubleFieldController(),
  );
  late final armorModifierController = registerController(
    DoubleFieldController(),
  );
  late final baseAttackTimeController = registerController(
    IntFieldController(),
  );
  late final baseVarianceController = registerController(
    DoubleFieldController(),
  );
  late final rangeAttackTimeController = registerController(
    IntFieldController(),
  );
  late final rangeVarianceController = registerController(
    DoubleFieldController(),
  );
  late final healthModifierController = registerController(
    DoubleFieldController(),
  );
  late final manaModifierController = registerController(
    DoubleFieldController(),
  );
  late final experienceModifierController = registerController(
    DoubleFieldController(),
  );
  late final speedWalkController = registerController(DoubleFieldController());
  late final speedRunController = registerController(DoubleFieldController());
  late final speedSwimController = registerController(DoubleFieldController());
  late final speedFlightController = registerController(
    DoubleFieldController(),
  );

  late final minGoldController = registerController(IntFieldController());
  late final maxGoldController = registerController(IntFieldController());
  late final lootIdController = registerController(IntFieldController());
  late final pickpocketLootController = registerController(
    IntFieldController(),
  );
  late final skinLootController = registerController(IntFieldController());

  late final killCredit1Controller = registerController(IntFieldController());
  late final killCredit2Controller = registerController(IntFieldController());
  late final difficultyEntry1Controller = registerController(
    IntFieldController(),
  );
  late final difficultyEntry2Controller = registerController(
    IntFieldController(),
  );
  late final difficultyEntry3Controller = registerController(
    IntFieldController(),
  );
  late final aiNameController = registerController(StringFieldController());
  late final scriptNameController = registerController(StringFieldController());

  late final movementIdController = registerController(IntFieldController());
  late final movementTypeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final hoverHeightController = registerController(
    DoubleFieldController(),
  );
  late final detectionRangeController = registerController(
    DoubleFieldController(),
  );

  late final verifiedBuildController = registerController(IntFieldController());

  final entry = signal(0);
  final template = signal(CreatureTemplateEntity());

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      // 不能用 entry==0 判断新建：create* 已预填 MAX+1
      final existed = await _repository.getCreatureTemplate(t.entry);
      if (existed == null) {
        final id = await _repository.storeCreatureTemplate(t);
        entryController.init(id);
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
      entry: entryController.collect(),
      name: nameController.collect(),
      subName: subNameController.collect(),
      iconName: iconNameController.collect(),
      minLevel: minLevelController.collect(),
      maxLevel: maxLevelController.collect(),
      unitClass: unitClassController.collect(),
      rank: rankController.collect(),
      racialLeader: racialLeaderController.collect(),
      faction: factionController.collect(),
      family: familyController.collect(),
      type: typeController.collect(),
      regenHealth: regenerateHealthController.collect(),
      petSpellDataId: petSpellDataIdController.collect(),
      vehicleId: vehicleIdController.collect(),
      gossipMenuId: gossipMenuIdController.collect(),
      npcFlag: npcFlagController.collect(),
      typeFlags: typeFlagController.collect(),
      dynamicFlags: dynamicFlagController.collect(),
      flagsExtra: extraFlagController.collect(),
      unitFlags: unitFlagController.collect(),
      unitFlags2: unitFlag2Controller.collect(),
      creatureImmunitiesId: creatureImmunitiesIdController.collect(),
      exp: expController.collect(),
      damageSchool: damageSchoolController.collect(),
      damageModifier: damageModifierController.collect(),
      armorModifier: armorModifierController.collect(),
      baseAttackTime: baseAttackTimeController.collect(),
      baseVariance: baseVarianceController.collect(),
      rangeAttackTime: rangeAttackTimeController.collect(),
      rangeVariance: rangeVarianceController.collect(),
      healthModifier: healthModifierController.collect(),
      manaModifier: manaModifierController.collect(),
      experienceModifier: experienceModifierController.collect(),
      speedWalk: speedWalkController.collect(),
      speedRun: speedRunController.collect(),
      speedSwim: speedSwimController.collect(),
      speedFlight: speedFlightController.collect(),
      minGold: minGoldController.collect(),
      maxGold: maxGoldController.collect(),
      lootId: lootIdController.collect(),
      pickpocketLoot: pickpocketLootController.collect(),
      skinLoot: skinLootController.collect(),
      killCredit1: killCredit1Controller.collect(),
      killCredit2: killCredit2Controller.collect(),
      difficultyEntry1: difficultyEntry1Controller.collect(),
      difficultyEntry2: difficultyEntry2Controller.collect(),
      difficultyEntry3: difficultyEntry3Controller.collect(),
      movementId: movementIdController.collect(),
      movementType: movementTypeController.collect(),
      hoverHeight: hoverHeightController.collect(),
      detectionRange: detectionRangeController.collect(),
      aiName: aiNameController.collect(),
      scriptName: scriptNameController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  void dispose() {
    disposeControllers();
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
    entryController.init(template.entry);
    nameController.init(template.name);
    subNameController.init(template.subName);
    iconNameController.init(template.iconName);
    minLevelController.init(template.minLevel);
    maxLevelController.init(template.maxLevel);
    unitClassController.init(template.unitClass);
    rankController.init(template.rank);
    racialLeaderController.init(template.racialLeader);
    factionController.init(template.faction);
    familyController.init(template.family);
    typeController.init(template.type);
    regenerateHealthController.init(template.regenHealth);
    petSpellDataIdController.init(template.petSpellDataId);
    vehicleIdController.init(template.vehicleId);
    gossipMenuIdController.init(template.gossipMenuId);

    npcFlagController.init(template.npcFlag);
    typeFlagController.init(template.typeFlags);
    dynamicFlagController.init(template.dynamicFlags);
    extraFlagController.init(template.flagsExtra);
    unitFlagController.init(template.unitFlags);
    unitFlag2Controller.init(template.unitFlags2);

    creatureImmunitiesIdController.init(template.creatureImmunitiesId);

    expController.init(template.exp);
    damageSchoolController.init(template.damageSchool);
    damageModifierController.init(template.damageModifier);
    armorModifierController.init(template.armorModifier);
    baseAttackTimeController.init(template.baseAttackTime);
    baseVarianceController.init(template.baseVariance);
    rangeAttackTimeController.init(template.rangeAttackTime);
    rangeVarianceController.init(template.rangeVariance);
    healthModifierController.init(template.healthModifier);
    manaModifierController.init(template.manaModifier);
    experienceModifierController.init(template.experienceModifier);
    speedWalkController.init(template.speedWalk);
    speedRunController.init(template.speedRun);
    speedSwimController.init(template.speedSwim);
    speedFlightController.init(template.speedFlight);

    minGoldController.init(template.minGold);
    maxGoldController.init(template.maxGold);
    lootIdController.init(template.lootId);
    pickpocketLootController.init(template.pickpocketLoot);
    skinLootController.init(template.skinLoot);

    killCredit1Controller.init(template.killCredit1);
    killCredit2Controller.init(template.killCredit2);
    difficultyEntry1Controller.init(template.difficultyEntry1);
    difficultyEntry2Controller.init(template.difficultyEntry2);
    difficultyEntry3Controller.init(template.difficultyEntry3);

    movementIdController.init(template.movementId);
    movementTypeController.init(template.movementType);
    hoverHeightController.init(template.hoverHeight);
    detectionRangeController.init(template.detectionRange);

    aiNameController.init(template.aiName);
    scriptNameController.init(template.scriptName);
    verifiedBuildController.init(template.verifiedBuild);
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
