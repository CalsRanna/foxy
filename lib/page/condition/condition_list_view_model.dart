import 'package:flutter/widgets.dart';
import 'package:foxy/model/condition.dart';
import 'package:foxy/model/condition_filter_entity.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ConditionListViewModel {
  final sourceTypeController = TextEditingController();
  final sourceEntryController = TextEditingController();
  final repository = ConditionRepository();

  final page = signal(1);
  final items = signal<List<Condition>>([]);
  final total = signal(0);

  final _routerFacade = GetIt.instance.get<RouterFacade>();

  Future<void> initSignals() async {
    items.value = await _search();
    total.value = await _count();
  }

  Future<void> search() async {
    page.value = 1;
    items.value = await _search();
    total.value = await _count();
  }

  Future<void> reset() async {
    sourceTypeController.clear();
    sourceEntryController.clear();
    page.value = 1;
    items.value = await _search();
    total.value = await _count();
  }

  Future<void> paginate(int newPage) async {
    page.value = newPage;
    items.value = await _search();
    total.value = await _count();
  }

  void navigateToDetail(BuildContext context, {Condition? condition}) {
    final id = condition != null
        ? 'condition_${condition.sourceTypeOrReferenceId}_${condition.sourceEntry}'
        : 'condition_new';
    final label = condition != null
        ? 'Condition ${condition.sourceTypeOrReferenceId}-${condition.sourceEntry}'
        : '新建条件';

    // 将 Condition 对象序列化为查询参数
    final credential = condition?.toJson();

    _routerFacade.navigateToDetail(
      id: id,
      label: label,
      route: ConditionDetailRoute(credential: credential),
      parentMenu: RouterMenu.more,
    );
  }

  Future<void> onCopy(Condition condition) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制该条件？ConditionValue3 将自动+1。',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copy(condition.buildCredential());
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> onDelete(Condition condition) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除该条件记录？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroy(condition.buildCredential());
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  ConditionFilterEntity _buildFilter() {
    return ConditionFilterEntity()
      ..sourceTypeOrReferenceId = sourceTypeController.text
      ..sourceEntry = sourceEntryController.text;
  }

  Future<List<Condition>> _search() async {
    return repository.search(filter: _buildFilter(), page: page.value);
  }

  Future<int> _count() async {
    return repository.count(filter: _buildFilter());
  }

  Future<void> _refresh() async {
    items.value = await _search();
    total.value = await _count();
  }

  void dispose() {
    sourceTypeController.dispose();
    sourceEntryController.dispose();
  }
}
