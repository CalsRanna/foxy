import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy/entity/item_set_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/item_set_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ItemSetListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final entryController = registerController(StringFieldController());
  late final nameController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<ItemSetRepository>();

  final page = signal(1);
  final itemSets = signal(<BriefItemSetEntity>[]);
  final total = signal(0);

  Future<void> copyItemSet(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的套装？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyItemSet(id);
      _logActivity(ActivityActionType.copy, id);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteItemSet(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的套装？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyItemSet(id);
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
        _repository.getBriefItemSets(),
        _repository.countItemSets(),
      ).wait;
      if (token != _refreshToken) return;
      itemSets.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载套装列表失败: $e');
      DialogUtil.instance.error('加载套装列表失败: $e');
    }
  }

  void navigateToDetail({int? id}) {
    final label = id != null ? '套装 #$id' : '新建套装';
    final routeId = id != null ? 'item_set_$id' : 'item_set_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: ItemSetDetailRoute(id: id),
      parentMenu: RouterMenu.itemSet,
    );
  }

  ItemSetFilterEntity _buildFilter() {
    return ItemSetFilterEntity(
      id: entryController.collect(),
      name: nameController.collect(),
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

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final filter = _buildFilter();
      final (items, count) = await (
        _repository.getBriefItemSets(page: page.value, filter: filter),
        _repository.countItemSets(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      itemSets.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新套装列表失败: $e');
      DialogUtil.instance.error('刷新套装列表失败: $e');
    }
  }

  void _logActivity(ActivityActionType action, int id) {
    final log = ActivityLogEntity(
      module: 'item_set',
      actionType: action,
      entityId: id,
      entityName: id.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }
}
