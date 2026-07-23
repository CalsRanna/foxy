import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/gem_property_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/gem_property_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class GemPropertyDetailViewModel
    with
        ViewModelValidationMixin,
        GemPropertyValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<GemPropertyRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<GemPropertyEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  /// Basic
  late final idController = registerController(IntFieldController());

  /// Property
  late final enchantIdController = registerController(IntFieldController());
  late final maxCountInvController = registerController(IntFieldController());
  late final maxCountItemController = registerController(IntFieldController());
  late final typeController = registerController(IntFieldController());

  /// 从所有 Controller 收集数据构建 GemProperty

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createGemProperty();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getGemProperty(key);
      if (result == null) {
        throw StateError('原宝石属性不存在，可能已被其他操作修改或删除');
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
      validateGemPropertyFields(candidate);
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeGemProperty(candidate);
      } else {
        await _repository.updateGemProperty(originalKey, candidate);
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

  GemPropertyEntity _collectCandidate() {
    return GemPropertyEntity(
      id: idController.collect(),
      enchantId: enchantIdController.collect(),
      maxCountInv: maxCountInvController.collect(),
      maxCountItem: maxCountItemController.collect(),
      type: typeController.collect(),
    );
  }

  void _applyCandidate(GemPropertyEntity gemProperty) {
    idController.init(gemProperty.id);
    enchantIdController.init(gemProperty.enchantId);
    maxCountInvController.init(gemProperty.maxCountInv);
    maxCountItemController.init(gemProperty.maxCountItem);
    typeController.init(gemProperty.type);
  }

  void _logActivity(ActivityActionType action, GemPropertyEntity t) {
    final log = ActivityLogEntity(
      module: 'gem_property',
      actionType: action,
      entityName: 'GemProperty ${t.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
