import 'package:flutter/widgets.dart';
import 'package:foxy/model/quest_sort.dart';
import 'package:foxy/model/quest_sort_filter_entity.dart';
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
  final items = signal(<QuestSort>[]);
  final total = signal(0);
  final selectedRowIndex = signal(-1);

  Future<void> copyQuestSort(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的任务排序？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copy(id);
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
      await repository.destroy(id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    entryController.dispose();
    nameController.dispose();
  }

  Future<void> initSignals() async {
    final filter = QuestSortFilterEntity();
    items.value = await repository.search(page: 1, filter: filter);
    total.value = await repository.count(filter: filter);
  }

  void navigateToDetail(BuildContext context, {int? id, String? name}) {
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
    return QuestSortFilterEntity()
      ..id = entryController.text
      ..name = nameController.text;
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
    items.value = await repository.search(page: 1, filter: filter);
    total.value = await repository.count(filter: filter);
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    final filter = _buildFilter();
    items.value = await repository.search(page: page.value, filter: filter);
    total.value = await repository.count(filter: filter);
  }
}
