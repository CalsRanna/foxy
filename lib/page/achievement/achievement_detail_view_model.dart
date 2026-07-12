import 'package:flutter/widgets.dart';
import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class AchievementDetailViewModel {
  final _repository = GetIt.instance.get<AchievementRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  /// Basic
  final idController = IntFieldController();
  final factionController = IntFieldController();
  final instanceIdController = IntFieldController();
  final supercedesController = IntFieldController();

  /// Title languages
  final titleLangEnUSController = StringFieldController();
  final titleLangKoKRController = StringFieldController();
  final titleLangFrFRController = StringFieldController();
  final titleLangDeDEController = StringFieldController();
  final titleLangZhCNController = StringFieldController();
  final titleLangZhTWController = StringFieldController();
  final titleLangEsESController = StringFieldController();
  final titleLangEsMXController = StringFieldController();
  final titleLangRuRUController = StringFieldController();
  final titleLangJaJPController = StringFieldController();
  final titleLangPtPTController = StringFieldController();
  final titleLangPtBRController = StringFieldController();
  final titleLangItITController = StringFieldController();
  final titleLangUnk1Controller = StringFieldController();
  final titleLangUnk2Controller = StringFieldController();
  final titleLangUnk3Controller = StringFieldController();
  final titleLangFlags = signal<int>(0);

  /// Description languages
  final descriptionLangEnUSController = StringFieldController();
  final descriptionLangKoKRController = StringFieldController();
  final descriptionLangFrFRController = StringFieldController();
  final descriptionLangDeDEController = StringFieldController();
  final descriptionLangZhCNController = StringFieldController();
  final descriptionLangZhTWController = StringFieldController();
  final descriptionLangEsESController = StringFieldController();
  final descriptionLangEsMXController = StringFieldController();
  final descriptionLangRuRUController = StringFieldController();
  final descriptionLangJaJPController = StringFieldController();
  final descriptionLangPtPTController = StringFieldController();
  final descriptionLangPtBRController = StringFieldController();
  final descriptionLangItITController = StringFieldController();
  final descriptionLangUnk1Controller = StringFieldController();
  final descriptionLangUnk2Controller = StringFieldController();
  final descriptionLangUnk3Controller = StringFieldController();
  final descriptionLangFlags = signal<int>(0);

  /// Category / Points / UI / Flags / Icon
  final categoryController = IntFieldController();
  final pointsController = IntFieldController();
  final uiOrderController = IntFieldController();
  final flagsController = IntFieldController();
  final iconIdController = IntFieldController();

  /// Reward languages
  final rewardLangEnUSController = StringFieldController();
  final rewardLangKoKRController = StringFieldController();
  final rewardLangFrFRController = StringFieldController();
  final rewardLangDeDEController = StringFieldController();
  final rewardLangZhCNController = StringFieldController();
  final rewardLangZhTWController = StringFieldController();
  final rewardLangEsESController = StringFieldController();
  final rewardLangEsMXController = StringFieldController();
  final rewardLangRuRUController = StringFieldController();
  final rewardLangJaJPController = StringFieldController();
  final rewardLangPtPTController = StringFieldController();
  final rewardLangPtBRController = StringFieldController();
  final rewardLangItITController = StringFieldController();
  final rewardLangUnk1Controller = StringFieldController();
  final rewardLangUnk2Controller = StringFieldController();
  final rewardLangUnk3Controller = StringFieldController();
  final rewardLangFlags = signal<int>(0);

  /// Minimum / Shares
  final minimumCriteriaController = IntFieldController();
  final sharesCriteriaController = IntFieldController();

  late final _controllers = <FieldController>[
    idController,
    factionController,
    instanceIdController,
    supercedesController,
    titleLangEnUSController,
    titleLangKoKRController,
    titleLangFrFRController,
    titleLangDeDEController,
    titleLangZhCNController,
    titleLangZhTWController,
    titleLangEsESController,
    titleLangEsMXController,
    titleLangRuRUController,
    titleLangJaJPController,
    titleLangPtPTController,
    titleLangPtBRController,
    titleLangItITController,
    titleLangUnk1Controller,
    titleLangUnk2Controller,
    titleLangUnk3Controller,
    descriptionLangEnUSController,
    descriptionLangKoKRController,
    descriptionLangFrFRController,
    descriptionLangDeDEController,
    descriptionLangZhCNController,
    descriptionLangZhTWController,
    descriptionLangEsESController,
    descriptionLangEsMXController,
    descriptionLangRuRUController,
    descriptionLangJaJPController,
    descriptionLangPtPTController,
    descriptionLangPtBRController,
    descriptionLangItITController,
    descriptionLangUnk1Controller,
    descriptionLangUnk2Controller,
    descriptionLangUnk3Controller,
    categoryController,
    pointsController,
    uiOrderController,
    flagsController,
    iconIdController,
    rewardLangEnUSController,
    rewardLangKoKRController,
    rewardLangFrFRController,
    rewardLangDeDEController,
    rewardLangZhCNController,
    rewardLangZhTWController,
    rewardLangEsESController,
    rewardLangEsMXController,
    rewardLangRuRUController,
    rewardLangJaJPController,
    rewardLangPtPTController,
    rewardLangPtBRController,
    rewardLangItITController,
    rewardLangUnk1Controller,
    rewardLangUnk2Controller,
    rewardLangUnk3Controller,
    minimumCriteriaController,
    sharesCriteriaController,
  ];

  final achievement = signal(AchievementEntity());

  Future<void> save(BuildContext context) async {
    try {
      var t = _collectFromControllers();
      final isCreate = (await _repository.getAchievement(t.id)) == null;
      if (isCreate) {
        final id = await _repository.storeAchievement(t);
        t = t.copyWith(id: id);
        idController.init(id);
      } else {
        await _repository.updateAchievement(t);
      }
      achievement.value = t;
      _logActivity(
        isCreate ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('成就数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void applyTitleLocales(List<DbcLocaleFieldValue> values) {
    _applyLangControllers(
      values,
      enUS: titleLangEnUSController,
      koKR: titleLangKoKRController,
      frFR: titleLangFrFRController,
      deDE: titleLangDeDEController,
      zhCN: titleLangZhCNController,
      zhTW: titleLangZhTWController,
      esES: titleLangEsESController,
      esMX: titleLangEsMXController,
      ruRU: titleLangRuRUController,
      jaJP: titleLangJaJPController,
      ptPT: titleLangPtPTController,
      ptBR: titleLangPtBRController,
      itIT: titleLangItITController,
      unk1: titleLangUnk1Controller,
      unk2: titleLangUnk2Controller,
      unk3: titleLangUnk3Controller,
    );
    achievement.value = _collectFromControllers();
  }

  void applyDescriptionLocales(List<DbcLocaleFieldValue> values) {
    _applyLangControllers(
      values,
      enUS: descriptionLangEnUSController,
      koKR: descriptionLangKoKRController,
      frFR: descriptionLangFrFRController,
      deDE: descriptionLangDeDEController,
      zhCN: descriptionLangZhCNController,
      zhTW: descriptionLangZhTWController,
      esES: descriptionLangEsESController,
      esMX: descriptionLangEsMXController,
      ruRU: descriptionLangRuRUController,
      jaJP: descriptionLangJaJPController,
      ptPT: descriptionLangPtPTController,
      ptBR: descriptionLangPtBRController,
      itIT: descriptionLangItITController,
      unk1: descriptionLangUnk1Controller,
      unk2: descriptionLangUnk2Controller,
      unk3: descriptionLangUnk3Controller,
    );
    achievement.value = _collectFromControllers();
  }

  void applyRewardLocales(List<DbcLocaleFieldValue> values) {
    _applyLangControllers(
      values,
      enUS: rewardLangEnUSController,
      koKR: rewardLangKoKRController,
      frFR: rewardLangFrFRController,
      deDE: rewardLangDeDEController,
      zhCN: rewardLangZhCNController,
      zhTW: rewardLangZhTWController,
      esES: rewardLangEsESController,
      esMX: rewardLangEsMXController,
      ruRU: rewardLangRuRUController,
      jaJP: rewardLangJaJPController,
      ptPT: rewardLangPtPTController,
      ptBR: rewardLangPtBRController,
      itIT: rewardLangItITController,
      unk1: rewardLangUnk1Controller,
      unk2: rewardLangUnk2Controller,
      unk3: rewardLangUnk3Controller,
    );
    achievement.value = _collectFromControllers();
  }

  void _applyLangControllers(
    List<DbcLocaleFieldValue> values, {
    required StringFieldController enUS,
    required StringFieldController koKR,
    required StringFieldController frFR,
    required StringFieldController deDE,
    required StringFieldController zhCN,
    required StringFieldController zhTW,
    required StringFieldController esES,
    required StringFieldController esMX,
    required StringFieldController ruRU,
    required StringFieldController jaJP,
    required StringFieldController ptPT,
    required StringFieldController ptBR,
    required StringFieldController itIT,
    required StringFieldController unk1,
    required StringFieldController unk2,
    required StringFieldController unk3,
  }) {
    enUS.init(values.valueOf('enUS'));
    koKR.init(values.valueOf('koKR'));
    frFR.init(values.valueOf('frFR'));
    deDE.init(values.valueOf('deDE'));
    zhCN.init(values.valueOf('zhCN'));
    zhTW.init(values.valueOf('zhTW'));
    esES.init(values.valueOf('esES'));
    esMX.init(values.valueOf('esMX'));
    ruRU.init(values.valueOf('ruRU'));
    jaJP.init(values.valueOf('jaJP'));
    ptPT.init(values.valueOf('ptPT'));
    ptBR.init(values.valueOf('ptBR'));
    itIT.init(values.valueOf('itIT'));
    unk1.init(values.valueOf('unk1'));
    unk2.init(values.valueOf('unk2'));
    unk3.init(values.valueOf('unk3'));
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 AchievementEntity
  AchievementEntity _collectFromControllers() {
    return AchievementEntity(
      id: idController.collect(),
      faction: factionController.collect(),
      instanceId: instanceIdController.collect(),
      supercedes: supercedesController.collect(),
      titleLangEnUS: titleLangEnUSController.collect(),
      titleLangKoKR: titleLangKoKRController.collect(),
      titleLangFrFR: titleLangFrFRController.collect(),
      titleLangDeDE: titleLangDeDEController.collect(),
      titleLangZhCN: titleLangZhCNController.collect(),
      titleLangZhTW: titleLangZhTWController.collect(),
      titleLangEsES: titleLangEsESController.collect(),
      titleLangEsMX: titleLangEsMXController.collect(),
      titleLangRuRU: titleLangRuRUController.collect(),
      titleLangJaJP: titleLangJaJPController.collect(),
      titleLangPtPT: titleLangPtPTController.collect(),
      titleLangPtBR: titleLangPtBRController.collect(),
      titleLangItIT: titleLangItITController.collect(),
      titleLangUnk1: titleLangUnk1Controller.collect(),
      titleLangUnk2: titleLangUnk2Controller.collect(),
      titleLangUnk3: titleLangUnk3Controller.collect(),
      titleLangFlags: titleLangFlags.value,
      descriptionLangEnUS: descriptionLangEnUSController.collect(),
      descriptionLangKoKR: descriptionLangKoKRController.collect(),
      descriptionLangFrFR: descriptionLangFrFRController.collect(),
      descriptionLangDeDE: descriptionLangDeDEController.collect(),
      descriptionLangZhCN: descriptionLangZhCNController.collect(),
      descriptionLangZhTW: descriptionLangZhTWController.collect(),
      descriptionLangEsES: descriptionLangEsESController.collect(),
      descriptionLangEsMX: descriptionLangEsMXController.collect(),
      descriptionLangRuRU: descriptionLangRuRUController.collect(),
      descriptionLangJaJP: descriptionLangJaJPController.collect(),
      descriptionLangPtPT: descriptionLangPtPTController.collect(),
      descriptionLangPtBR: descriptionLangPtBRController.collect(),
      descriptionLangItIT: descriptionLangItITController.collect(),
      descriptionLangUnk1: descriptionLangUnk1Controller.collect(),
      descriptionLangUnk2: descriptionLangUnk2Controller.collect(),
      descriptionLangUnk3: descriptionLangUnk3Controller.collect(),
      descriptionLangFlags: descriptionLangFlags.value,
      category: categoryController.collect(),
      points: pointsController.collect(),
      uiOrder: uiOrderController.collect(),
      flags: flagsController.collect(),
      iconId: iconIdController.collect(),
      rewardLangEnUS: rewardLangEnUSController.collect(),
      rewardLangKoKR: rewardLangKoKRController.collect(),
      rewardLangFrFR: rewardLangFrFRController.collect(),
      rewardLangDeDE: rewardLangDeDEController.collect(),
      rewardLangZhCN: rewardLangZhCNController.collect(),
      rewardLangZhTW: rewardLangZhTWController.collect(),
      rewardLangEsES: rewardLangEsESController.collect(),
      rewardLangEsMX: rewardLangEsMXController.collect(),
      rewardLangRuRU: rewardLangRuRUController.collect(),
      rewardLangJaJP: rewardLangJaJPController.collect(),
      rewardLangPtPT: rewardLangPtPTController.collect(),
      rewardLangPtBR: rewardLangPtBRController.collect(),
      rewardLangItIT: rewardLangItITController.collect(),
      rewardLangUnk1: rewardLangUnk1Controller.collect(),
      rewardLangUnk2: rewardLangUnk2Controller.collect(),
      rewardLangUnk3: rewardLangUnk3Controller.collect(),
      rewardLangFlags: rewardLangFlags.value,
      minimumCriteria: minimumCriteriaController.collect(),
      sharesCriteria: sharesCriteriaController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, AchievementEntity t) {
    final log = ActivityLogEntity(
      module: 'achievement',
      actionType: action,
      entityId: t.id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
  }

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createAchievement();
        achievement.value = blank;
        _initControllers(blank);
        return;
      }
      achievement.value = (await _repository.getAchievement(id))!;
      _initControllers(achievement.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载成就(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(AchievementEntity achievement) {
    idController.init(achievement.id);
    factionController.init(achievement.faction);
    instanceIdController.init(achievement.instanceId);
    supercedesController.init(achievement.supercedes);
    titleLangEnUSController.init(achievement.titleLangEnUS);
    titleLangKoKRController.init(achievement.titleLangKoKR);
    titleLangFrFRController.init(achievement.titleLangFrFR);
    titleLangDeDEController.init(achievement.titleLangDeDE);
    titleLangZhCNController.init(achievement.titleLangZhCN);
    titleLangZhTWController.init(achievement.titleLangZhTW);
    titleLangEsESController.init(achievement.titleLangEsES);
    titleLangEsMXController.init(achievement.titleLangEsMX);
    titleLangRuRUController.init(achievement.titleLangRuRU);
    titleLangJaJPController.init(achievement.titleLangJaJP);
    titleLangPtPTController.init(achievement.titleLangPtPT);
    titleLangPtBRController.init(achievement.titleLangPtBR);
    titleLangItITController.init(achievement.titleLangItIT);
    titleLangUnk1Controller.init(achievement.titleLangUnk1);
    titleLangUnk2Controller.init(achievement.titleLangUnk2);
    titleLangUnk3Controller.init(achievement.titleLangUnk3);
    titleLangFlags.value = achievement.titleLangFlags;
    descriptionLangEnUSController.init(achievement.descriptionLangEnUS);
    descriptionLangKoKRController.init(achievement.descriptionLangKoKR);
    descriptionLangFrFRController.init(achievement.descriptionLangFrFR);
    descriptionLangDeDEController.init(achievement.descriptionLangDeDE);
    descriptionLangZhCNController.init(achievement.descriptionLangZhCN);
    descriptionLangZhTWController.init(achievement.descriptionLangZhTW);
    descriptionLangEsESController.init(achievement.descriptionLangEsES);
    descriptionLangEsMXController.init(achievement.descriptionLangEsMX);
    descriptionLangRuRUController.init(achievement.descriptionLangRuRU);
    descriptionLangJaJPController.init(achievement.descriptionLangJaJP);
    descriptionLangPtPTController.init(achievement.descriptionLangPtPT);
    descriptionLangPtBRController.init(achievement.descriptionLangPtBR);
    descriptionLangItITController.init(achievement.descriptionLangItIT);
    descriptionLangUnk1Controller.init(achievement.descriptionLangUnk1);
    descriptionLangUnk2Controller.init(achievement.descriptionLangUnk2);
    descriptionLangUnk3Controller.init(achievement.descriptionLangUnk3);
    descriptionLangFlags.value = achievement.descriptionLangFlags;
    categoryController.init(achievement.category);
    pointsController.init(achievement.points);
    uiOrderController.init(achievement.uiOrder);
    flagsController.init(achievement.flags);
    iconIdController.init(achievement.iconId);
    rewardLangEnUSController.init(achievement.rewardLangEnUS);
    rewardLangKoKRController.init(achievement.rewardLangKoKR);
    rewardLangFrFRController.init(achievement.rewardLangFrFR);
    rewardLangDeDEController.init(achievement.rewardLangDeDE);
    rewardLangZhCNController.init(achievement.rewardLangZhCN);
    rewardLangZhTWController.init(achievement.rewardLangZhTW);
    rewardLangEsESController.init(achievement.rewardLangEsES);
    rewardLangEsMXController.init(achievement.rewardLangEsMX);
    rewardLangRuRUController.init(achievement.rewardLangRuRU);
    rewardLangJaJPController.init(achievement.rewardLangJaJP);
    rewardLangPtPTController.init(achievement.rewardLangPtPT);
    rewardLangPtBRController.init(achievement.rewardLangPtBR);
    rewardLangItITController.init(achievement.rewardLangItIT);
    rewardLangUnk1Controller.init(achievement.rewardLangUnk1);
    rewardLangUnk2Controller.init(achievement.rewardLangUnk2);
    rewardLangUnk3Controller.init(achievement.rewardLangUnk3);
    rewardLangFlags.value = achievement.rewardLangFlags;
    minimumCriteriaController.init(achievement.minimumCriteria);
    sharesCriteriaController.init(achievement.sharesCriteria);
  }
}
