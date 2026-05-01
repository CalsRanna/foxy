import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy/entity/scaling_stat_value_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/scaling_stat_value_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ScalingStatValueListViewModel {
  final entryController = TextEditingController();
  final charlevelController = TextEditingController();
  final repository = ScalingStatValueRepository();

  final page = signal(1);
  final scalingStatValues = signal(<BriefScalingStatValueEntity>[]);
  final total = signal(0);

  Future<void> copyScalingStatValue(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的缩放属性值？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await repository.copyScalingStatValue(id);
      _logActivity(ActivityActionType.copy, id);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteScalingStatValue(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的缩放属性值？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await repository.destroyScalingStatValue(id);
      _logActivity(ActivityActionType.delete, id);
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    entryController.dispose();
    charlevelController.dispose();
  }

  Future<void> initSignals() async {
    try {
      scalingStatValues.value = await repository.getBriefScalingStatValues();
      total.value = await repository.countScalingStatValues();
    } catch (e) {
      LoggerUtil.instance.e('加载缩放属性值列表失败: $e');
      DialogUtil.instance.error('加载缩放属性值列表失败: $e');
    }
  }

  void navigateToDetail({int? id}) {
    final label = id != null ? '缩放属性值 #$id' : '新建缩放属性值';
    final routeId = id != null ? 'scaling_stat_value_$id' : 'scaling_stat_value_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: ScalingStatValueDetailRoute(id: id),
      parentMenu: RouterMenu.scalingStatValue,
    );
  }

  ScalingStatValueFilterEntity _buildFilter() {
    return ScalingStatValueFilterEntity(
      id: entryController.text,
      charlevel: charlevelController.text,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.clear();
    charlevelController.clear();
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    try {
      final filter = _buildFilter();
      scalingStatValues.value = await repository.getBriefScalingStatValues(
        page: page.value,
        filter: filter,
      );
      total.value = await repository.countScalingStatValues(filter: filter);
    } catch (e) {
      LoggerUtil.instance.e('刷新缩放属性值列表失败: $e');
      DialogUtil.instance.error('刷新缩放属性值列表失败: $e');
    }
  }

  void _logActivity(ActivityActionType action, int id) {
    final log = ActivityLogEntity(
      module: 'scaling_stat_value',
      actionType: action,
      entityId: id,
      entityName: id.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }
}
