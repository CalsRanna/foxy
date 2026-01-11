import 'package:foxy/repository/version_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals/signals.dart';

class DashboardViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final coreVersion = signal('');
  final coreRevision = signal('');
  final databaseVersion = signal('');
  final softwareVersion = signal('');

  void navigateToMenu(RouterMenu menu) {
    routerFacade.navigateToMenu(menu);
  }

  Future<void> initSignals() async {
    var versionEntity = await VersionRepository().getVersion();
    coreVersion.value = versionEntity.coreVersion;
    coreRevision.value = versionEntity.coreRevision;
    databaseVersion.value = versionEntity.dbVersion;
    var packageInfo = await PackageInfo.fromPlatform();
    softwareVersion.value = '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
