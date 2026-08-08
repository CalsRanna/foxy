import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/infrastructure/game_asset/blp_icon_provider.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:foxy/use_case/game_asset/extract_game_icons_use_case.dart';
import 'package:foxy/view_model/icon_extract_workflow_view_model.dart';
import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';

void main() {
  // The workflow invalidates the render caches (PaintingBinding /
  // BlpIconCache) on success, which requires an initialized binding.
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

  test('prepare 从配置加载 client_dir', () async {
    await configUtil.update({'client_dir': r'D:\fake\client'});
    final vm = buildVm();
    await vm.prepare();
    expect(vm.status.value, WorkflowStatus.idle);
    expect(vm.path.value, r'D:\fake\client');
  });

  test('完整提取流程：真实 MPQ → 进度 → 成功', () async {
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
  });

  test('提取成功后清空图标缓存与负缓存', () async {
    // 预加载一个真实图标进全局 ImageCache(keepAlive)并记录一条负缓存,
    // 模拟提取前浏览过列表页的状态。
    await preloadIconIntoCache(
      'fixture_dxt1',
      p.dirname(File('test/fixture/icons/fixture_dxt1.blp').absolute.path),
    );
    expect(PaintingBinding.instance.imageCache.currentSize, greaterThan(0));
    BlpIconCache.instance.add('pre_extraction_missing');

    final dataDir = Directory(p.join(clientRoot.path, 'Data', 'zhCN'))
      ..createSync(recursive: true);
    _createFakeClientMpq(dataDir.path);

    final vm = buildVm();
    await vm.prepare();
    vm.setPath(clientRoot.path);
    final startFuture = vm.start();
    await _waitFor(() => vm.status.value == WorkflowStatus.succeeded);
    await startFuture;

    // 提取改变了磁盘上的图标集:旧的解码缓存和提取前的负缓存必须失效,
    // 新图标才能立即显示(无需重启)。
    expect(PaintingBinding.instance.imageCache.currentSize, 0);
    expect(BlpIconCache.instance.contains('pre_extraction_missing'), isFalse);
  });

  test('未选择目录时 start 失败并提示', () async {
    final vm = buildVm();
    await vm.prepare();
    await expectLater(vm.start(), throwsA(isA<ValidationException>()));
    expect(vm.status.value, WorkflowStatus.failed);
    expect(vm.errorMessage.value, contains('输入不合法'));
  });

  test('目录不存在 start 抛异常并标记失败', () async {
    final vm = buildVm();
    await vm.prepare();
    vm.setPath(p.join(tempDir.path, '不存在'));
    await expectLater(vm.start(), throwsA(isA<FileSystemException>()));
    expect(vm.status.value, WorkflowStatus.failed);
    expect(vm.errorMessage.value, contains('文件系统错误'));
  });

  test('非客户端目录 start 返回失败结果并提示', () async {
    final vm = buildVm();
    await vm.prepare();
    vm.setPath(tempDir.path); // exists but has no Data directory
    await vm.start();
    expect(vm.status.value, WorkflowStatus.failed);
    expect(vm.errorMessage.value, contains('客户端目录'));
    expect(vm.errorMessage.value, contains('Data'));
  });

  test('reset 清空运行状态但保留路径', () async {
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
  final stream = BlpIconProvider(rawPath: name, iconDir: iconDir).resolve(
    const ImageConfiguration(),
  );
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
  // 克隆:释放它不影响 completer 持有的当前图。
  info?.dispose();
  // 移除监听后,ImageCache 的 keepAlive 句柄保住图片。
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
