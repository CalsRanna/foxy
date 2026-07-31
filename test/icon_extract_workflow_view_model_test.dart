import 'dart:io';
import 'dart:typed_data';

import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/page/setting/icon_extract_workflow_view_model.dart';
import 'package:foxy/page/workflow/workflow_status.dart';
import 'package:foxy/use_case/game_asset/extract_game_icons_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';

/// 指向临时目录的 ConfigUtil（避免测试污染项目根目录 config.yaml）。
final class _TempConfigUtil extends ConfigUtil {
  _TempConfigUtil(this._dir);

  final String _dir;

  @override
  String get configPath => p.join(_dir, 'config.yaml');
}

/// 用 warcrafty 写一个含 2 个图标的最小 MPQ。
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

void main() {
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
    final dataDir = Directory(
      p.join(clientRoot.path, 'Data', 'zhCN'),
    )..createSync(recursive: true);
    _createFakeClientMpq(dataDir.path);

    final vm = buildVm();
    await vm.prepare();
    vm.setPath(clientRoot.path);
    final startFuture = vm.start();

    // start 不阻塞：轮询等待完成。
    await _waitFor(
      () => vm.status.value == WorkflowStatus.succeeded,
    );
    await startFuture;
    expect(vm.result.value!.extracted, 2);
    expect(vm.result.value!.skipped, 0);
    expect(
      File(p.join(outputDir.path, 'inv_foo.blp')).readAsBytesSync(),
      [1, 2, 3, 4],
    );
    expect(
      File(p.join(outputDir.path, 'ui-glyph-rune-1.blp')).readAsBytesSync(),
      [5, 6, 7, 8],
    );
    // 配置已持久化。
    final config = await configUtil.load();
    expect(config['client_dir'], clientRoot.path);
  });

  test('未选择目录时 start 失败并提示', () async {
    final vm = buildVm();
    await vm.prepare();
    await expectLater(vm.start(), throwsA(isA<StateError>()));
    expect(vm.status.value, WorkflowStatus.failed);
    expect(vm.errorMessage.value, contains('客户端目录'));
  });

  test('目录不存在 start 抛异常并标记失败', () async {
    final vm = buildVm();
    await vm.prepare();
    vm.setPath(p.join(tempDir.path, '不存在'));
    await expectLater(vm.start(), throwsA(isA<FileSystemException>()));
    expect(vm.status.value, WorkflowStatus.failed);
    expect(vm.errorMessage.value, contains('客户端目录不存在'));
  });

  test('非客户端目录 start 返回失败结果并提示', () async {
    final vm = buildVm();
    await vm.prepare();
    vm.setPath(tempDir.path); // 存在但没有 Data 目录
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

Future<void> _waitFor(bool Function() condition) async {
  final deadline = DateTime.now().add(const Duration(seconds: 20));
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      fail('等待超时');
    }
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }
}
