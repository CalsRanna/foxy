import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/currency_type_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class CurrencyTypeDetailViewModel {
  final _repository = GetIt.instance.get<CurrencyTypeRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final idController = TextEditingController();
  final itemIdController = TextEditingController();
  final categoryIdController = TextEditingController();
  final bitIndexController = TextEditingController();

  final currencyType = signal(CurrencyTypeEntity());

  /// 保存到数据库
  String _fmt(num v) => formatNum(v);

  int _pi(String t, [String field = '']) => parseIntField(t, field: field);

  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final existed = await _repository.getCurrencyType(t.id);
      if (existed == null) {
        final id = await _repository.storeCurrencyType(t);
        idController.text = '$id';
      } else {
        await _repository.updateCurrencyType(t);
      }
      final isCreate = existed == null;
      currencyType.value = isCreate ? t.copyWith(id: int.tryParse(idController.text) ?? t.id) : t;
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

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  /// 从所有 Controller 收集数据构建 CurrencyType
  CurrencyTypeEntity _collectFromControllers() {
    return CurrencyTypeEntity(
      id: _pi(idController.text),
      itemId: _pi(itemIdController.text),
      categoryId: _pi(categoryIdController.text),
      bitIndex: _pi(bitIndexController.text),
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    bitIndexController.dispose();
    categoryIdController.dispose();
    idController.dispose();
    itemIdController.dispose();
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

  void _initControllers(CurrencyTypeEntity currencyType) {
    idController.text = _fmt(currencyType.id);
    itemIdController.text = _fmt(currencyType.itemId);
    categoryIdController.text = _fmt(currencyType.categoryId);
    bitIndexController.text = _fmt(currencyType.bitIndex);
  }
}
