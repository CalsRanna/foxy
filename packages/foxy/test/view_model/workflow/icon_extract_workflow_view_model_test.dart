import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/use_case/game_asset/extract_game_icons_use_case.dart';
import 'package:foxy/view_model/workflow/icon_extract_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';

void main() {
  // The workflow invalidates the render cache (PaintingBinding) on
  // success, which requires an initialized binding.
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late Directory clientRoot;
  late Directory outputDir;
  late _TempConfigUtil configUtil;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_icon_vm_test_');
    clientRoot = Directory(p.join(tempDir.path, 'client'))..createSync();
    outputDir = Directory(p.join(tempDir.path, 'out'))..createSync();
    configUtil = _TempConfigUtil(tempDir.path);
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  IconExtractWorkflowViewModel buildVm() {
    return IconExtractWorkflowViewModel(
      useCase: ExtractGameIconsUseCase(
        configUtil: configUtil,
        outputDir: outputDir.path,
      ),
      configUtil: configUtil,
    );
  }

  test('prepare loads client_dir from configuration', () async {
    await configUtil.update({'client_dir': r'D:\fake\client'});
    final vm = buildVm();
    await vm.prepare();
    expect(vm.status.value, WorkflowStatus.idle);
    expect(vm.path.value, r'D:\fake\client');
  });

  test(
    'Extracts icons from a real MPQ, reports progress, and succeeds',
    () async {
      final dataDir = Directory(p.join(clientRoot.path, 'Data', 'zhCN'))
        ..createSync(recursive: true);
      _createFakeClientMpq(dataDir.path);

      final vm = buildVm();
      await vm.prepare();
      vm.setPath(clientRoot.path);
      final startFuture = vm.start();

      // start does not block: poll until done.
      await _waitFor(() => vm.status.value == WorkflowStatus.succeeded);
      await startFuture;
      expect(vm.result.value!.extracted, 2);
      expect(vm.result.value!.skipped, 0);
      expect(File(p.join(outputDir.path, 'inv_foo.blp')).readAsBytesSync(), [
        1,
        2,
        3,
        4,
      ]);
      expect(
        File(p.join(outputDir.path, 'ui-glyph-rune-1.blp')).readAsBytesSync(),
        [5, 6, 7, 8],
      );
      // Config was persisted.
      final config = await configUtil.load();
      expect(config['client_dir'], clientRoot.path);
    },
  );

  test('Successful extraction clears the icon cache', () async {
    // Preload a real icon into the global ImageCache to simulate opening
    // a list page before extraction.
    await preloadIconIntoCache(
      'fixture_dxt1',
      p.dirname(File('test/fixture/icons/fixture_dxt1.blp').absolute.path),
    );
    expect(PaintingBinding.instance.imageCache.currentSize, greaterThan(0));

    final dataDir = Directory(p.join(clientRoot.path, 'Data', 'zhCN'))
      ..createSync(recursive: true);
    _createFakeClientMpq(dataDir.path);

    final vm = buildVm();
    await vm.prepare();
    vm.setPath(clientRoot.path);
    final startFuture = vm.start();
    await _waitFor(() => vm.status.value == WorkflowStatus.succeeded);
    await startFuture;

    // Extraction changes the icons on disk. Invalidate the old decoded entries
    // so the new icons appear in the same app session.
    expect(PaintingBinding.instance.imageCache.currentSize, 0);
  });

  test(
    'start fails and shows an error when no directory is selected',
    () async {
      final vm = buildVm();
      await vm.prepare();
      await expectLater(vm.start(), throwsA(isA<ValidationException>()));
      expect(vm.status.value, WorkflowStatus.failed);
      expect(vm.errorMessage.value, contains('输入不合法'));
    },
  );

  test(
    'start throws and marks the run failed when the directory is missing',
    () async {
      final vm = buildVm();
      await vm.prepare();
      vm.setPath(p.join(tempDir.path, '不存在'));
      await expectLater(vm.start(), throwsA(isA<FileSystemException>()));
      expect(vm.status.value, WorkflowStatus.failed);
      expect(vm.errorMessage.value, contains('文件系统错误'));
    },
  );

  test(
    'start returns a failure and shows an error for a non-client directory',
    () async {
      final vm = buildVm();
      await vm.prepare();
      vm.setPath(tempDir.path); // exists but has no Data directory
      await vm.start();
      expect(vm.status.value, WorkflowStatus.failed);
      expect(vm.errorMessage.value, contains('客户端目录'));
      expect(vm.errorMessage.value, contains('Data'));
    },
  );

  test('reset clears run state and keeps the path', () async {
    final vm = buildVm();
    vm.setPath(r'D:\fake');
    vm.reset();
    expect(vm.path.value, r'D:\fake');
    expect(vm.status.value, WorkflowStatus.idle);
    expect(vm.errorMessage.value, isNull);
  });
}

/// Preloads an icon into the global image cache (keep-alive entry).
///
/// Resolving through [ImageProvider.resolve] is required: the cache only
/// moves a completed image into its keep-alive store via the internal
/// pending-image listener, which a direct loadImage call bypasses.
Future<void> preloadIconIntoCache(String name, String iconDir) async {
  final stream = FoxyBlpIconProvider(
    rawPath: name,
    iconDir: iconDir,
  ).resolve(const ImageConfiguration());
  final completer = Completer<ImageInfo?>();
  late ImageStreamListener listener;
  listener = ImageStreamListener(
    (info, synchronousCall) {
      if (!completer.isCompleted) completer.complete(info);
    },
    onError: (error, stackTrace) {
      if (!completer.isCompleted) completer.complete(null);
    },
  );
  stream.addListener(listener);
  final info = await completer.future;
  // Disposing the clone leaves the completer's current image intact.
  info?.dispose();
  // The ImageCache keep-alive handle retains the image after listener removal.
  stream.removeListener(listener);
}

/// Uses warcrafty to write a minimal MPQ containing 2 icons.
void _createFakeClientMpq(String localeDataDir) {
  final archive = MpqArchive.create(
    p.join(localeDataDir, 'locale-zhCN.MPQ'),
    maxFileCount: 8,
  );
  archive.addFile(
    r'Interface\Icons\INV_Foo.blp',
    Uint8List.fromList([1, 2, 3, 4]),
  );
  archive.addFile(
    r'Interface\Spellbook\UI-Glyph-Rune-1.blp',
    Uint8List.fromList([5, 6, 7, 8]),
  );
  archive.close();
}

Future<void> _waitFor(bool Function() condition) async {
  final deadline = DateTime.now().add(const Duration(seconds: 20));
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      fail('等待超时');
    }
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }
}

/// ConfigUtil pointing at a temp directory (so tests never pollute the
/// project-root config.yaml).
final class _TempConfigUtil extends ConfigUtil {
  final String _dir;

  _TempConfigUtil(this._dir);

  @override
  String get configPath => p.join(_dir, 'config.yaml');
}
