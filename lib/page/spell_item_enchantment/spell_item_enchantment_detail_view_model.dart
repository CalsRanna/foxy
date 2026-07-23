import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/spell_item_enchantment_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/spell_item_enchantment_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class SpellItemEnchantmentDetailViewModel
    with
        ViewModelValidationMixin,
        SpellItemEnchantmentValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<SpellItemEnchantmentRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<SpellItemEnchantmentEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  /// Basic
  late final idController = registerController(IntFieldController());
  late final nameController = registerController(StringFieldController());
  late final chargesController = registerController(IntFieldController());

  /// Effect
  late final effect0Controller = registerController(IntFieldController());
  late final effect1Controller = registerController(IntFieldController());
  late final effect2Controller = registerController(IntFieldController());

  /// EffectPointsMin
  late final effectPointsMin0Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsMin1Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsMin2Controller = registerController(
    IntFieldController(),
  );

  /// EffectPointsMax
  late final effectPointsMax0Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsMax1Controller = registerController(
    IntFieldController(),
  );
  late final effectPointsMax2Controller = registerController(
    IntFieldController(),
  );

  /// EffectArg
  late final effectArg0Controller = registerController(IntFieldController());
  late final effectArg1Controller = registerController(IntFieldController());
  late final effectArg2Controller = registerController(IntFieldController());

  /// Other
  late final itemVisualController = registerController(IntFieldController());
  late final flagsController = registerController(FlagFieldController());
  late final srcItemIdController = registerController(IntFieldController());
  late final conditionIdController = registerController(IntFieldController());
  late final requiredSkillIdController = registerController(
    IntFieldController(),
  );
  late final requiredSkillRankController = registerController(
    IntFieldController(),
  );
  late final minLevelController = registerController(IntFieldController());

  /// 从所有 Controller 收集数据构建 SpellItemEnchantment

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createSpellItemEnchantment();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getSpellItemEnchantment(key);
      if (result == null) {
        throw StateError('原法术附魔不存在，可能已被其他操作修改或删除');
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

  /// 退出页面
  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      validateSpellItemEnchantmentFields(candidate);
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeSpellItemEnchantment(candidate);
      } else {
        await _repository.updateSpellItemEnchantment(originalKey, candidate);
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

  void applyNameLocales(List<DbcLocaleFieldValue> values) {
    entity.value = entity.value!.copyWith(
      nameLangEnUS: values.valueOf('enUS'),
      nameLangKoKR: values.valueOf('koKR'),
      nameLangFrFR: values.valueOf('frFR'),
      nameLangDeDE: values.valueOf('deDE'),
      nameLangZhCN: values.valueOf('zhCN'),
      nameLangZhTW: values.valueOf('zhTW'),
      nameLangEsES: values.valueOf('esES'),
      nameLangEsMX: values.valueOf('esMX'),
      nameLangRuRU: values.valueOf('ruRU'),
      nameLangJaJP: values.valueOf('jaJP'),
      nameLangPtPT: values.valueOf('ptPT'),
      nameLangPtBR: values.valueOf('ptBR'),
      nameLangItIT: values.valueOf('itIT'),
      nameLangUnk1: values.valueOf('unk1'),
      nameLangUnk2: values.valueOf('unk2'),
      nameLangUnk3: values.valueOf('unk3'),
    );
    nameController.init(values.zhCN);
  }

  SpellItemEnchantmentEntity _collectCandidate() {
    // 基于已加载实体覆盖 UI 字段，避免清空未展示的多语言等列。
    return entity.value!.copyWith(
      id: idController.collect(),
      nameLangZhCN: nameController.collect(),
      charges: chargesController.collect(),
      effect0: effect0Controller.collect(),
      effect1: effect1Controller.collect(),
      effect2: effect2Controller.collect(),
      effectPointsMin0: effectPointsMin0Controller.collect(),
      effectPointsMin1: effectPointsMin1Controller.collect(),
      effectPointsMin2: effectPointsMin2Controller.collect(),
      effectPointsMax0: effectPointsMax0Controller.collect(),
      effectPointsMax1: effectPointsMax1Controller.collect(),
      effectPointsMax2: effectPointsMax2Controller.collect(),
      effectArg0: effectArg0Controller.collect(),
      effectArg1: effectArg1Controller.collect(),
      effectArg2: effectArg2Controller.collect(),
      itemVisual: itemVisualController.collect(),
      flags: flagsController.collect(),
      srcItemId: srcItemIdController.collect(),
      conditionId: conditionIdController.collect(),
      requiredSkillId: requiredSkillIdController.collect(),
      requiredSkillRank: requiredSkillRankController.collect(),
      minLevel: minLevelController.collect(),
    );
  }

  void _applyCandidate(SpellItemEnchantmentEntity entry) {
    idController.init(entry.id);
    nameController.init(entry.nameLangZhCN);
    chargesController.init(entry.charges);
    effect0Controller.init(entry.effect0);
    effect1Controller.init(entry.effect1);
    effect2Controller.init(entry.effect2);
    effectPointsMin0Controller.init(entry.effectPointsMin0);
    effectPointsMin1Controller.init(entry.effectPointsMin1);
    effectPointsMin2Controller.init(entry.effectPointsMin2);
    effectPointsMax0Controller.init(entry.effectPointsMax0);
    effectPointsMax1Controller.init(entry.effectPointsMax1);
    effectPointsMax2Controller.init(entry.effectPointsMax2);
    effectArg0Controller.init(entry.effectArg0);
    effectArg1Controller.init(entry.effectArg1);
    effectArg2Controller.init(entry.effectArg2);
    itemVisualController.init(entry.itemVisual);
    flagsController.init(entry.flags);
    srcItemIdController.init(entry.srcItemId);
    conditionIdController.init(entry.conditionId);
    requiredSkillIdController.init(entry.requiredSkillId);
    requiredSkillRankController.init(entry.requiredSkillRank);
    minLevelController.init(entry.minLevel);
  }

  void _logActivity(ActivityActionType action, SpellItemEnchantmentEntity t) {
    final log = ActivityLogEntity(
      module: 'spell_item_enchantment',
      actionType: action,
      entityName: t.nameLangZhCN,
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
