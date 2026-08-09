import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_registry.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_worker.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/infrastructure/dbc/mpq_export_worker.dart';
import 'package:foxy/page/setting/setting_page.dart';
import 'package:foxy/use_case/dbc/export_dbc_use_case.dart';
import 'package:foxy/use_case/dbc/import_dbc_use_case.dart';
import 'package:foxy/use_case/game_asset/extract_game_icons_use_case.dart';
import 'package:foxy/use_case/mpq/mpq_export_use_case.dart';
import 'package:foxy/view_model/dbc_export_workflow_view_model.dart';
import 'package:foxy/view_model/dbc_import_workflow_view_model.dart';
import 'package:foxy/view_model/icon_extract_workflow_view_model.dart';
import 'package:foxy/view_model/mpq_export_workflow_view_model.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:foxy/view_model/update_view_model.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// Regression tests for the setting page's DBC/MPQ busy buttons.
///
/// Reported bug: after an MPQ (or DBC) export completes, the DBC import/
/// export buttons stayed disabled forever. Root cause: the busy
/// computation `a.isRunning || b.isRunning || c.isRunning` short-circuits
/// once any task is busy (while the shared DbcSyncUtil runs, the import
/// VM's `isRunning` is true), so the signals read later in the chain get
/// dropped from the Watch's dependency set and the buttons never rebuild
/// when that task finishes.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late DbcSyncUtil util;
  late DbcImportWorkflowViewModel importVm;
  late DbcExportWorkflowViewModel exportVm;
  late MpqExportWorkflowViewModel mpqVm;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_setting_flow_');
    final cfg = _MemoryConfigUtil({
      'mpq_dir': tempDir.path,
      'dbc_dir': tempDir.path,
    });
    util = DbcSyncUtil(
      exportWorkerEntry: _SuccessWorker.run,
      mpqWorkerEntry: _SuccessMpqWorker.run,
    );
    final registry = _FakeRegistry();

    GetIt.instance.reset();
    GetIt.instance.registerSingleton<ConfigUtil>(cfg);
    GetIt.instance.registerSingleton<DbcSyncUtil>(util);
    GetIt.instance.registerSingleton<DbcExportRegistry>(registry);

    final importUseCase = ImportDbcUseCase(
      configUtil: cfg,
      dbcSyncUtil: util,
    );
    final exportUseCase = ExportDbcUseCase(
      registry: registry,
      dbcSyncUtil: util,
      configUtil: cfg,
    );
    final mpqUseCase = MpqExportUseCase(
      registry: registry,
      dbcSyncUtil: util,
      configUtil: cfg,
    );
    final iconUseCase = ExtractGameIconsUseCase(
      configUtil: cfg,
      outputDir: tempDir.path,
      workerEntry: (args) async {},
    );

    importVm = DbcImportWorkflowViewModel(
      useCase: importUseCase,
      configUtil: cfg,
    );
    exportVm = DbcExportWorkflowViewModel(
      useCase: exportUseCase,
      configUtil: cfg,
    );
    mpqVm = MpqExportWorkflowViewModel(
      useCase: mpqUseCase,
      configUtil: cfg,
    );
    final iconVm = IconExtractWorkflowViewModel(
      useCase: iconUseCase,
      configUtil: cfg,
    );

    GetIt.instance.registerSingleton(importVm);
    GetIt.instance.registerSingleton(exportVm);
    GetIt.instance.registerSingleton(mpqVm);
    GetIt.instance.registerSingleton(iconVm);
    GetIt.instance.registerSingleton(
      SetupStatusViewModel(
        configUtil: cfg,
        findDbcDir: (_) async => tempDir.path,
        findMpqDir: (_) => tempDir.path,
      ),
    );
    GetIt.instance.registerSingleton(UpdateViewModel());
  });

  tearDown(() {
    GetIt.instance.reset();
    try {
      tempDir.deleteSync(recursive: true);
    } catch (_) {}
  });

  Finder dbcImportButton() => find
      .ancestor(
        of: find.byIcon(LucideIcons.fileInput),
        matching: find.byType(ShadButton),
      )
      .first;

  Finder dbcExportButton() => find
      .ancestor(
        of: find.byIcon(LucideIcons.fileOutput),
        matching: find.byType(ShadButton),
      )
      .first;

  Finder mpqExportButton() => find
      .ancestor(
        of: find.byIcon(LucideIcons.archive),
        matching: find.byType(ShadButton),
      )
      .first;

  ShadButton buttonOf(WidgetTester tester, Finder finder) =>
      tester.widget<ShadButton>(finder);

  testWidgets('短路回归：共享 util 忙时重算，任务结束必须恢复按钮', (tester) async {
    var rebuilds = 0;
    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: Column(
            children: [
              // 与设置页 DBC 区相同的 busy 组合。
              Watch((_) {
                rebuilds++;
                final busy = importVm.isRunning ||
                    exportVm.isRunning ||
                    mpqVm.isRunning;
                return Text('dbc:${busy ? 'busy' : 'free'}');
              }),
              // 与设置页 MPQ 区相同的组合（双 Watch 共享信号）。
              Watch((_) {
                final busy = mpqVm.isRunning ||
                    importVm.isRunning ||
                    exportVm.isRunning;
                return Text('mpq:${busy ? 'busy' : 'free'}');
              }),
            ],
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(rebuilds, 1);
    expect(find.text('dbc:free'), findsOneWidget);

    // 任务开始：共享 util 忙（importVm.isRunning 因此为 true，短路掉
    // 后续读取）+ MPQ 状态 running。
    util.running.value = true;
    mpqVm.status.value = WorkflowStatus.running;
    await tester.pump();
    expect(rebuilds, 2, reason: '任务开始必须触发重建');
    expect(find.text('dbc:busy'), findsOneWidget);
    expect(find.text('mpq:busy'), findsOneWidget);

    // 任务结束：util 复位 + MPQ succeeded。修复前：短路已丢弃
    // mpqVm.status 依赖，若 util.running 也未作为依赖被跟踪，Watch
    // 永不重建，按钮永远禁用。
    util.running.value = false;
    mpqVm.status.value = WorkflowStatus.succeeded;
    for (var i = 0; i < 5; i++) {
      await tester.pump();
    }
    expect(
      rebuilds,
      greaterThanOrEqualTo(3),
      reason: '任务结束必须触发重建（rebuilds=$rebuilds）',
    );
    expect(find.text('dbc:free'), findsOneWidget);
    expect(find.text('mpq:free'), findsOneWidget);
  });

  testWidgets('MPQ 导出完成后 DBC 导入/导出按钮恢复可用', (tester) async {
    await tester.pumpWidget(
      const ShadApp(home: Scaffold(body: SettingPage())),
    );
    await tester.pump();
    await tester.pump();

    // 初始状态：三个按钮均可点击。
    expect(buttonOf(tester, dbcImportButton()).onPressed, isNotNull);
    expect(buttonOf(tester, dbcExportButton()).onPressed, isNotNull);
    expect(buttonOf(tester, mpqExportButton()).onPressed, isNotNull);

    // 直接驱动 MPQ 工作流完整跑一遍（真实 isolate + 脚本化成功 worker）。
    await tester.runAsync(() async {
      await mpqVm.prepare();
      mpqVm.setOutputDirectory(tempDir.path);
      mpqVm.setFileName('patch-zhCN-5.mpq');
      await mpqVm.start();
    });
    expect(mpqVm.status.value, WorkflowStatus.succeeded);
    await tester.pump();

    // VM 层状态必须已复位（与 dbc_sync_util_test 验证一致）。
    expect(mpqVm.isRunning, isFalse, reason: 'MPQ VM 必须已复位');
    expect(exportVm.isRunning, isFalse, reason: '导出 VM 必须已复位');
    expect(importVm.isRunning, isFalse, reason: '导入 VM 必须已复位');
    expect(util.isRunning, isFalse, reason: 'DbcSyncUtil 必须已复位');

    // 多次 pump，排除一帧时序问题。
    for (var i = 0; i < 5; i++) {
      await tester.pump();
    }

    // 关键断言：导出完成后按钮必须恢复可用（bug 表现为一直置灰）。
    expect(
      buttonOf(tester, dbcImportButton()).onPressed,
      isNotNull,
      reason: 'MPQ 导出完成后「导入 DBC」按钮必须恢复可用',
    );
    expect(
      buttonOf(tester, dbcExportButton()).onPressed,
      isNotNull,
      reason: 'MPQ 导出完成后「导出 DBC」按钮必须恢复可用',
    );
    expect(buttonOf(tester, mpqExportButton()).onPressed, isNotNull);

    // 点击「导出 DBC」应能打开对话框。
    await tester.tap(dbcExportButton());
    await tester.pump();
    await tester.pump();
    expect(find.text('导出 DBC'), findsOneWidget);
  });
}

/// Scripted success worker for the DBC-export entry: registers the control
/// port, emits one count, then a success result, and exits.
final class _SuccessWorker {
  static Future<void> run(DbcExportWorkerArgs args) async {
    final cancelPort = ReceivePort();
    final sub = cancelPort.listen((_) {});
    args.sendPort.send(('control', cancelPort.sendPort));
    args.sendPort.send(('status', 'scanning', 'ok', null));
    args.sendPort.send(('count', 'SpellDuration.dbc', 1, 1, 3, 3));
    args.sendPort.send(('result', 1, 0, <Map<String, String?>>[], false));
    await sub.cancel();
    cancelPort.close();
  }
}

/// MPQ worker entry: same scripted body with the MPQ args record shape.
final class _SuccessMpqWorker {
  static Future<void> run(MpqExportWorkerArgs args) async {
    final cancelPort = ReceivePort();
    final sub = cancelPort.listen((_) {});
    args.sendPort.send(('control', cancelPort.sendPort));
    args.sendPort.send(('status', 'scanning', 'ok', null));
    args.sendPort.send(('count', 'SpellDuration.dbc', 1, 1, 3, 3));
    args.sendPort.send(('result', 1, 0, <Map<String, String?>>[], false));
    await sub.cancel();
    cancelPort.close();
  }
}

/// Registry stub: no GetIt resolution, no DB access.
final class _FakeRegistry implements DbcExportRegistry {
  @override
  bool contains(String tableName) => true;

  @override
  Future<DbcExportCountResult> countRows(String tableName) async =>
      const DbcExportCountResult.success(1);

  @override
  Future<List<Map<String, dynamic>>> loadRows(String tableName) async => [
    {'ID': 1},
  ];
}

/// In-memory ConfigUtil (no real IO), mirroring the wizard-test fake.
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
