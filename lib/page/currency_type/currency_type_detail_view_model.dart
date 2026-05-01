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

  final idController = TextEditingController();
  final itemIdController = TextEditingController();
  final categoryIdController = TextEditingController();
  final bitIndexController = TextEditingController();

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
      id: _parseInt(idController.text),
      itemId: _parseInt(itemIdController.text),
      categoryId: _parseInt(categoryIdController.text),
      bitIndex: _parseInt(bitIndexController.text),
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
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

  void dispose() {
    idController.dispose();
    itemIdController.dispose();
    categoryIdController.dispose();
    bitIndexController.dispose();
  }

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
    idController.text = currencyType.id.toString();
    itemIdController.text = currencyType.itemId.toString();
    categoryIdController.text = currencyType.categoryId.toString();
    bitIndexController.text = currencyType.bitIndex.toString();
  }
}
