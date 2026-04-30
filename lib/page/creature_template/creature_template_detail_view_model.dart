import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureTemplateDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final subNameController = TextEditingController();
  final iconNameController = TextEditingController();
  final minLevelController = TextEditingController();
  final maxLevelController = TextEditingController();
  final unitClassController = ShadSelectController<int>();
  final rankController = ShadSelectController<int>();
  final racialLeaderController = ShadSelectController<int>();
  final factionController = TextEditingController();
  final familyController = ShadSelectController<int>();
  final typeController = ShadSelectController<int>();
  final regenerateHealthController = ShadSelectController<int>();
  final petSpellDataIdController = TextEditingController();
  final vehicleIdController = TextEditingController();
  final gossipMenuIdController = TextEditingController();

  final npcFlagController = TextEditingController();
  final typeFlagController = TextEditingController();
  final dynamicFlagController = TextEditingController();
  final extraFlagController = TextEditingController();
  final unitFlagController = TextEditingController();
  final unitFlag2Controller = TextEditingController();

  final creatureImmunitiesIdController = TextEditingController();

  final expController = ShadSelectController<int>();
  final damageSchoolController = ShadSelectController<int>();
  final damageModifierController = TextEditingController();
  final armorModifierController = TextEditingController();
  final baseAttackTimeController = TextEditingController();
  final baseVarianceController = TextEditingController();
  final rangeAttackTimeController = TextEditingController();
  final rangeVarianceController = TextEditingController();
  final healthModifierController = TextEditingController();
  final manaModifierController = TextEditingController();
  final experienceModifierController = TextEditingController();
  final speedWalkController = TextEditingController();
  final speedRunController = TextEditingController();
  final speedSwimController = TextEditingController();
  final speedFlightController = TextEditingController();

  final minGoldController = TextEditingController();
  final maxGoldController = TextEditingController();
  final lootController = TextEditingController();
  final pickpocketLootController = TextEditingController();
  final skinLootController = TextEditingController();

  final killCredit1Controller = TextEditingController();
  final killCredit2Controller = TextEditingController();
  final difficultyEntry1Controller = TextEditingController();
  final difficultyEntry2Controller = TextEditingController();
  final difficultyEntry3Controller = TextEditingController();

  final movementIdController = TextEditingController();
  final movementTypeController = ShadSelectController<int>();
  final hoverHeightController = TextEditingController();
  final detectionRangeController = TextEditingController();

  final aiNameController = TextEditingController();
  final scriptNameController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  final entry = signal(0);
  final template = signal(CreatureTemplateEntity());
  final saving = signal(false);

  /// 保存模板到数据库
  Future<void> save(BuildContext context) async {
    saving.value = true;
    try {
      final t = _collectFromControllers();
      final repository = CreatureTemplateRepository();
      final isNew = t.entry == 0;
      if (isNew) {
        await repository.storeCreatureTemplate(t);
      } else {
        await repository.updateCreatureTemplate(t);
      }
      template.value = t;
      _logActivity(
        isNew ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('模板数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    } finally {
      saving.value = false;
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 CreatureTemplate
  CreatureTemplateEntity _collectFromControllers() {
    return CreatureTemplateEntity(
      entry: _parseInt(entryController.text),
      name: nameController.text,
      subName: subNameController.text,
      iconName: iconNameController.text,
      minLevel: _parseInt(minLevelController.text),
      maxLevel: _parseInt(maxLevelController.text),
      unitClass: _getSelectValue(unitClassController),
      rank: _getSelectValue(rankController),
      racialLeader: _getSelectValue(racialLeaderController),
      faction: _parseInt(factionController.text),
      family: _getSelectValue(familyController),
      type: _getSelectValue(typeController),
      regenHealth: _getSelectValue(regenerateHealthController),
      petSpellDataId: _parseInt(petSpellDataIdController.text),
      vehicleId: _parseInt(vehicleIdController.text),
      gossipMenuId: _parseInt(gossipMenuIdController.text),
      npcFlag: _parseInt(npcFlagController.text),
      typeFlags: _parseInt(typeFlagController.text),
      dynamicFlags: _parseInt(dynamicFlagController.text),
      flagsExtra: _parseInt(extraFlagController.text),
      unitFlags: _parseInt(unitFlagController.text),
      unitFlags2: _parseInt(unitFlag2Controller.text),
      creatureImmunitiesId: _parseInt(creatureImmunitiesIdController.text),
      exp: _getSelectValue(expController),
      damageSchool: _getSelectValue(damageSchoolController),
      damageModifier: _parseDouble(damageModifierController.text),
      armorModifier: _parseDouble(armorModifierController.text),
      baseAttackTime: _parseInt(baseAttackTimeController.text),
      baseVariance: _parseDouble(baseVarianceController.text),
      rangeAttackTime: _parseInt(rangeAttackTimeController.text),
      rangeVariance: _parseDouble(rangeVarianceController.text),
      healthModifier: _parseDouble(healthModifierController.text),
      manaModifier: _parseDouble(manaModifierController.text),
      experienceModifier: _parseDouble(experienceModifierController.text),
      speedWalk: _parseDouble(speedWalkController.text),
      speedRun: _parseDouble(speedRunController.text),
      speedSwim: _parseDouble(speedSwimController.text),
      speedFlight: _parseDouble(speedFlightController.text),
      minGold: _parseInt(minGoldController.text),
      maxGold: _parseInt(maxGoldController.text),
      lootId: _parseInt(lootController.text),
      pickpocketLoot: _parseInt(pickpocketLootController.text),
      skinLoot: _parseInt(skinLootController.text),
      killCredit1: _parseInt(killCredit1Controller.text),
      killCredit2: _parseInt(killCredit2Controller.text),
      difficultyEntry1: _parseInt(difficultyEntry1Controller.text),
      difficultyEntry2: _parseInt(difficultyEntry2Controller.text),
      difficultyEntry3: _parseInt(difficultyEntry3Controller.text),
      movementId: _parseInt(movementIdController.text),
      movementType: _getSelectValue(movementTypeController),
      hoverHeight: _parseDouble(hoverHeightController.text),
      detectionRange: _parseDouble(detectionRangeController.text),
      aiName: aiNameController.text,
      scriptName: scriptNameController.text,
      verifiedBuild: _parseInt(verifiedBuildController.text),
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  double _parseDouble(String text) {
    if (text.isEmpty) return 0.0;
    final value = double.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  int _getSelectValue(ShadSelectController<int> controller) =>
      controller.value.firstOrNull ?? 0;

  void dispose() {
    entryController.dispose();
    nameController.dispose();
    subNameController.dispose();
    iconNameController.dispose();
    minLevelController.dispose();
    maxLevelController.dispose();
    unitClassController.dispose();
    rankController.dispose();
    racialLeaderController.dispose();
    factionController.dispose();
    familyController.dispose();
    typeController.dispose();
    regenerateHealthController.dispose();
    petSpellDataIdController.dispose();
    vehicleIdController.dispose();
    gossipMenuIdController.dispose();

    npcFlagController.dispose();
    typeFlagController.dispose();
    dynamicFlagController.dispose();
    extraFlagController.dispose();
    unitFlagController.dispose();
    unitFlag2Controller.dispose();

    creatureImmunitiesIdController.dispose();

    expController.dispose();
    damageSchoolController.dispose();
    damageModifierController.dispose();
    armorModifierController.dispose();
    baseAttackTimeController.dispose();
    baseVarianceController.dispose();
    rangeAttackTimeController.dispose();
    rangeVarianceController.dispose();
    healthModifierController.dispose();
    manaModifierController.dispose();
    experienceModifierController.dispose();
    speedWalkController.dispose();
    speedRunController.dispose();
    speedSwimController.dispose();
    speedFlightController.dispose();

    minGoldController.dispose();
    maxGoldController.dispose();
    lootController.dispose();
    pickpocketLootController.dispose();
    skinLootController.dispose();

    killCredit1Controller.dispose();
    killCredit2Controller.dispose();
    difficultyEntry1Controller.dispose();
    difficultyEntry2Controller.dispose();
    difficultyEntry3Controller.dispose();

    movementIdController.dispose();
    movementTypeController.dispose();
    hoverHeightController.dispose();
    detectionRangeController.dispose();

    aiNameController.dispose();
    scriptNameController.dispose();
    verifiedBuildController.dispose();
  }

  Future<void> initSignals({int? entry}) async {
    if (entry == null) return;
    try {
      template.value = await CreatureTemplateRepository().getCreatureTemplate(
        entry,
      );
      _initControllers(template.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载生物模板(entry=$entry)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(CreatureTemplateEntity template) {
    entryController.text = template.entry.toString();
    nameController.text = template.name;
    subNameController.text = template.subName;
    iconNameController.text = template.iconName;
    minLevelController.text = template.minLevel.toString();
    maxLevelController.text = template.maxLevel.toString();
    unitClassController.value = {template.unitClass};
    rankController.value = {template.rank};
    racialLeaderController.value = {template.racialLeader};
    factionController.text = template.faction.toString();
    familyController.value = {template.family};
    typeController.value = {template.type};
    regenerateHealthController.value = {template.regenHealth};
    petSpellDataIdController.text = template.petSpellDataId.toString();
    vehicleIdController.text = template.vehicleId.toString();
    gossipMenuIdController.text = template.gossipMenuId.toString();

    npcFlagController.text = template.npcFlag.toString();
    typeFlagController.text = template.typeFlags.toString();
    dynamicFlagController.text = template.dynamicFlags.toString();
    extraFlagController.text = template.flagsExtra.toString();
    unitFlagController.text = template.unitFlags.toString();
    unitFlag2Controller.text = template.unitFlags2.toString();

    creatureImmunitiesIdController.text = template.creatureImmunitiesId
        .toString();

    expController.value = {template.exp};
    damageSchoolController.value = {template.damageSchool};
    damageModifierController.text = template.damageModifier.toString();
    armorModifierController.text = template.armorModifier.toString();
    baseAttackTimeController.text = template.baseAttackTime.toString();
    baseVarianceController.text = template.baseVariance.toString();
    rangeAttackTimeController.text = template.rangeAttackTime.toString();
    rangeVarianceController.text = template.rangeVariance.toString();
    healthModifierController.text = template.healthModifier.toString();
    manaModifierController.text = template.manaModifier.toString();
    experienceModifierController.text = template.experienceModifier.toString();
    speedWalkController.text = template.speedWalk.toString();
    speedRunController.text = template.speedRun.toString();
    speedSwimController.text = template.speedSwim.toString();
    speedFlightController.text = template.speedFlight.toString();

    minGoldController.text = template.minGold.toString();
    maxGoldController.text = template.maxGold.toString();
    lootController.text = template.lootId.toString();
    pickpocketLootController.text = template.pickpocketLoot.toString();
    skinLootController.text = template.skinLoot.toString();

    killCredit1Controller.text = template.killCredit1.toString();
    killCredit2Controller.text = template.killCredit2.toString();
    difficultyEntry1Controller.text = template.difficultyEntry1.toString();
    difficultyEntry2Controller.text = template.difficultyEntry2.toString();
    difficultyEntry3Controller.text = template.difficultyEntry3.toString();

    movementIdController.text = template.movementId.toString();
    movementTypeController.value = {template.movementType};
    hoverHeightController.text = template.hoverHeight.toString();
    detectionRangeController.text = template.detectionRange.toString();

    aiNameController.text = template.aiName;
    scriptNameController.text = template.scriptName;
    verifiedBuildController.text = template.verifiedBuild.toString();
  }

  void _logActivity(ActivityActionType action, CreatureTemplateEntity t) {
    final log = ActivityLogEntity(
      module: 'creature_template',
      actionType: action,
      entityId: t.entry,
      entityName: t.name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }
}
