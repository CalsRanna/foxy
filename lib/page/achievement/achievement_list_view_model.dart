import 'package:foxy/entity/achievement_filter_entity.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/brief_achievement_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class AchievementListViewModel with FieldControllerMixin {
  int _refreshToken = 0;
  late final entryController = registerController(StringFieldController());
  late final titleController = registerController(StringFieldController());

  final _repository = GetIt.instance.get<AchievementRepository>();

  final page = signal(1);
  final achievements = signal(<BriefAchievementEntity>[]);
  final total = signal(0);

  Future<void> copyAchievement(int key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $key 的成就？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      await _repository.copyAchievement(key);
      _logActivity(ActivityActionType.copy, key);
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteAchievement(int key) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $key 的成就？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      await _repository.destroyAchievement(key);
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
        _repository.getBriefAchievements(),
        _repository.countAchievements(),
      ).wait;
      if (token != _refreshToken) return;
      achievements.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('加载成就列表失败: $e');
      DialogUtil.instance.error('加载成就列表失败: $e');
    }
  }

  void navigateToDetail({int? key}) {
    final label = key != null ? '成就 #$key' : '新建成就';
    final routerFacade = GetIt.instance.get<RouterFacade>();
    routerFacade.navigateToDetail(
      label: label,
      route: AchievementDetailRoute(achievementKey: key),
      parentMenu: RouterMenu.achievement,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> reset() async {
    entryController.init('');
    titleController.init('');
    page.value = 1;
    await _refresh();
  }

  Future<void> search() async {
    page.value = 1;
    await _refresh();
  }

  AchievementFilterEntity _buildFilter() {
    return AchievementFilterEntity(
      id: entryController.collect(),
      title: titleController.collect(),
    );
  }

  void _logActivity(ActivityActionType action, int key) {
    final log = ActivityLogEntity(
      module: 'achievement',
      actionType: action,
      entityName: 'Achievement $key',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    try {
      final filter = _buildFilter();
      final (items, count) = await (
        _repository.getBriefAchievements(page: page.value, filter: filter),
        _repository.countAchievements(filter: filter),
      ).wait;
      if (token != _refreshToken) return;
      achievements.value = items;
      total.value = count;
    } catch (e) {
      LoggerUtil.instance.e('刷新成就列表失败: $e');
      DialogUtil.instance.error('刷新成就列表失败: $e');
    }
  }
}
