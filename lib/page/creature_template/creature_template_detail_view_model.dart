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
  final minLevel = signal<int>(0);
  final maxLevel = signal<int>(0);
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

  final creatureImmunitiesId = signal<int>(0);

  final expController = ShadSelectController<int>();
  final damageSchoolController = ShadSelectController<int>();
  final damageModifier = signal<double>(0.0);
  final armorModifier = signal<double>(0.0);
  final baseAttackTime = signal<int>(0);
  final baseVariance = signal<double>(0.0);
  final rangeAttackTime = signal<int>(0);
  final rangeVariance = signal<double>(0.0);
  final healthModifier = signal<double>(0.0);
  final manaModifier = signal<double>(0.0);
  final experienceModifier = signal<double>(0.0);
  final speedWalk = signal<double>(0.0);
  final speedRun = signal<double>(0.0);
  final speedSwim = signal<double>(0.0);
  final speedFlight = signal<double>(0.0);

  final minGold = signal<int>(0);
  final maxGold = signal<int>(0);
  final lootController = TextEditingController();
  final pickpocketLootController = TextEditingController();
  final skinLootController = TextEditingController();

  final killCredit1Controller = TextEditingController();
  final killCredit2Controller = TextEditingController();
  final difficultyEntry1Controller = TextEditingController();
  final difficultyEntry2Controller = TextEditingController();
  final difficultyEntry3Controller = TextEditingController();

  final movementId = signal<int>(0);
  final movementTypeController = ShadSelectController<int>();
  final hoverHeight = signal<double>(0.0);
  final detectionRange = signal<double>(0.0);

  final aiNameController = TextEditingController();
  final scriptNameController = TextEditingController();
  final verifiedBuild = signal<int>(0);

  final entry = signal(0);
  final template = signal(CreatureTemplateEntity());
  /// 保存模板到数据库
  Future<void> save(BuildContext context) async {
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
      minLevel: minLevel.value,
      maxLevel: maxLevel.value,
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
      creatureImmunitiesId: creatureImmunitiesId.value,
      exp: _getSelectValue(expController),
      damageSchool: _getSelectValue(damageSchoolController),
      damageModifier: damageModifier.value,
      armorModifier: armorModifier.value,
      baseAttackTime: baseAttackTime.value,
      baseVariance: baseVariance.value,
      rangeAttackTime: rangeAttackTime.value,
      rangeVariance: rangeVariance.value,
      healthModifier: healthModifier.value,
      manaModifier: manaModifier.value,
      experienceModifier: experienceModifier.value,
      speedWalk: speedWalk.value,
      speedRun: speedRun.value,
      speedSwim: speedSwim.value,
      speedFlight: speedFlight.value,
      minGold: minGold.value,
      maxGold: maxGold.value,
      lootId: _parseInt(lootController.text),
      pickpocketLoot: _parseInt(pickpocketLootController.text),
      skinLoot: _parseInt(skinLootController.text),
      killCredit1: _parseInt(killCredit1Controller.text),
      killCredit2: _parseInt(killCredit2Controller.text),
      difficultyEntry1: _parseInt(difficultyEntry1Controller.text),
      difficultyEntry2: _parseInt(difficultyEntry2Controller.text),
      difficultyEntry3: _parseInt(difficultyEntry3Controller.text),
      movementId: movementId.value,
      movementType: _getSelectValue(movementTypeController),
      hoverHeight: hoverHeight.value,
      detectionRange: detectionRange.value,
      aiName: aiNameController.text,
      scriptName: scriptNameController.text,
      verifiedBuild: verifiedBuild.value,
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
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

    expController.dispose();
    damageSchoolController.dispose();

    lootController.dispose();
    pickpocketLootController.dispose();
    skinLootController.dispose();

    killCredit1Controller.dispose();
    killCredit2Controller.dispose();
    difficultyEntry1Controller.dispose();
    difficultyEntry2Controller.dispose();
    difficultyEntry3Controller.dispose();

    movementTypeController.dispose();

    aiNameController.dispose();
    scriptNameController.dispose();
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
    minLevel.value = template.minLevel;
    maxLevel.value = template.maxLevel;
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

    creatureImmunitiesId.value = template.creatureImmunitiesId;

    expController.value = {template.exp};
    damageSchoolController.value = {template.damageSchool};
    damageModifier.value = template.damageModifier;
    armorModifier.value = template.armorModifier;
    baseAttackTime.value = template.baseAttackTime;
    baseVariance.value = template.baseVariance;
    rangeAttackTime.value = template.rangeAttackTime;
    rangeVariance.value = template.rangeVariance;
    healthModifier.value = template.healthModifier;
    manaModifier.value = template.manaModifier;
    experienceModifier.value = template.experienceModifier;
    speedWalk.value = template.speedWalk;
    speedRun.value = template.speedRun;
    speedSwim.value = template.speedSwim;
    speedFlight.value = template.speedFlight;

    minGold.value = template.minGold;
    maxGold.value = template.maxGold;
    lootController.text = template.lootId.toString();
    pickpocketLootController.text = template.pickpocketLoot.toString();
    skinLootController.text = template.skinLoot.toString();

    killCredit1Controller.text = template.killCredit1.toString();
    killCredit2Controller.text = template.killCredit2.toString();
    difficultyEntry1Controller.text = template.difficultyEntry1.toString();
    difficultyEntry2Controller.text = template.difficultyEntry2.toString();
    difficultyEntry3Controller.text = template.difficultyEntry3.toString();

    movementId.value = template.movementId;
    movementTypeController.value = {template.movementType};
    hoverHeight.value = template.hoverHeight;
    detectionRange.value = template.detectionRange;

    aiNameController.text = template.aiName;
    scriptNameController.text = template.scriptName;
    verifiedBuild.value = template.verifiedBuild;
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
