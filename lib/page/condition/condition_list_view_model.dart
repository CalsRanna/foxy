import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/brief_condition_entity.dart';
import 'package:foxy/entity/condition_filter_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ConditionListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final sourceTypeController = registerController(StringFieldController());
  late final sourceEntryController = registerController(
    StringFieldController(),
  );

  final _repository = GetIt.instance.get<ConditionRepository>();

  final page = signal(1);
  final conditions = signal<List<BriefConditionEntity>>([]);
  final total = signal(0);

  final routerFacade = GetIt.instance.get<RouterFacade>();

  Future<void> copyCondition(BriefConditionEntity condition) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制该条件？ElseGroup 将自动+1。',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyCondition(condition.key);
      _logActivity(ActivityActionType.copy, condition);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteCondition(BriefConditionEntity condition) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除该条件记录？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyCondition(condition.key);
      _logActivity(ActivityActionType.delete, condition);
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
      final (items, count) = await (_search(), _count()).wait;
      if (token != _refreshToken) return;
      conditions.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载条件列表失败: $e');
      DialogUtil.instance.error('加载条件列表失败: $e');
    }
  }

  void navigateToDetail({BriefConditionEntity? condition}) {
    final id = condition != null
        ? 'condition_${condition.sourceTypeOrReferenceId}_${condition.sourceEntry}'
        : 'condition_new';
    final label = condition != null
        ? (condition.comment.isNotEmpty
              ? condition.comment
              : 'Condition ${condition.sourceTypeOrReferenceId}-${condition.sourceEntry}')
        : '新建条件';

    routerFacade.navigateToDetail(
      id: id,
      label: label,
      route: ConditionDetailRoute(conditionKey: condition?.key),
      parentMenu: RouterMenu.more,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    sourceTypeController.init('');
    sourceEntryController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  ConditionFilterEntity _buildFilter() {
    return ConditionFilterEntity(
      sourceTypeOrReferenceId: sourceTypeController.collect(),
      sourceEntry: sourceEntryController.collect(),
    );
  }

  Future<int> _count() async {
    return _repository.countConditions(filter: _buildFilter());
  }

  void _logActivity(ActivityActionType action, BriefConditionEntity c) {
    final log = ActivityLogEntity(
      module: 'conditions',
      actionType: action,
      entityName:
          'Condition ${c.sourceTypeOrReferenceId}/${c.sourceGroup}/'
          '${c.sourceEntry}/${c.sourceId}/${c.elseGroup}'
          '${c.comment.isEmpty ? '' : ' - ${c.comment}'}',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final (items, count) = await (_search(), _count()).wait;
      if (token != _refreshToken) return;
      conditions.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新条件列表失败: $e');
      DialogUtil.instance.error('刷新条件列表失败: $e');
    }
  }

  Future<List<BriefConditionEntity>> _search() async {
    return _repository.getBriefConditions(
      filter: _buildFilter(),
      page: page.value,
    );
  }
}
