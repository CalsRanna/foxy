import 'package:flutter/widgets.dart';
import 'package:foxy/model/activity_log.dart';
import 'package:foxy/model/scaling_stat_distribution.dart';
import 'package:foxy/model/scaling_stat_distribution_filter_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/scaling_stat_distribution_solo_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class ScalingStatDistributionListViewModel {
  final idController = TextEditingController();
  final repository = ScalingStatDistributionSoloRepository();

  final page = signal(1);
  final distributions = signal(<ScalingStatDistribution>[]);
  final total = signal(0);

  Future<void> copyScalingStatDistribution(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的属性缩放分布？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyScalingStatDistribution(id);
      _logActivity(ActivityActionType.copy, id);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteScalingStatDistribution(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的属性缩放分布？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyScalingStatDistribution(id);
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
    final log = ActivityLog(
      module: 'scaling_stat_distribution',
      actionType: action,
      entityId: id,
      entityName: '',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    idController.dispose();
  }

  Future<void> initSignals() async {
    final filter = ScalingStatDistributionFilterEntity();
    distributions.value = await repository.getScalingStatDistributions(page: 1, filter: filter);
    total.value = await repository.countScalingStatDistributions(filter: filter);
  }

  void navigateToDetail({int? id}) {
    final label = id != null ? '属性缩放分布 #$id' : '新建属性缩放分布';
    final routeId = id != null ? 'scaling_stat_distribution_$id' : 'scaling_stat_distribution_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: ScalingStatDistributionDetailRoute(id: id),
      parentMenu: RouterMenu.scalingStatDistribution,
    );
  }

  ScalingStatDistributionFilterEntity _buildFilter() {
    return ScalingStatDistributionFilterEntity()
      ..id = idController.text;
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    idController.clear();
    page.value = 1;
    final filter = ScalingStatDistributionFilterEntity();
    distributions.value = await repository.getScalingStatDistributions(page: 1, filter: filter);
    total.value = await repository.countScalingStatDistributions(filter: filter);
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  Future<void> _refresh() async {
    final filter = _buildFilter();
    distributions.value = await repository.getScalingStatDistributions(page: page.value, filter: filter);
    total.value = await repository.countScalingStatDistributions(filter: filter);
  }
}
