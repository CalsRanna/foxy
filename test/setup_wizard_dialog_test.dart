import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/page/setting/dbc_import_workflow_view_model.dart';
import 'package:foxy/page/setting/icon_extract_workflow_view_model.dart';
import 'package:foxy/page/setting/setup_status_view_model.dart';
import 'package:foxy/page/setting/setup_wizard_dialog.dart';
import 'package:foxy/page/workflow/workflow_status.dart';
import 'package:foxy/use_case/dbc/import_dbc_use_case.dart';
import 'package:foxy/use_case/game_asset/extract_game_icons_use_case.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:warcrafty/warcrafty.dart';

/// 内存 ConfigUtil：读写都无真实 IO，widget 测试无需 runAsync 也能完成。
final class _MemoryConfigUtil extends ConfigUtil {
  _MemoryConfigUtil(this.data);

  final Map<String, dynamic> data;

  @override
  String get configPath => 'memory:config.yaml';

  @override
  Future<Map<String, dynamic>> load() async => Map<String, dynamic>.of(data);

  @override
  Future<void> update(Map<String, dynamic> values) async {
    data.addAll(values);
  }
}

/// 假 DbcSyncUtil：表检查全部就绪，导入立即成功（不触真实 MySQL/isolate）。
final class _FakeDbcSyncUtil extends DbcSyncUtil {
  @override
  Future<List<DbcTableCheckResult>> checkTables() async => [
        for (final definition in dbcDefinitions)
          DbcTableCheckResult(
            tableName: definition.tableName,
            state: DbcTableState.ready,
          ),
      ];

  @override
  Stream<DbcSyncProgress> import({
    required String directory,
    required MysqlConfig mysqlConfig,
  }) async* {
    yield const DbcSyncResult(
      operation: DbcSyncOperation.import,
      completed: 1,
      skipped: 0,
      errors: [],
      cancelled: false,
    );
  }
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
  late Directory dbcDir;
  late Directory outputDir;
  late Map<String, dynamic> configData;
  late _MemoryConfigUtil configUtil;
  late SetupStatusViewModel setupVm;
  late DbcImportWorkflowViewModel importVm;
  late IconExtractWorkflowViewModel iconVm;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_wizard_test_');
    clientRoot = Directory(p.join(tempDir.path, 'client'))..createSync();
    Directory(p.join(clientRoot.path, 'Data', 'zhCN'))
        .createSync(recursive: true);
    _createFakeClientMpq(p.join(clientRoot.path, 'Data', 'zhCN'));
    dbcDir = Directory(p.join(tempDir.path, 'dbc'))..createSync();
    outputDir = Directory(p.join(tempDir.path, 'out'))..createSync();

    configData = {};
    configUtil = _MemoryConfigUtil(configData);
    setupVm = SetupStatusViewModel(configUtil: configUtil);
    importVm = DbcImportWorkflowViewModel(
      useCase: ImportDbcUseCase(
        configUtil: configUtil,
        dbcSyncUtil: _FakeDbcSyncUtil(),
      ),
      configUtil: configUtil,
    );
    iconVm = IconExtractWorkflowViewModel(
      useCase: ExtractGameIconsUseCase(
        configUtil: configUtil,
        outputDir: outputDir.path,
      ),
      configUtil: configUtil,
    );
  });

  tearDown(() {
    iconVm.dispose();
    importVm.dispose();
    tempDir.deleteSync(recursive: true);
  });

  Widget buildWizard() {
    return ShadApp(
      home: Scaffold(
        body: SetupWizardDialog(
          setupVm: setupVm,
          importVm: importVm,
          iconVm: iconVm,
        ),
      ),
    );
  }

  Future<void> pumpWizard(WidgetTester tester) async {
    await tester.pumpWidget(buildWizard());
    await tester.pump();
    await tester.pump();
  }

  testWidgets('全新用户从步骤 1 开始，对话框不可关闭', (tester) async {
    await pumpWizard(tester);

    expect(find.text('首次设置引导'), findsOneWidget);
    expect(find.text('第 1 步：设置客户端目录'), findsOneWidget);
    expect(find.text('第 2 步：设置服务端 DBC 目录'), findsNothing);

    // 无关闭按钮（closeIcon 隐藏）、PopScope 禁止退出。
    expect(find.byIcon(LucideIcons.x), findsNothing);
    final popScope = tester.widget<PopScope>(
      find.descendant(
        of: find.byType(SetupWizardDialog),
        matching: find.byType(PopScope),
      ),
    );
    expect(popScope.canPop, isFalse);
  });

  testWidgets('路径校验与步骤导航：无效路径报错，有效路径进入下一步', (tester) async {
    await pumpWizard(tester);

    // 空路径：保存时校验失败，显示错误横幅且停留在当前步骤。
    await tester.runAsync(() async {
      await tester.tap(find.text('下一步'));
      await _waitFor(() => setupVm.clientDirError.value != null);
      await tester.pump();
    });
    expect(find.textContaining('请选择客户端目录'), findsOneWidget);
    expect(find.text('第 1 步：设置客户端目录'), findsOneWidget);

    // 无效路径：保存失败，显示错误横幅且停留在当前步骤。
    await tester.runAsync(() async {
      await tester.enterText(
        find.byType(ShadInput),
        p.join(tempDir.path, '不存在'),
      );
      await tester.tap(find.text('下一步'));
      await _waitFor(() => setupVm.clientDirError.value?.contains('不存在') ?? false);
      await tester.pump();
    });
    expect(find.textContaining('目录不存在'), findsOneWidget);
    expect(find.text('第 1 步：设置客户端目录'), findsOneWidget);

    // 有效路径：进入步骤 2。
    await tester.runAsync(() async {
      await tester.enterText(find.byType(ShadInput), clientRoot.path);
      await tester.tap(find.text('下一步'));
      await _waitFor(() => setupVm.clientDir.value != null);
      await tester.pump();
    });
    expect(find.text('第 2 步：设置服务端 DBC 目录'), findsOneWidget);
    expect(configData['client_dir'], clientRoot.path);
  });

  testWidgets('三步全流程：配置目录 → 导入 → 自动提取 → 进入应用', (tester) async {
    await pumpWizard(tester);

    // 步骤 1：客户端目录。
    await tester.runAsync(() async {
      await tester.enterText(find.byType(ShadInput), clientRoot.path);
      await tester.tap(find.text('下一步'));
      await _waitFor(() => setupVm.clientDir.value != null);
      await tester.pump();
    });
    expect(find.text('第 2 步：设置服务端 DBC 目录'), findsOneWidget);

    // 步骤 2：服务端 DBC 目录。
    await tester.runAsync(() async {
      await tester.enterText(find.byType(ShadInput), dbcDir.path);
      await tester.tap(find.text('下一步'));
      await _waitFor(() => setupVm.dbcPath.value != null);
      await tester.pump();
    });

    expect(find.text('第 3 步：导入 DBC 数据并提取游戏图标'), findsOneWidget);
    expect(find.text('开始导入'), findsOneWidget);

    // 开始导入 → 假同步工具立即成功 → 自动衔接真实图标提取（2 个图标）。
    await tester.runAsync(() async {
      await tester.tap(find.text('开始导入'));
      await _waitFor(
        () => iconVm.status.value == WorkflowStatus.succeeded,
      );
    });
    await tester.pump();

    expect(importVm.status.value, WorkflowStatus.succeeded);
    expect(iconVm.result.value?.extracted, 2);
    expect(find.text('进入应用'), findsOneWidget);
  });

  testWidgets('目录已配置且 DBC 已导入时跳过步骤 1/2，直达步骤 3 并自动提取', (tester) async {
    configData['client_dir'] = clientRoot.path;
    configData['dbc_path'] = dbcDir.path;

    await tester.runAsync(() async {
      await tester.pumpWidget(buildWizard());
      await _waitFor(
        () => iconVm.status.value == WorkflowStatus.succeeded,
      );
    });
    await tester.pump();

    expect(find.text('第 1 步：设置客户端目录'), findsNothing);
    expect(find.text('第 2 步：设置服务端 DBC 目录'), findsNothing);
    expect(find.text('第 3 步：导入 DBC 数据并提取游戏图标'), findsOneWidget);
    expect(find.text('进入应用'), findsOneWidget);
  });

  testWidgets('图标提取失败时显示错误、重试与退出应用', (tester) async {
    final noDataClient = Directory(p.join(tempDir.path, 'noData'))..createSync();
    configData['client_dir'] = noDataClient.path;
    configData['dbc_path'] = dbcDir.path;

    await tester.runAsync(() async {
      await tester.pumpWidget(buildWizard());
      await _waitFor(
        () => iconVm.status.value == WorkflowStatus.failed,
      );
    });
    await tester.pump();

    expect(find.text('重试'), findsOneWidget);
    expect(find.text('退出应用'), findsOneWidget);
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
