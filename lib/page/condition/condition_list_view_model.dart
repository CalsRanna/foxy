import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/entity/condition_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
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
  final conditions = signal<List<ConditionEntity>>([]);
  final total = signal(0);

  final routerFacade = GetIt.instance.get<RouterFacade>();

  Future<void> initSignals() async {
    conditions.value = await _search();
    total.value = await _count();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> reset() async {
    sourceTypeController.clear();
    sourceEntryController.clear();
    page.value = 1;
    conditions.value = await _search();
    total.value = await _count();
  }

  Future<void> paginate(int newPage) async {
    page.value = newPage;
    await _refresh();
  }

  void navigateToDetail({ConditionEntity? condition}) {
    final id = condition != null
        ? 'condition_${condition.sourceTypeOrReferenceId}_${condition.sourceEntry}'
        : 'condition_new';
    final label = condition != null
        ? 'Condition ${condition.sourceTypeOrReferenceId}-${condition.sourceEntry}'
        : '新建条件';

    // 将 Condition 对象序列化为查询参数
    final credential = condition?.toJson();

    routerFacade.navigateToDetail(
      id: id,
      label: label,
      route: ConditionDetailRoute(credential: credential),
      parentMenu: RouterMenu.more,
    );
  }

  Future<void> copyCondition(ConditionEntity condition) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制该条件？ConditionValue3 将自动+1。',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyCondition(condition.buildCredential());
      _logActivity(ActivityActionType.copy, condition);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteCondition(ConditionEntity condition) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除该条件记录？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyCondition(condition.buildCredential());
      _logActivity(ActivityActionType.delete, condition);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  ConditionFilterEntity _buildFilter() {
    return ConditionFilterEntity(
      sourceTypeOrReferenceId: sourceTypeController.text,
      sourceEntry: sourceEntryController.text,
    );
  }

  Future<List<ConditionEntity>> _search() async {
    return repository.getConditions(filter: _buildFilter(), page: page.value);
  }

  Future<int> _count() async {
    return repository.countConditions(filter: _buildFilter());
  }

  Future<void> _refresh() async {
    conditions.value = await _search();
    total.value = await _count();
  }

  void _logActivity(ActivityActionType action, ConditionEntity c) {
    final log = ActivityLogEntity(
      module: 'conditions',
      actionType: action,
      entityId: c.sourceTypeOrReferenceId,
      entityName: c.comment,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    sourceTypeController.dispose();
    sourceEntryController.dispose();
  }
}
