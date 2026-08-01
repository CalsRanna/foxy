import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'item_template_detail_view_model.g.dart';

@FoxyDetailViewModel(entity: ItemTemplateEntity, flags: {'allowableClass', 'allowableRace', 'bagFamily', 'flags', 'flagsCustom', 'flagsExtra', 'scalingStatValue', 'socketColor1', 'socketColor2', 'socketColor3'}, selects: {'ammoType': 0, 'bonding': 0, 'className': 0, 'dmgType1': 0, 'dmgType2': 0, 'foodType': 0, 'inventoryType': 0, 'languageId': 0, 'material': 0, 'pageMaterial': 0, 'quality': 0, 'requiredReputationRank': 0, 'sheath': 0, 'spellTrigger1': 0, 'spellTrigger2': 0, 'spellTrigger3': 0, 'spellTrigger4': 0, 'spellTrigger5': 0, 'statType1': 0, 'statType10': 0, 'statType2': 0, 'statType3': 0, 'statType4': 0, 'statType5': 0, 'statType6': 0, 'statType7': 0, 'statType8': 0, 'statType9': 0, 'subclass': 0})
class ItemTemplateDetailViewModel
    with
        FieldControllerMixin, _ItemTemplateDetailViewModelMixin {
  final _repository = GetIt.instance.get<ItemTemplateRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  /// Signals
  final entity = signal<ItemTemplateEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  bool get hasDisenchantLoot => (entity.value?.disenchantId ?? 0) != 0;

  /// Computed conditions
  bool get hasEnchantment =>
      (entity.value?.randomProperty ?? 0) != 0 ||
      (entity.value?.randomSuffix ?? 0) != 0;

  bool get hasItemLoot => ((entity.value?.flags ?? 0) & 4) != 0;

  bool get hasMillingLoot => ((entity.value?.flags ?? 0) & 536870912) != 0;

  bool get hasProspectingLoot => ((entity.value?.flags ?? 0) & 262144) != 0;

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createItemTemplate();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getItemTemplate(key);
      if (result == null) {
        throw StateError('原物品模板不存在，可能已被其他操作修改或删除');
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
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeItemTemplate(candidate);
      } else {
        await _repository.updateItemTemplate(originalKey, candidate);
      }
      persistedKey.value = candidate.entry;
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _logActivity(ActivityActionType action, ItemTemplateEntity t) {
    final log = ActivityLogEntity(
      module: 'item_template',
      actionType: action,
      entityName: t.name,
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
