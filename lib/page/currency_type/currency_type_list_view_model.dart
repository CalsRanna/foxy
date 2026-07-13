import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/entity/currency_type_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/currency_type_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class CurrencyTypeListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final entryController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<CurrencyTypeRepository>();

  final page = signal(1);
  final currencyTypes = signal(<BriefCurrencyTypeEntity>[]);
  final total = signal(0);

  Future<void> copyCurrencyType(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的货币？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyCurrencyType(id);
      _logActivity(ActivityActionType.copy, id);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteCurrencyType(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的货币？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyCurrencyType(id);
      _logActivity(ActivityActionType.delete, id);
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals() async {
    final token = ++_refreshToken;
    try {
      final (items, count) = await (
        _repository.getBriefCurrencyTypes(),
        _repository.countCurrencyTypes(),
      ).wait;
      if (token != _refreshToken) return;
      currencyTypes.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载货币列表失败: $e');
      DialogUtil.instance.error('加载货币列表失败: $e');
    }
  }

  void navigateToDetail({int? id}) {
    final label = id != null ? '货币 #$id' : '新建货币';
    final routeId = id != null ? 'currency_type_$id' : 'currency_type_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: CurrencyTypeDetailRoute(id: id),
      parentMenu: RouterMenu.currencyType,
    );
  }

  CurrencyTypeFilterEntity _buildFilter() {
    return CurrencyTypeFilterEntity(id: entryController.collect());
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final filter = _buildFilter();
      final (items, count) = await (
        _repository.getBriefCurrencyTypes(page: page.value, filter: filter),
        _repository.countCurrencyTypes(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      currencyTypes.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新货币列表失败: $e');
      DialogUtil.instance.error('刷新货币列表失败: $e');
    }
  }

  void _logActivity(ActivityActionType action, int id) {
    final log = ActivityLogEntity(
      module: 'currency_type',
      actionType: action,
      entityId: id,
      entityName: id.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }
}
