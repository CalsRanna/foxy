import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/page/setting/setup_wizard_dialog.dart';
import 'package:foxy/page/workflow/workflow_status.dart';
import 'package:foxy/use_case/dbc/import_dbc_use_case.dart';
import 'package:foxy/use_case/game_asset/extract_game_icons_use_case.dart';
import 'package:foxy/view_model/dbc_import_workflow_view_model.dart';
import 'package:foxy/view_model/icon_extract_workflow_view_model.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:warcrafty/warcrafty.dart';

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

    // No close button (closeIcon hidden); PopScope blocks exit.
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

    // Empty path: validation fails on save, an error banner shows, and the
    // wizard stays on the current step.
    await tester.runAsync(() async {
      await tester.tap(find.text('下一步'));
      await _waitFor(() => setupVm.clientDirError.value != null);
      await tester.pump();
    });
    expect(find.textContaining('请选择客户端目录'), findsOneWidget);
    expect(find.text('第 1 步：设置客户端目录'), findsOneWidget);

    // Invalid path: save fails, an error banner shows, and the wizard
    // stays on the current step.
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

    // Valid path: proceed to step 2.
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

    // Step 1: client directory.
    await tester.runAsync(() async {
      await tester.enterText(find.byType(ShadInput), clientRoot.path);
      await tester.tap(find.text('下一步'));
      await _waitFor(() => setupVm.clientDir.value != null);
      await tester.pump();
    });
    expect(find.text('第 2 步：设置服务端 DBC 目录'), findsOneWidget);

    // Step 2: server DBC directory.
    await tester.runAsync(() async {
      await tester.enterText(find.byType(ShadInput), dbcDir.path);
      await tester.tap(find.text('下一步'));
      await _waitFor(() => setupVm.dbcPath.value != null);
      await tester.pump();
    });

    expect(find.text('第 3 步：导入 DBC 数据并提取游戏图标'), findsOneWidget);
    expect(find.text('开始导入'), findsOneWidget);

    // Start import → the fake sync tool succeeds immediately → seamlessly
    // continues into the real icon extraction (2 icons).
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

  testWidgets('导入与提取全部完成后，「进入应用」可关闭向导对话框', (tester) async {
    // Matches the real scenario: the wizard opens as a dialog route with
    // an outer PopScope(canPop: false) intercepting barrier/Esc closes.
    // Regression: the button must use pop(), not maybePop() — otherwise
    // PopScope intercepts it and the wizard cannot be closed.
    configData['client_dir'] = clientRoot.path;
    configData['dbc_path'] = dbcDir.path;

    await tester.runAsync(() async {
      await tester.pumpWidget(
        ShadApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: ShadButton(
                  onPressed: () => showFoxyDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => SetupWizardDialog(
                      setupVm: setupVm,
                      importVm: importVm,
                      iconVm: iconVm,
                    ),
                  ),
                  child: const Text('打开向导'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('打开向导'));
      await tester.pump();
      await _waitFor(() => iconVm.status.value == WorkflowStatus.succeeded);
    });
    await tester.pump();

    expect(find.text('进入应用'), findsOneWidget);

    await tester.tap(find.text('进入应用'));
    await tester.pumpAndSettle();

    expect(find.byType(SetupWizardDialog), findsNothing);
    expect(find.text('进入应用'), findsNothing);
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

/// Fake DbcSyncUtil: all table checks pass and import succeeds immediately
/// (no real MySQL/isolate).
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

/// In-memory ConfigUtil: no real IO for reads or writes, so widget tests
/// finish without runAsync.
final class _MemoryConfigUtil extends ConfigUtil {
  final Map<String, dynamic> data;

  _MemoryConfigUtil(this.data);

  @override
  String get configPath => 'memory:config.yaml';

  @override
  Future<Map<String, dynamic>> load() async => Map<String, dynamic>.of(data);

  @override
  Future<void> update(Map<String, dynamic> values) async {
    data.addAll(values);
  }
}
