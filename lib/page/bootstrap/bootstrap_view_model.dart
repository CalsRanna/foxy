import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals/signals.dart';

class BootstrapViewModel {
  final showForm = signal(false);
  final version = signal('');

  Future<void> initSignals() async {
    final packageInfo = await PackageInfo.fromPlatform();
    version.value = '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
