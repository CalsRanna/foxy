import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/currency_type_entity.dart';
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

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createCurrencyType();
        currencyType.value = blank;
        _initControllers(blank);
        return;
      }
      currencyType.value = (await _repository.getCurrencyType(id))!;
      _initControllers(currencyType.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载货币(id=$id)失败', error: e, stackTrace: s);
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      validateCurrencyTypeFields(t);
      final existed = await _repository.getCurrencyType(t.id);
      if (existed == null) {
        final id = await _repository.storeCurrencyType(t);
        idController.init(id);
      } else {
        await _repository.updateCurrencyType(t);
      }
      final isCreate = existed == null;
      currencyType.value = isCreate
          ? t.copyWith(id: idController.collect())
          : t;
      _logActivity(
        isCreate ? ActivityActionType.create : ActivityActionType.update,
        currencyType.value,
      );
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
