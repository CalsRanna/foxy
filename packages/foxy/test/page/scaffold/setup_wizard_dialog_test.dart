import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/model/dbc/dbc_sync_progress.dart';
import 'package:foxy/page/scaffold/setup_wizard_dialog.dart';
import 'package:foxy/router/router.dart';
import 'package:foxy/use_case/dbc/import_dbc_use_case.dart';
import 'package:foxy/use_case/game_asset/extract_game_icons_use_case.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:foxy/view_model/workflow/dbc_import_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/icon_extract_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:warcrafty/warcrafty.dart';

void main() {
  late Directory tempDir;
  late Directory clientRoot;
  late Directory serverRoot;
  late Directory outputDir;
  late Map<String, dynamic> configData;
  late _MemoryConfigUtil configUtil;
  late SetupStatusViewModel setupVm;
  late _FakeDbcSyncUtil dbcSync;
  late DbcImportWorkflowViewModel importVm;
  late IconExtractWorkflowViewModel iconVm;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_wizard_test_');
    clientRoot = Directory(p.join(tempDir.path, 'client'))..createSync();
    Directory(p.join(clientRoot.path, 'Data', 'zhCN'))
        .createSync(recursive: true);
    _createFakeClientMpq(p.join(clientRoot.path, 'Data', 'zhCN'));
    // Server root with a standard data/dbc layout, so the real
    // ServerDirResolver finds it when the wizard step 2 saves.
    serverRoot = Directory(p.join(tempDir.path, 'server'))..createSync();
    Directory(p.join(serverRoot.path, 'data', 'dbc'))
        .createSync(recursive: true);
    File(p.join(serverRoot.path, 'data', 'dbc', 'Spell.dbc')).createSync();
    outputDir = Directory(p.join(tempDir.path, 'out'))..createSync();

    configData = {};
    configUtil = _MemoryConfigUtil(configData);
    setupVm = SetupStatusViewModel(configUtil: configUtil);
    dbcSync = _FakeDbcSyncUtil();
    importVm = DbcImportWorkflowViewModel(
      useCase: ImportDbcUseCase(configUtil: configUtil, dbcSyncUtil: dbcSync),
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
      navigatorKey: FoxyRouter.router.navigatorKey,
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

  Future<void> dismissError(WidgetTester tester) async {
    await tester.pumpAndSettle();
    expect(find.text('错误'), findsOneWidget);
    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle();
    expect(find.text('错误'), findsNothing);
  }

  Future<void> openWizard(WidgetTester tester) async {
    await tester.pumpWidget(
      ShadApp(
        navigatorKey: FoxyRouter.router.navigatorKey,
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: ShadButton(
                onPressed: () => DialogUtil.show(
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
  }

  testWidgets(
    'First-time users start at step one and cannot dismiss the dialog',
    (tester) async {
      await pumpWizard(tester);

      expect(find.text('首次设置引导'), findsOneWidget);
      expect(
        tester.widget<ShadDialog>(find.byType(ShadDialog)).title,
        isA<Text>(),
      );
      expect(find.text('第 1 步：设置客户端目录'), findsOneWidget);
      expect(find.text('第 2 步：设置服务端目录'), findsNothing);
      expect(
        tester.widget<ShadButton>(find.widgetWithText(ShadButton, '浏览')).child,
        isA<Text>(),
      );

      // No close button (closeIcon hidden); PopScope blocks exit.
      expect(find.byIcon(LucideIcons.x), findsNothing);
      final popScope = tester.widget<PopScope>(
        find.descendant(
          of: find.byType(SetupWizardDialog),
          matching: find.byType(PopScope),
        ),
      );
      expect(popScope.canPop, isFalse);
    },
  );

  testWidgets(
    'Invalid paths display an error and valid paths advance to the next step',
    (tester) async {
      await pumpWizard(tester);

      // Empty path: validation fails on save, an error dialog opens, and the
      // wizard stays on the current step.
      await tester.runAsync(() async {
        await tester.tap(find.text('下一步'));
        await _waitFor(() => setupVm.clientDirError.value != null);
        await tester.pump();
      });
      expect(find.textContaining('请选择客户端目录'), findsOneWidget);
      await dismissError(tester);
      expect(find.text('第 1 步：设置客户端目录'), findsOneWidget);

      // Invalid path: save fails, an error dialog opens, and the wizard
      // stays on the current step.
      await tester.runAsync(() async {
        await tester.enterText(
          find.byType(ShadInput),
          p.join(tempDir.path, '不存在'),
        );
        await tester.tap(find.text('下一步'));
        await _waitFor(
          () => setupVm.clientDirError.value?.contains('不存在') ?? false,
        );
        await tester.pump();
      });
      expect(find.textContaining('目录不存在'), findsOneWidget);
      await dismissError(tester);
      expect(find.text('第 1 步：设置客户端目录'), findsOneWidget);

      // Valid path: proceed to step 2.
      await tester.runAsync(() async {
        await tester.enterText(find.byType(ShadInput), clientRoot.path);
        await tester.tap(find.text('下一步'));
        await _waitFor(() => setupVm.clientDir.value != null);
        await tester.pump();
      });
      expect(find.text('第 2 步：设置服务端目录'), findsOneWidget);
      expect(configData['client_dir'], clientRoot.path);
    },
  );

  Future<void> saveDirectory(WidgetTester tester, Directory directory) async {
    await tester.runAsync(() async {
      await tester.enterText(find.byType(ShadInput), directory.path);
      await tester.tap(find.text('下一步'));
      await _waitFor(
        () =>
            setupVm.clientDir.value == directory.path ||
            setupVm.serverDir.value == directory.path,
      );
    });
    await tester.pumpAndSettle();
  }

  void expectSingleEntryAction() {
    final wizard = find.byType(SetupWizardDialog);
    expect(find.text('第 3 步：完成设置'), findsOneWidget);
    final buttons = find.descendant(
      of: wizard,
      matching: find.byType(ShadButton),
    );
    expect(buttons, findsOneWidget);
    expect(
      find.descendant(of: buttons, matching: find.text('进入应用')),
      findsOneWidget,
    );
  }

  testWidgets(
    'Step three offers only entry to the app and runs both tasks in one progress dialog',
    (tester) async {
      dbcSync.tablesReady = false;
      final finishImport = Completer<void>();
      dbcSync.importGate = finishImport.future;
      await openWizard(tester);
      await tester.pumpAndSettle();
      await saveDirectory(tester, clientRoot);
      await saveDirectory(tester, serverRoot);

      expectSingleEntryAction();
      expect(dbcSync.tableChecks, 0);
      expect(iconVm.status.value, WorkflowStatus.idle);

      await tester.runAsync(() async {
        await tester.tap(find.text('进入应用'));
        await _waitFor(() => importVm.progress.value == 0.5);
      });
      await tester.pumpAndSettle();
      expect(find.widgetWithText(ShadDialog, '正在导入 DBC'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(find.text('50%'), findsOneWidget);
      expect(iconVm.status.value, WorkflowStatus.idle);

      await tester.runAsync(() async {
        finishImport.complete();
        await _waitFor(() => iconVm.status.value == WorkflowStatus.succeeded);
      });
      await tester.pumpAndSettle();

      expect(importVm.status.value, WorkflowStatus.succeeded);
      expect(dbcSync.importedDirectories, [
        p.join(serverRoot.path, 'data', 'dbc'),
      ]);
      expect(iconVm.result.value?.extracted, 2);
      expect(find.byType(SetupWizardDialog), findsNothing);
      expect(find.byType(ShadDialog), findsNothing);
    },
  );

  testWidgets(
    'Ready DBC files are preserved and step three remains usable in a narrow window',
    (tester) async {
      tester.view.physicalSize = const Size(480, 720);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await openWizard(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.text('跳过'));
      await tester.pumpAndSettle();
      await saveDirectory(tester, serverRoot);

      expectSingleEntryAction();
      expect(dbcSync.tableChecks, 0);
      await tester.tap(find.text('进入应用'));
      await tester.pumpAndSettle();

      expect(dbcSync.tableChecks, 1);
      expect(dbcSync.importedDirectories, isEmpty);
      expect(iconVm.status.value, WorkflowStatus.idle);
      expect(find.byType(SetupWizardDialog), findsNothing);
    },
  );

  testWidgets('A server-only configuration imports DBC files only', (
    tester,
  ) async {
    dbcSync.tablesReady = false;
    await openWizard(tester);
    await tester.pumpAndSettle();
    await tester.tap(find.text('跳过'));
    await tester.pumpAndSettle();
    await saveDirectory(tester, serverRoot);

    expectSingleEntryAction();
    expect(dbcSync.importedDirectories, isEmpty);
    await tester.runAsync(() async {
      await tester.tap(find.text('进入应用'));
      await _waitFor(() => importVm.status.value == WorkflowStatus.succeeded);
    });
    await tester.pumpAndSettle();

    expect(dbcSync.importedDirectories, [
      p.join(serverRoot.path, 'data', 'dbc'),
    ]);
    expect(iconVm.status.value, WorkflowStatus.idle);
    expect(find.byType(SetupWizardDialog), findsNothing);
  });

  testWidgets(
    'Skipping both directories enters the app and saves the choices',
    (tester) async {
      await openWizard(tester);
      await tester.pumpAndSettle();
      await tester.tap(find.text('跳过'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('跳过'));
      await tester.pumpAndSettle();

      expectSingleEntryAction();
      await tester.tap(find.text('进入应用'));
      await tester.pumpAndSettle();

      expect(find.byType(ShadDialog), findsNothing);
      expect(dbcSync.tableChecks, 0);
      expect(iconVm.status.value, WorkflowStatus.idle);
      final reloaded = SetupStatusViewModel(configUtil: configUtil);
      await reloaded.prepare();
      expect(reloaded.isSetupComplete, isTrue);
      expect(reloaded.isClientDirConfigured, isFalse);
      expect(reloaded.isServerDirConfigured, isFalse);
    },
  );

  testWidgets('A client-only configuration extracts icons only', (
    tester,
  ) async {
    await openWizard(tester);
    await tester.pumpAndSettle();
    await tester.tap(find.text('跳过'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('上一步'));
    await tester.pumpAndSettle();
    await saveDirectory(tester, clientRoot);
    await tester.tap(find.text('跳过'));
    await tester.pumpAndSettle();

    expectSingleEntryAction();
    expect(iconVm.status.value, WorkflowStatus.idle);
    await tester.runAsync(() async {
      await tester.tap(find.text('进入应用'));
      await _waitFor(() => iconVm.status.value == WorkflowStatus.succeeded);
    });
    await tester.pumpAndSettle();

    expect(dbcSync.tableChecks, 0);
    expect(iconVm.result.value?.extracted, 2);
    expect(find.byType(SetupWizardDialog), findsNothing);
  });

  testWidgets(
    'Icon extraction is attempted after import failure and acknowledging the error allows entry',
    (tester) async {
      dbcSync.tablesReady = false;
      dbcSync.importFails = true;
      await openWizard(tester);
      await tester.pumpAndSettle();
      await saveDirectory(tester, clientRoot);
      await saveDirectory(tester, serverRoot);

      await tester.runAsync(() async {
        await tester.tap(find.text('进入应用'));
        await _waitFor(() => iconVm.status.value == WorkflowStatus.succeeded);
      });
      await tester.pumpAndSettle();

      expect(importVm.status.value, WorkflowStatus.failed);
      expect(find.textContaining('可在设置中重试'), findsOneWidget);
      await tester.runAsync(() => dismissError(tester));
      await tester.pumpAndSettle();
      expect(find.byType(SetupWizardDialog), findsNothing);
    },
  );
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

/// Fake DbcSyncUtil for table checks and import progress without MySQL.
final class _FakeDbcSyncUtil extends DbcSyncUtil {
  bool tablesReady = true;
  int tableChecks = 0;
  bool importFails = false;
  Future<void>? importGate;
  final importedDirectories = <String>[];

  @override
  Future<List<DbcTableCheckResult>> checkTables() async {
    tableChecks++;
    return [
      for (final definition in DbcDefinitions.all)
        DbcTableCheckResult(
          tableName: definition.tableName,
          state: tablesReady ? DbcTableState.ready : DbcTableState.missing,
        ),
    ];
  }

  @override
  Stream<DbcSyncProgress> import({
    required String directory,
    required MysqlConfig mysqlConfig,
  }) async* {
    importedDirectories.add(directory);
    yield const DbcSyncCount(
      operation: DbcSyncOperation.import,
      fileName: 'Spell.dbc',
      completedFiles: 1,
      totalFiles: 2,
    );
    await importGate;
    yield DbcSyncResult(
      operation: DbcSyncOperation.import,
      completed: 1,
      skipped: 0,
      errors: [
        if (importFails)
          const DbcSyncError(
            stage: DbcSyncStage.writing,
            message: 'test error',
          ),
      ],
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
