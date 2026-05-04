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
  final faction = signal<int>(0);
  final familyController = ShadSelectController<int>();
  final typeController = ShadSelectController<int>();
  final regenerateHealthController = ShadSelectController<int>();
  final petSpellDataId = signal<int>(0);
  final vehicleId = signal<int>(0);
  final gossipMenuId = signal<int>(0);

  final npcFlag = signal<int>(0);
  final typeFlag = signal<int>(0);
  final dynamicFlag = signal<int>(0);
  final extraFlag = signal<int>(0);
  final unitFlag = signal<int>(0);
  final unitFlag2 = signal<int>(0);

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
  final lootId = signal<int>(0);
  final pickpocketLoot = signal<int>(0);
  final skinLoot = signal<int>(0);

  final killCredit1 = signal<int>(0);
  final killCredit2 = signal<int>(0);
  final difficultyEntry1 = signal<int>(0);
  final difficultyEntry2 = signal<int>(0);
  final difficultyEntry3 = signal<int>(0);
  final aiNameController = TextEditingController();
  final scriptNameController = TextEditingController();

  final movementId = signal<int>(0);
  final movementTypeController = ShadSelectController<int>();
  final hoverHeight = signal<double>(0.0);
  final detectionRange = signal<double>(0.0);

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
      faction: faction.value,
      family: _getSelectValue(familyController),
      type: _getSelectValue(typeController),
      regenHealth: _getSelectValue(regenerateHealthController),
      petSpellDataId: petSpellDataId.value,
      vehicleId: vehicleId.value,
      gossipMenuId: gossipMenuId.value,
      npcFlag: npcFlag.value,
      typeFlags: typeFlag.value,
      dynamicFlags: dynamicFlag.value,
      flagsExtra: extraFlag.value,
      unitFlags: unitFlag.value,
      unitFlags2: unitFlag2.value,
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
      lootId: lootId.value,
      pickpocketLoot: pickpocketLoot.value,
      skinLoot: skinLoot.value,
      killCredit1: killCredit1.value,
      killCredit2: killCredit2.value,
      difficultyEntry1: difficultyEntry1.value,
      difficultyEntry2: difficultyEntry2.value,
      difficultyEntry3: difficultyEntry3.value,
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
    familyController.dispose();
    typeController.dispose();
    regenerateHealthController.dispose();

    expController.dispose();
    damageSchoolController.dispose();

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
    faction.value = template.faction;
    familyController.value = {template.family};
    typeController.value = {template.type};
    regenerateHealthController.value = {template.regenHealth};
    petSpellDataId.value = template.petSpellDataId;
    vehicleId.value = template.vehicleId;
    gossipMenuId.value = template.gossipMenuId;

    npcFlag.value = template.npcFlag;
    typeFlag.value = template.typeFlags;
    dynamicFlag.value = template.dynamicFlags;
    extraFlag.value = template.flagsExtra;
    unitFlag.value = template.unitFlags;
    unitFlag2.value = template.unitFlags2;

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
    lootId.value = template.lootId;
    pickpocketLoot.value = template.pickpocketLoot;
    skinLoot.value = template.skinLoot;

    killCredit1.value = template.killCredit1;
    killCredit2.value = template.killCredit2;
    difficultyEntry1.value = template.difficultyEntry1;
    difficultyEntry2.value = template.difficultyEntry2;
    difficultyEntry3.value = template.difficultyEntry3;

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
