import 'package:flutter/widgets.dart';
import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/entity/achievement_filter_entity.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class AchievementListViewModel {
  final entryController = TextEditingController();
  final titleController = TextEditingController();
  final repository = AchievementRepository();

  final page = signal(1);
  final achievements = signal(<BriefAchievementEntity>[]);
  final total = signal(0);

  Future<void> copyAchievement(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $id 的成就？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await repository.copyAchievement(id);
      _logActivity(ActivityActionType.copy, id);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteAchievement(int id) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $id 的成就？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await repository.destroyAchievement(id);
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
    titleController.dispose();
  }

  Future<void> initSignals() async {
    try {
      achievements.value = await repository.getBriefAchievements();
      total.value = await repository.countAchievements();
    } catch (e) {
      LoggerUtil.instance.e('加载成就列表失败: $e');
      DialogUtil.instance.error('加载成就列表失败: $e');
    }
  }

  void navigateToDetail({int? id}) {
    final label = id != null ? '成就 #$id' : '新建成就';
    final routeId = id != null ? 'achievement_$id' : 'achievement_new';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      id: routeId,
      label: label,
      route: AchievementDetailRoute(id: id),
      parentMenu: RouterMenu.achievement,
    );
  }

  AchievementFilterEntity _buildFilter() {
    return AchievementFilterEntity(
      id: entryController.text,
      title: titleController.text,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.clear();
    titleController.clear();
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
      achievements.value = await repository.getBriefAchievements(
        page: page.value,
        filter: filter,
      );
      total.value = await repository.countAchievements(filter: filter);
    } catch (e) {
      LoggerUtil.instance.e('刷新成就列表失败: $e');
      DialogUtil.instance.error('刷新成就列表失败: $e');
    }
  }

  void _logActivity(ActivityActionType action, int id) {
    final log = ActivityLogEntity(
      module: 'achievement',
      actionType: action,
      entityId: id,
      entityName: id.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }
}
