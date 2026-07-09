import 'dart:async';

import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/activity_logged_event.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/feature_repository.dart';
import 'package:foxy/util/event_bus.dart';
import 'package:foxy/repository/version_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/page/scaffold/scaffold_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals/signals.dart';

class DashboardViewModel {
  final _repository = GetIt.instance.get<VersionRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final scaffoldViewModel = GetIt.instance.get<ScaffoldViewModel>();
  final _activityRepo = GetIt.instance.get<ActivityLogRepository>();
  final _eventBus = GetIt.instance.get<EventBus>();
  StreamSubscription<ActivityLoggedEvent>? _activitySub;
  final _featureRepository = GetIt.instance.get<FeatureRepository>();

  final coreVersion = signal('');
  final coreRevision = signal('');
  final databaseVersion = signal('');
  final softwareVersion = signal('');
  final recentActivities = signal(<ActivityLogEntity>[]);
  final featureCount = signal(0);
  final activityCount = signal(0);

  void navigateToMenu(RouterMenu menu) {
    final feature = scaffoldViewModel.allFeatures.value
        .where((f) => f.routerMenu == menu.name)
        .firstOrNull;
    final isPinned = feature?.isPinned ?? true;
    routerFacade.navigateToMenu(
      menu,
      parentMenu: isPinned ? null : RouterMenu.more,
    );
  }

  Future<void> initSignals() async {
    try {
      var versionEntity = await _repository.getVersion();
      coreVersion.value = versionEntity.coreVersion;
      coreRevision.value = versionEntity.coreRevision;
      databaseVersion.value = versionEntity.dbVersion;
      var packageInfo = await PackageInfo.fromPlatform();
      softwareVersion.value =
          '${packageInfo.version}+${packageInfo.buildNumber}';
      await _loadRecentActivities();
      featureCount.value = await _featureRepository.countFeatures();
      activityCount.value = await _activityRepo.countActivityLogs();
      _activitySub ??= _eventBus.on<ActivityLoggedEvent>().listen(
        (e) => _onActivityLogged(e.log),
      );
    } catch (e) {
      LoggerUtil.instance.e('加载仪表板数据失败: $e');
      DialogUtil.instance.error('加载仪表板数据失败: $e');
    }
  }

  Future<void> _loadRecentActivities() async {
    try {
      recentActivities.value = await _activityRepo.getActivityLogs();
    } catch (e) {
      LoggerUtil.instance.e('加载最近活动失败: $e');
      DialogUtil.instance.error('加载最近活动失败: $e');
    }
  }

  /// 收到新活动日志事件时将其前插到最近活动列表（与 DB 的 id desc 顺序一致），
  /// 使仪表盘「动态」模块即时更新，无需等待重新加载。
  void _onActivityLogged(ActivityLogEntity log) {
    final updated = [log, ...recentActivities.value];
    if (updated.length > 20) updated.removeRange(20, updated.length);
    recentActivities.value = updated;
    activityCount.value += 1;
  }

  void dispose() {
    _activitySub?.cancel();
  }
}
