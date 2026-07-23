import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/currency_type_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/currency_type_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class CurrencyTypeDetailViewModel
    with
        ViewModelValidationMixin,
        CurrencyTypeValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<CurrencyTypeRepository>();
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  final entity = signal<CurrencyTypeEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final itemIdController = registerController(IntFieldController());
  late final categoryIdController = registerController(IntFieldController());
  late final bitIndexController = registerController(IntFieldController());

  /// 从所有 Controller 收集数据构建 CurrencyType

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createCurrencyType();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getCurrencyType(key);
      if (result == null) {
        throw StateError('原货币不存在，可能已被其他操作修改或删除');
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
      validateCurrencyTypeFields(candidate);
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeCurrencyType(candidate);
      } else {
        await _repository.updateCurrencyType(originalKey, candidate);
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

  CurrencyTypeEntity _collectCandidate() {
    return CurrencyTypeEntity(
      id: idController.collect(),
      itemId: itemIdController.collect(),
      categoryId: categoryIdController.collect(),
      bitIndex: bitIndexController.collect(),
    );
  }

  void _applyCandidate(CurrencyTypeEntity currencyType) {
    idController.init(currencyType.id);
    itemIdController.init(currencyType.itemId);
    categoryIdController.init(currencyType.categoryId);
    bitIndexController.init(currencyType.bitIndex);
  }

  void _logActivity(ActivityActionType action, CurrencyTypeEntity t) {
    final log = ActivityLogEntity(
      module: 'currency_type',
      actionType: action,
      entityName: 'CurrencyType ${t.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }

  void dispose() {
    disposeControllers();
  }
}
