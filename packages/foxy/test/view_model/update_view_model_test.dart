import 'dart:io';

import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/infrastructure/update/update_service.dart';
import 'package:foxy/infrastructure/update/update_swapper.dart';
import 'package:foxy/view_model/update_view_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    // Clear the package's static cache so each case re-reads the mock
    // data.
    SharedPreferences.resetStatic();
    PackageInfo.setMockInitialValues(
      appName: 'foxy',
      packageName: 'com.calsranna.foxy',
      version: '1.0.0',
      buildNumber: '628',
      buildSignature: '',
    );
  });

  tearDown(() {
    // Clean up the temp directory the VM created with Directory.current
    // (repo root) as the app directory.
    final updateTemp = Directory(p.join(Directory.current.path, '.update_tmp'));
    if (updateTemp.existsSync()) {
      updateTemp.deleteSync(recursive: true);
    }
  });

  group('checkManually', () {
    test('A newer release sets availableUpdate', () async {
      final service = _StubUpdateService(
        onCheck: () async => UpdateAvailable(_update()),
      );
      final vm = UpdateViewModel(service: service);

      final found = await vm.checkManually();
      expect(found, isTrue);
      expect(vm.availableUpdate.value?.version, '1.1.0');
      expect(vm.upToDate.value, isFalse);
      expect(vm.checking.value, isFalse);
      expect(vm.errorMessage.value, isNull);
    });

    test('The latest installed version sets upToDate', () async {
      final service = _StubUpdateService(onCheck: () async => const UpToDate());
      final vm = UpdateViewModel(service: service);

      final found = await vm.checkManually();
      expect(found, isFalse);
      expect(vm.availableUpdate.value, isNull);
      expect(vm.upToDate.value, isTrue);
    });

    test('A failed check maps errorMessage to localized text', () async {
      final service = _StubUpdateService(
        onCheck: () async => throw const UpdateException(
          UpdateErrorKind.network,
          'network down',
        ),
      );
      final vm = UpdateViewModel(service: service);

      final found = await vm.checkManually();
      expect(found, isFalse);
      expect(vm.errorMessage.value, '无法连接更新服务器，请检查网络后重试');
    });
  });

  group('checkSilently', () {
    test('A check within 24 hours skips the update service', () async {
      SharedPreferences.setMockInitialValues({
        'last_update_check_at': DateTime.now().toIso8601String(),
      });
      final service = _StubUpdateService();
      final vm = UpdateViewModel(service: service);

      final found = await vm.checkSilently();
      expect(found, isFalse);
      expect(service.checkCalls, 0);
    });

    test('Checks for updates after more than 24 hours', () async {
      SharedPreferences.setMockInitialValues({
        'last_update_check_at': DateTime.now()
            .subtract(const Duration(hours: 25))
            .toIso8601String(),
      });
      final service = _StubUpdateService(
        onCheck: () async => UpdateAvailable(_update()),
      );
      final vm = UpdateViewModel(service: service);

      final found = await vm.checkSilently();
      expect(found, isTrue);
      expect(service.checkCalls, 1);
      // Write the throttle timestamp after the check.
      final last = await SharedPreferences.getInstance().then(
        (prefs) => prefs.getString('last_update_check_at'),
      );
      expect(last, isNotNull);
    });

    test('Checks for updates when no previous check exists', () async {
      final service = _StubUpdateService(onCheck: () async => const UpToDate());
      final vm = UpdateViewModel(service: service);

      await vm.checkSilently();
      expect(service.checkCalls, 1);
    });

    test('A silent check failure sets errorMessage without throwing', () async {
      final service = _StubUpdateService(
        onCheck: () async => throw const UpdateException(
          UpdateErrorKind.network,
          'network down',
        ),
      );
      final vm = UpdateViewModel(service: service);

      final found = await vm.checkSilently();
      expect(found, isFalse);
      expect(vm.errorMessage.value, '无法连接更新服务器，请检查网络后重试');
    });
  });

  group('downloadAndPrepare', () {
    test(
      'A successful download sets readyToRestart and resets progress',
      () async {
        final service = _StubUpdateService(
          onCheck: () async => UpdateAvailable(_update()),
        );
        final vm = UpdateViewModel(service: service);
        await vm.checkManually();

        final ok = await vm.downloadAndPrepare();
        expect(ok, isTrue);
        expect(vm.readyToRestart.value, isTrue);
        expect(vm.downloadProgress.value, isNull);
        expect(vm.errorMessage.value, isNull);
      },
    );

    test('Downloading with no available update returns false', () async {
      final service = _StubUpdateService(onCheck: () async => const UpToDate());
      final vm = UpdateViewModel(service: service);
      await vm.checkManually();

      final ok = await vm.downloadAndPrepare();
      expect(ok, isFalse);
    });

    test('A failed download maps errorMessage to localized text', () async {
      final service = _StubUpdateService(
        onCheck: () async => UpdateAvailable(_update()),
        prepareShouldFail: true,
      );
      final vm = UpdateViewModel(service: service);
      await vm.checkManually();

      final ok = await vm.downloadAndPrepare();
      expect(ok, isFalse);
      expect(vm.errorMessage.value, '更新文件校验失败，请重试');
      expect(vm.readyToRestart.value, isFalse);
    });

    test('Canceling a download returns to a state where it can be downloaded again', () async {
      final service = _StubUpdateService(
        onCheck: () async => UpdateAvailable(_update()),
      );
      final vm = UpdateViewModel(service: service);
      await vm.checkManually();

      final future = vm.downloadAndPrepare();
      vm.cancelDownload();
      final ok = await future;
      expect(ok, isFalse);
      expect(vm.errorMessage.value, isNull);
      expect(vm.downloadProgress.value, isNull);
      expect(vm.availableUpdate.value?.version, '1.1.0');
      expect(vm.readyToRestart.value, isFalse);

      // Retry: the VM creates a new token per download, so cancellation
      // state does not linger.
      final ok2 = await vm.downloadAndPrepare();
      expect(ok2, isTrue);
      expect(vm.readyToRestart.value, isTrue);
    });
  });

  group('restartToApply', () {
    test(
      'A missing helper sets errorMessage and keeps the application open',
      () async {
        final service = _StubUpdateService(
          onCheck: () async => UpdateAvailable(_update()),
        );
        final vm = UpdateViewModel(service: service);
        await vm.checkManually();
        await vm.downloadAndPrepare();

        await vm.restartToApply();
        // The test working directory (repo root) has no foxy_updater.exe.
        expect(vm.errorMessage.value, '更新程序文件缺失，请重新下载完整版本');
      },
    );
  });

  group('prepare', () {
    test('Loads current version information', () async {
      final vm = UpdateViewModel(service: _StubUpdateService());
      await vm.prepare();
      expect(vm.currentVersion.value, isNotNull);
      expect(vm.currentVersion.value, matches(RegExp(r'^\d+\.\d+\.\d+\+\d+$')));
    });
  });

  group('Exception mapping', () {
    test('FoxyExceptions.message covers every UpdateErrorKind', () {
      expect(
        FoxyExceptions.message(
          const UpdateException(UpdateErrorKind.network, 'x'),
        ),
        '无法连接更新服务器，请检查网络后重试',
      );
      expect(
        FoxyExceptions.message(
          const UpdateException(UpdateErrorKind.invalidManifest, 'x'),
        ),
        '更新信息无效，请稍后重试',
      );
      expect(
        FoxyExceptions.message(
          const UpdateException(UpdateErrorKind.verification, 'x'),
        ),
        '更新文件校验失败，请重试',
      );
      expect(
        FoxyExceptions.message(
          const UpdateException(UpdateErrorKind.fileSystem, 'x'),
        ),
        '更新文件写入失败，请检查磁盘空间后重试',
      );
      expect(
        FoxyExceptions.message(
          const UpdateException(UpdateErrorKind.canceled, 'x'),
        ),
        '更新已取消',
      );
    });
  });
}

UpdateManifestInfo _update() => UpdateManifestInfo(
  version: '1.1.0',
  buildNumber: '630',
  zipUrl: Uri.parse('https://example.com/foxy-1.1.0.zip'),
  sizeBytes: 42,
  sha256: 'a',
  notes: '说明',
);

/// Stub service: controls the check result and prepare actions.
class _StubUpdateService extends UpdateService {
  /// Check callback; null means it was not called (for throttle
  /// assertions).
  Future<UpdateCheckResult> Function()? onCheck;

  int checkCalls = 0;
  final bool prepareShouldFail;
  _StubUpdateService({this.onCheck, this.prepareShouldFail = false});

  @override
  Future<UpdateCheckResult> checkForUpdates({
    String? installedVersion,
    String? installedBuildNumber,
  }) {
    checkCalls += 1;
    final callback = onCheck;
    if (callback == null) {
      throw StateError('unexpected checkForUpdates call');
    }
    return callback();
  }

  @override
  Future<Directory> prepareUpdate(
    UpdateManifestInfo update, {
    required Directory appDir,
    void Function(double fraction)? onProgress,
    UpdateCancelToken? cancelToken,
  }) async {
    // Simulate download latency: cancellable in between.
    await Future<void>.delayed(const Duration(milliseconds: 20));
    if (cancelToken?.isCanceled ?? false) {
      throw const UpdateException(UpdateErrorKind.canceled, 'canceled by user');
    }
    if (prepareShouldFail) {
      throw const UpdateException(
        UpdateErrorKind.verification,
        'Update zip verification failed',
      );
    }
    final dir = Directory(p.join(appDir.path, UpdateSwapper.tempDirName))
      ..createSync(recursive: true);
    return dir;
  }
}
