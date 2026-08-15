import 'dart:async';

import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/feature_repository.dart';
import 'package:foxy/repository/version_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals/signals.dart';

class DashboardReadViewModel {
  final _repository = GetIt.instance.get<VersionRepository>();
  final _activityRepo = GetIt.instance.get<ActivityLogRepository>();
  final _eventBus = GetIt.instance.get<EventBus>();
  final _featureRepository = GetIt.instance.get<FeatureRepository>();

  final coreVersion = signal('');
  final coreRevision = signal('');
  final databaseVersion = signal('');
  final softwareVersion = signal('');
  final recentActivities = signal(<ActivityLogEntity>[]);
  final featureCount = signal(0);
  final activityCount = signal(0);
  final loading = signal(false);
  final errorMessage = signal<String?>(null);

  StreamSubscription<EntityWrittenEvent>? _activitySub;
  int _refreshToken = 0;

  void dispose() {
    _refreshToken++;
    _activitySub?.cancel();
  }

  Future<void> initSignals() async {
    _activitySub ??= _eventBus.on<EntityWrittenEvent>().listen(
      (event) => _onActivityLogged(event.log),
    );
    await _refresh();
  }

  Future<void> refresh() => _refresh();

  /// On a new activity-log event, prepends it to the recent-activity list
  /// (matching the DB's id-desc order), so the dashboard's "Activity"
  /// module updates instantly without a reload.
  void _onActivityLogged(ActivityLogEntity log) {
    final updated = [log, ...recentActivities.value];
    if (updated.length > 20) updated.removeRange(20, updated.length);
    recentActivities.value = updated;
    activityCount.value += 1;
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    loading.value = true;
    errorMessage.value = null;
    try {
      final (
        version,
        packageInfo,
        activities,
        featureTotal,
        activityTotal,
      ) = await (
        _repository.getVersion(),
        PackageInfo.fromPlatform(),
        _activityRepo.getActivityLogs(),
        _featureRepository.countFeatures(),
        _activityRepo.countActivityLogs(),
      ).wait;
      if (token != _refreshToken) return;
      coreVersion.value = version.coreVersion;
      coreRevision.value = version.coreRevision;
      databaseVersion.value = version.dbVersion;
      softwareVersion.value =
          '${packageInfo.version}+${packageInfo.buildNumber}';
      recentActivities.value = activities;
      featureCount.value = featureTotal;
      activityCount.value = activityTotal;
    } catch (error) {
      if (token == _refreshToken) errorMessage.value = FoxyExceptions.message(error);
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }
}
