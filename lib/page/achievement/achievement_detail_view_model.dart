import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/achievement_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class AchievementDetailViewModel
    with
        ViewModelValidationMixin,
        AchievementValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<AchievementRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<AchievementEntity?>(null);
  final persistedKey = signal<int?>(null);
  final titleLangFlags = signal<int>(0);
  final descriptionLangFlags = signal<int>(0);
  final rewardLangFlags = signal<int>(0);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  /// Basic
  late final idController = registerController(IntFieldController());
  late final factionController = registerController(
    SelectFieldController<int>(fallback: -1),
  );
  late final instanceIdController = registerController(IntFieldController());
  late final supercedesController = registerController(IntFieldController());

  /// Title languages
  late final titleLangEnUSController = registerController(
    StringFieldController(),
  );
  late final titleLangKoKRController = registerController(
    StringFieldController(),
  );
  late final titleLangFrFRController = registerController(
    StringFieldController(),
  );
  late final titleLangDeDEController = registerController(
    StringFieldController(),
  );
  late final titleLangZhCNController = registerController(
    StringFieldController(),
  );
  late final titleLangZhTWController = registerController(
    StringFieldController(),
  );
  late final titleLangEsESController = registerController(
    StringFieldController(),
  );
  late final titleLangEsMXController = registerController(
    StringFieldController(),
  );
  late final titleLangRuRUController = registerController(
    StringFieldController(),
  );
  late final titleLangJaJPController = registerController(
    StringFieldController(),
  );
  late final titleLangPtPTController = registerController(
    StringFieldController(),
  );
  late final titleLangPtBRController = registerController(
    StringFieldController(),
  );
  late final titleLangItITController = registerController(
    StringFieldController(),
  );
  late final titleLangUnk1Controller = registerController(
    StringFieldController(),
  );
  late final titleLangUnk2Controller = registerController(
    StringFieldController(),
  );
  late final titleLangUnk3Controller = registerController(
    StringFieldController(),
  );

  /// Description languages
  late final descriptionLangEnUSController = registerController(
    StringFieldController(),
  );
  late final descriptionLangKoKRController = registerController(
    StringFieldController(),
  );
  late final descriptionLangFrFRController = registerController(
    StringFieldController(),
  );
  late final descriptionLangDeDEController = registerController(
    StringFieldController(),
  );
  late final descriptionLangZhCNController = registerController(
    StringFieldController(),
  );
  late final descriptionLangZhTWController = registerController(
    StringFieldController(),
  );
  late final descriptionLangEsESController = registerController(
    StringFieldController(),
  );
  late final descriptionLangEsMXController = registerController(
    StringFieldController(),
  );
  late final descriptionLangRuRUController = registerController(
    StringFieldController(),
  );
  late final descriptionLangJaJPController = registerController(
    StringFieldController(),
  );
  late final descriptionLangPtPTController = registerController(
    StringFieldController(),
  );
  late final descriptionLangPtBRController = registerController(
    StringFieldController(),
  );
  late final descriptionLangItITController = registerController(
    StringFieldController(),
  );
  late final descriptionLangUnk1Controller = registerController(
    StringFieldController(),
  );
  late final descriptionLangUnk2Controller = registerController(
    StringFieldController(),
  );
  late final descriptionLangUnk3Controller = registerController(
    StringFieldController(),
  );

  /// Category / Points / UI / Flags / Icon
  late final categoryController = registerController(IntFieldController());
  late final pointsController = registerController(IntFieldController());
  late final uiOrderController = registerController(IntFieldController());
  late final flagsController = registerController(FlagFieldController());
  late final iconIdController = registerController(IntFieldController());

  /// Reward languages
  late final rewardLangEnUSController = registerController(
    StringFieldController(),
  );
  late final rewardLangKoKRController = registerController(
    StringFieldController(),
  );
  late final rewardLangFrFRController = registerController(
    StringFieldController(),
  );
  late final rewardLangDeDEController = registerController(
    StringFieldController(),
  );
  late final rewardLangZhCNController = registerController(
    StringFieldController(),
  );
  late final rewardLangZhTWController = registerController(
    StringFieldController(),
  );
  late final rewardLangEsESController = registerController(
    StringFieldController(),
  );
  late final rewardLangEsMXController = registerController(
    StringFieldController(),
  );
  late final rewardLangRuRUController = registerController(
    StringFieldController(),
  );
  late final rewardLangJaJPController = registerController(
    StringFieldController(),
  );
  late final rewardLangPtPTController = registerController(
    StringFieldController(),
  );
  late final rewardLangPtBRController = registerController(
    StringFieldController(),
  );
  late final rewardLangItITController = registerController(
    StringFieldController(),
  );
  late final rewardLangUnk1Controller = registerController(
    StringFieldController(),
  );
  late final rewardLangUnk2Controller = registerController(
    StringFieldController(),
  );
  late final rewardLangUnk3Controller = registerController(
    StringFieldController(),
  );

  /// Minimum / Shares
  late final minimumCriteriaController = registerController(
    IntFieldController(),
  );
  late final sharesCriteriaController = registerController(
    IntFieldController(),
  );

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createAchievement();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getAchievement(key);
      if (result == null) {
        throw StateError('原成就不存在，可能已被其他操作修改或删除');
      }
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = error.toString();
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      validateAchievementFields(candidate);
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeAchievement(candidate);
      } else {
        await _repository.updateAchievement(originalKey, candidate);
      }
      persistedKey.value = candidate.id;
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
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
    entity.value = _collectCandidate();
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
    entity.value = _collectCandidate();
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
    entity.value = _collectCandidate();
  }

  AchievementEntity _collectCandidate() {
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

  void _applyCandidate(AchievementEntity achievement) {
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

  void _logActivity(ActivityActionType action, AchievementEntity t) {
    final log = ActivityLogEntity(
      module: 'achievement',
      actionType: action,
      entityName: t.titleLangZhCN,
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
