import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/entity/currency_type_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/currency_type_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/currency_type_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CurrencyTypeDetailViewModel
    with
        ViewModelValidationMixin,
        CurrencyTypeValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<CurrencyTypeRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  late final idController = registerController(IntFieldController());
  late final itemIdController = registerController(IntFieldController());
  late final categoryIdController = registerController(IntFieldController());
  late final bitIndexController = registerController(IntFieldController());

  final currencyType = signal(CurrencyTypeEntity());
  final persistedKey = signal<CurrencyTypeKey?>(null);

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({CurrencyTypeKey? key}) async {
    try {
      if (key == null) {
        persistedKey.value = null;
        final blank = await _repository.createCurrencyType();
        currencyType.value = blank;
        _initControllers(blank);
        return;
      }
      persistedKey.value = key;
      final entity = await _repository.getCurrencyType(key);
      if (entity == null) {
        throw StateError('原货币不存在，可能已被其他操作修改或删除');
      }
      currencyType.value = entity;
      _initControllers(entity);
    } catch (e, s) {
      LoggerUtil.instance.e('加载货币(key=$key)失败', error: e, stackTrace: s);
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  Future<void> persist() async {
    final candidate = _collectFromControllers();
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
    persistedKey.value = CurrencyTypeKey.fromEntity(candidate);
    currencyType.value = candidate;
    routerFacade.updateCurrentLabel('货币 #${candidate.id}');
    _logActivity(action, candidate);
  }

  Future<void> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('货币数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  /// 从所有 Controller 收集数据构建 CurrencyType
  CurrencyTypeEntity _collectFromControllers() {
    return CurrencyTypeEntity(
      id: idController.collect(),
      itemId: itemIdController.collect(),
      categoryId: categoryIdController.collect(),
      bitIndex: bitIndexController.collect(),
    );
  }

  void _initControllers(CurrencyTypeEntity currencyType) {
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }
}
