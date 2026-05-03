import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/currency_type_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CurrencyTypeDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final id = signal<int>(0);
  final itemId = signal<int>(0);
  final categoryId = signal<int>(0);
  final bitIndex = signal<int>(0);

  final currencyType = signal(CurrencyTypeEntity());

  /// 保存到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = CurrencyTypeRepository();
      if (t.id == 0) {
        await repository.storeCurrencyType(t);
      } else {
        await repository.updateCurrencyType(t);
      }
      currencyType.value = t;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
        t,
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

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 CurrencyType
  CurrencyTypeEntity _collectFromControllers() {
    return CurrencyTypeEntity(
      id: id.value,
      itemId: itemId.value,
      categoryId: categoryId.value,
      bitIndex: bitIndex.value,
    );
  }

  void _logActivity(ActivityActionType action, CurrencyTypeEntity t) {
    final log = ActivityLogEntity(
      module: 'currency_type',
      actionType: action,
      entityId: t.id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {}

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      currencyType.value =
          (await CurrencyTypeRepository().getCurrencyType(id))!;
      _initControllers(currencyType.value);
    } catch (e, s) {
      LoggerUtil.instance.e('加载货币(id=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(CurrencyTypeEntity currencyType) {
    id.value = currencyType.id;
    itemId.value = currencyType.itemId;
    categoryId.value = currencyType.categoryId;
    bitIndex.value = currencyType.bitIndex;
  }
}
