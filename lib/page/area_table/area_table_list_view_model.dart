import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/area_table_filter_entity.dart';
import 'package:foxy/entity/area_table_key.dart';
import 'package:foxy/entity/brief_area_table_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class AreaTableListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final entryController = registerController(StringFieldController());
  late final nameController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<AreaTableRepository>();

  final page = signal(1);
  final areas = signal(<BriefAreaTableEntity>[]);
  final total = signal(0);

  Future<void> copyAreaTable(AreaTableKey key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 ${key.id} 的区域？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyAreaTable(key);
      _logActivity(ActivityActionType.copy, key);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteAreaTable(AreaTableKey key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 ${key.id} 的区域？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyAreaTable(key);
      _logActivity(ActivityActionType.delete, key);
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
        _repository.getBriefAreaTables(),
        _repository.countAreaTables(),
      ).wait;
      if (token != _refreshToken) return;
      areas.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载区域表列表失败: $e');
      DialogUtil.instance.error('加载区域表列表失败: $e');
    }
  }

  void navigateToDetail({AreaTableKey? key, String? name}) {
    final label = name?.isNotEmpty == true ? name! : '新建区域';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      label: label,
      route: AreaTableDetailRoute(areaTableKey: key),
      parentMenu: RouterMenu.areaTable,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.init('');
    nameController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  AreaTableFilterEntity _buildFilter() {
    return AreaTableFilterEntity(
      id: entryController.collect(),
      name: nameController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, AreaTableKey key) {
    final areas = this.areas.value;
    final area = areas.where((a) => a.key == key).firstOrNull;
    final name = area?.areaNameLangZhCN ?? '';
    final log = ActivityLogEntity(
      module: 'area_table',
      actionType: action,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final filter = _buildFilter();
      final (items, count) = await (
        _repository.getBriefAreaTables(page: page.value, filter: filter),
        _repository.countAreaTables(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      areas.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新区域表列表失败: $e');
      DialogUtil.instance.error('刷新区域表列表失败: $e');
    }
  }
}
