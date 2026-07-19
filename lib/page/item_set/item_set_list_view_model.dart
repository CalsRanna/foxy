import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/brief_item_set_entity.dart';
import 'package:foxy/entity/item_set_filter_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/item_set_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
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

  Future<void> copyItemSet(int key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $key 的套装？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyItemSet(key);
      _logActivity(ActivityActionType.copy, key);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteItemSet(int key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $key 的套装？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyItemSet(key);
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

  void navigateToDetail({int? key}) {
    final label = key != null ? '套装 #$key' : '新建套装';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      label: label,
      route: ItemSetDetailRoute(itemSetKey: key),
      parentMenu: RouterMenu.itemSet,
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

  ItemSetFilterEntity _buildFilter() {
    return ItemSetFilterEntity(
      id: entryController.collect(),
      name: nameController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, int key) {
    final log = ActivityLogEntity(
      module: 'item_set',
      actionType: action,
      entityName: 'ItemSet $key',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
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
}
