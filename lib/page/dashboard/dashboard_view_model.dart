import 'package:foxy/repository/version_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals/signals.dart';

class DashboardViewModel {
  final coreVersion = signal('');
  final coreRevision = signal('');
  final databaseVersion = signal('');
  final softwareVersion = signal('');

  Future<void> initSignals() async {
    var versionEntity = await VersionRepository().getVersion();
    coreVersion.value = versionEntity.coreVersion;
    coreRevision.value = versionEntity.coreRevision;
    databaseVersion.value = versionEntity.dbVersion;
    var packageInfo = await PackageInfo.fromPlatform();
    softwareVersion.value = '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
