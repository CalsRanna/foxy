import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CreatureTemplateDetailViewModel {
  final _repository = GetIt.instance.get<CreatureTemplateRepository>();
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
  final lootIdController = TextEditingController();
  final pickpocketLootController = TextEditingController();
  final skinLootController = TextEditingController();

  final killCredit1Controller = TextEditingController();
  final killCredit2Controller = TextEditingController();
  final difficultyEntry1Controller = TextEditingController();
  final difficultyEntry2Controller = TextEditingController();
  final difficultyEntry3Controller = TextEditingController();
  final aiNameController = TextEditingController();
  final scriptNameController = TextEditingController();

  final movementIdController = TextEditingController();
  final movementTypeController = ShadSelectController<int>();
  final hoverHeightController = TextEditingController();
  final detectionRangeController = TextEditingController();

  final verifiedBuildController = TextEditingController();

  final entry = signal(0);
  final template = signal(CreatureTemplateEntity());

  /// 保存模板到数据库
  String _fmt(num v) => formatNum(v);

  int _pi(String t, [String field = '']) => parseIntField(t, field: field);
  double _pd(String t, [String field = '']) =>
      parseDoubleField(t, field: field);

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      // 不能用 entry==0 判断新建：create* 已预填 MAX+1
      final existed = await _repository.getCreatureTemplate(t.entry);
      if (existed == null) {
        final id = await _repository.storeCreatureTemplate(t);
        entryController.text = '$id';
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

  /// 从所有 Controller 收集数据构建 CreatureTemplate
  CreatureTemplateEntity _collectFromControllers() {
    return CreatureTemplateEntity(
      entry: _parseInt(entryController.text),
      name: nameController.text,
      subName: subNameController.text,
      iconName: iconNameController.text,
      minLevel: _pi(minLevelController.text),
      maxLevel: _pi(maxLevelController.text),
      unitClass: _getSelectValue(unitClassController),
      rank: _getSelectValue(rankController),
      racialLeader: _getSelectValue(racialLeaderController),
      faction: _pi(factionController.text),
      family: _getSelectValue(familyController),
      type: _getSelectValue(typeController),
      regenHealth: _getSelectValue(regenerateHealthController),
      petSpellDataId: _pi(petSpellDataIdController.text),
      vehicleId: _pi(vehicleIdController.text),
      gossipMenuId: _pi(gossipMenuIdController.text),
      npcFlag: parseFlagValue(npcFlagController.text),
      typeFlags: parseFlagValue(typeFlagController.text),
      dynamicFlags: parseFlagValue(dynamicFlagController.text),
      flagsExtra: parseFlagValue(extraFlagController.text),
      unitFlags: parseFlagValue(unitFlagController.text),
      unitFlags2: parseFlagValue(unitFlag2Controller.text),
      creatureImmunitiesId: _pi(creatureImmunitiesIdController.text),
      exp: _getSelectValue(expController),
      damageSchool: _getSelectValue(damageSchoolController),
      damageModifier: _pd(damageModifierController.text),
      armorModifier: _pd(armorModifierController.text),
      baseAttackTime: _pi(baseAttackTimeController.text),
      baseVariance: _pd(baseVarianceController.text),
      rangeAttackTime: _pi(rangeAttackTimeController.text),
      rangeVariance: _pd(rangeVarianceController.text),
      healthModifier: _pd(healthModifierController.text),
      manaModifier: _pd(manaModifierController.text),
      experienceModifier: _pd(experienceModifierController.text),
      speedWalk: _pd(speedWalkController.text),
      speedRun: _pd(speedRunController.text),
      speedSwim: _pd(speedSwimController.text),
      speedFlight: _pd(speedFlightController.text),
      minGold: _pi(minGoldController.text),
      maxGold: _pi(maxGoldController.text),
      lootId: _pi(lootIdController.text),
      pickpocketLoot: _pi(pickpocketLootController.text),
      skinLoot: _pi(skinLootController.text),
      killCredit1: _pi(killCredit1Controller.text),
      killCredit2: _pi(killCredit2Controller.text),
      difficultyEntry1: _pi(difficultyEntry1Controller.text),
      difficultyEntry2: _pi(difficultyEntry2Controller.text),
      difficultyEntry3: _pi(difficultyEntry3Controller.text),
      movementId: _pi(movementIdController.text),
      movementType: _getSelectValue(movementTypeController),
      hoverHeight: _pd(hoverHeightController.text),
      detectionRange: _pd(detectionRangeController.text),
      aiName: aiNameController.text,
      scriptName: scriptNameController.text,
      verifiedBuild: _pi(verifiedBuildController.text),
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
    aiNameController.dispose();
    armorModifierController.dispose();
    baseAttackTimeController.dispose();
    baseVarianceController.dispose();
    creatureImmunitiesIdController.dispose();
    damageModifierController.dispose();
    damageSchoolController.dispose();
    detectionRangeController.dispose();
    difficultyEntry1Controller.dispose();
    difficultyEntry2Controller.dispose();
    difficultyEntry3Controller.dispose();
    dynamicFlagController.dispose();
    entryController.dispose();
    expController.dispose();
    experienceModifierController.dispose();
    extraFlagController.dispose();
    lootIdController.dispose();
    pickpocketLootController.dispose();
    skinLootController.dispose();
    factionController.dispose();
    familyController.dispose();
    gossipMenuIdController.dispose();
    healthModifierController.dispose();
    hoverHeightController.dispose();
    iconNameController.dispose();
    killCredit1Controller.dispose();
    killCredit2Controller.dispose();
    manaModifierController.dispose();
    maxGoldController.dispose();
    maxLevelController.dispose();
    minGoldController.dispose();
    minLevelController.dispose();
    movementIdController.dispose();
    movementTypeController.dispose();
    nameController.dispose();
    npcFlagController.dispose();
    petSpellDataIdController.dispose();
    racialLeaderController.dispose();
    rangeAttackTimeController.dispose();
    rangeVarianceController.dispose();
    rankController.dispose();
    regenerateHealthController.dispose();
    scriptNameController.dispose();
    speedFlightController.dispose();
    speedRunController.dispose();
    speedSwimController.dispose();
    speedWalkController.dispose();
    subNameController.dispose();
    typeController.dispose();
    typeFlagController.dispose();
    unitClassController.dispose();
    unitFlagController.dispose();
    unitFlag2Controller.dispose();
    vehicleIdController.dispose();
    verifiedBuildController.dispose();
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
    entryController.text = template.entry.toString();
    nameController.text = template.name;
    subNameController.text = template.subName;
    iconNameController.text = template.iconName;
    minLevelController.text = _fmt(template.minLevel);
    maxLevelController.text = _fmt(template.maxLevel);
    unitClassController.value = {template.unitClass};
    rankController.value = {template.rank};
    racialLeaderController.value = {template.racialLeader};
    factionController.text = _fmt(template.faction);
    familyController.value = {template.family};
    typeController.value = {template.type};
    regenerateHealthController.value = {template.regenHealth};
    petSpellDataIdController.text = _fmt(template.petSpellDataId);
    vehicleIdController.text = _fmt(template.vehicleId);
    gossipMenuIdController.text = _fmt(template.gossipMenuId);

    npcFlagController.text = formatFlagValue(template.npcFlag);
    typeFlagController.text = formatFlagValue(template.typeFlags);
    dynamicFlagController.text = formatFlagValue(template.dynamicFlags);
    extraFlagController.text = formatFlagValue(template.flagsExtra);
    unitFlagController.text = formatFlagValue(template.unitFlags);
    unitFlag2Controller.text = formatFlagValue(template.unitFlags2);

    creatureImmunitiesIdController.text = _fmt(template.creatureImmunitiesId);

    expController.value = {template.exp};
    damageSchoolController.value = {template.damageSchool};
    damageModifierController.text = _fmt(template.damageModifier);
    armorModifierController.text = _fmt(template.armorModifier);
    baseAttackTimeController.text = _fmt(template.baseAttackTime);
    baseVarianceController.text = _fmt(template.baseVariance);
    rangeAttackTimeController.text = _fmt(template.rangeAttackTime);
    rangeVarianceController.text = _fmt(template.rangeVariance);
    healthModifierController.text = _fmt(template.healthModifier);
    manaModifierController.text = _fmt(template.manaModifier);
    experienceModifierController.text = _fmt(template.experienceModifier);
    speedWalkController.text = _fmt(template.speedWalk);
    speedRunController.text = _fmt(template.speedRun);
    speedSwimController.text = _fmt(template.speedSwim);
    speedFlightController.text = _fmt(template.speedFlight);

    minGoldController.text = _fmt(template.minGold);
    maxGoldController.text = _fmt(template.maxGold);
    lootIdController.text = _fmt(template.lootId);
    pickpocketLootController.text = _fmt(template.pickpocketLoot);
    skinLootController.text = _fmt(template.skinLoot);

    killCredit1Controller.text = _fmt(template.killCredit1);
    killCredit2Controller.text = _fmt(template.killCredit2);
    difficultyEntry1Controller.text = _fmt(template.difficultyEntry1);
    difficultyEntry2Controller.text = _fmt(template.difficultyEntry2);
    difficultyEntry3Controller.text = _fmt(template.difficultyEntry3);

    movementIdController.text = _fmt(template.movementId);
    movementTypeController.value = {template.movementType};
    hoverHeightController.text = _fmt(template.hoverHeight);
    detectionRangeController.text = _fmt(template.detectionRange);

    aiNameController.text = template.aiName;
    scriptNameController.text = template.scriptName;
    verifiedBuildController.text = _fmt(template.verifiedBuild);
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
