import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log.dart';
import 'package:foxy/entity/quest_sort.dart';
import 'package:foxy/entity/quest_sort_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class QuestSortListViewModel {
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final repository = QuestSortRepository();

  final page = signal(1);
  final sorts = signal(<QuestSort>[]);
  final total = signal(0);

  Future<void> copyQuestSort(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的任务排序？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyQuestSort(id);
      _logActivity(ActivityActionType.copy, id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
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
      DialogUtil.instance.loading();
      await repository.destroyQuestSort(id);
      _logActivity(ActivityActionType.delete, id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void _logActivity(ActivityActionType action, int id) {
    final sorts = this.sorts.value;
    final sort = sorts.where((s) => s.id == id).firstOrNull;
    final name = sort?.sortNameLangZhCn ?? '';
    final log = ActivityLog(
      module: 'quest_sort',
      actionType: action,
      entityId: id,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    entryController.dispose();
    nameController.dispose();
  }

  Future<void> initSignals() async {
    final filter = QuestSortFilterEntity();
    sorts.value = await repository.getQuestSorts(page: 1, filter: filter);
    total.value = await repository.countQuestSorts(filter: filter);
  }

  void navigateToDetail({int? id, String? name}) {
    final label = name?.isNotEmpty == true ? name! : '新建任务排序';
    final routeId = id != null ? 'quest_sort_$id' : 'quest_sort_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: QuestSortDetailRoute(id: id),
      parentMenu: RouterMenu.questSort,
    );
  }

  QuestSortFilterEntity _buildFilter() {
    return QuestSortFilterEntity(
      id: entryController.text,
      name: nameController.text,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.clear();
    nameController.clear();
    page.value = 1;
    final filter = QuestSortFilterEntity();
    sorts.value = await repository.getQuestSorts(page: 1, filter: filter);
    total.value = await repository.countQuestSorts(filter: filter);
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    final filter = _buildFilter();
    sorts.value = await repository.getQuestSorts(
      page: page.value,
      filter: filter,
    );
    total.value = await repository.countQuestSorts(filter: filter);
  }
}
