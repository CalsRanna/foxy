import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/entity/quest_sort_filter_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class QuestSortListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final entryController = registerController(StringFieldController());
  late final nameController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<QuestSortRepository>();

  final page = signal(1);
  final sorts = signal(<BriefQuestSortEntity>[]);
  final total = signal(0);

  Future<void> copyQuestSort(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的任务排序？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyQuestSort(id);
      _logActivity(ActivityActionType.copy, id);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteQuestSort(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的任务排序？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyQuestSort(id);
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
      final filter = QuestSortFilterEntity();
      final (items, count) = await (
        _repository.getBriefQuestSorts(page: 1, filter: filter),
        _repository.countQuestSorts(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      sorts.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载任务排序列表失败: $e');
      DialogUtil.instance.error('加载任务排序列表失败: $e');
    }
  }

  void navigateToDetail({int? id, String? name}) {
    final label = name?.isNotEmpty == true ? name! : '新建任务排序';
    final routeId = id != null ? 'quest_sort_$id' : 'quest_sort_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: QuestSortDetailRoute(id: id, name: name),
      parentMenu: RouterMenu.questSort,
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

  QuestSortFilterEntity _buildFilter() {
    return QuestSortFilterEntity(
      id: entryController.collect(),
      name: nameController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, int id) {
    final sorts = this.sorts.value;
    final sort = sorts.where((s) => s.id == id).firstOrNull;
    final name = sort?.sortNameLangZhCN ?? '';
    final log = ActivityLogEntity(
      module: 'quest_sort',
      actionType: action,
      entityId: id,
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
        _repository.getBriefQuestSorts(page: page.value, filter: filter),
        _repository.countQuestSorts(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      sorts.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新任务排序列表失败: $e');
      DialogUtil.instance.error('刷新任务排序列表失败: $e');
    }
  }
}
