import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_worker.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/infrastructure/mpq/mpq_export_worker.dart';
import 'package:foxy/page/setting/agent_provider_dialog.dart';
import 'package:foxy/page/setting/setting_page.dart';
import 'package:foxy/repository/dbc_export_registry.dart';
import 'package:foxy/repository/locale_query_settings.dart';
import 'package:foxy/router/router.dart';
import 'package:foxy/router/setting_section.dart';
import 'package:foxy/use_case/agent/agent_provider_config_use_case.dart';
import 'package:foxy/use_case/combined/combined_export_use_case.dart';
import 'package:foxy/use_case/dbc/export_dbc_use_case.dart';
import 'package:foxy/use_case/dbc/import_dbc_use_case.dart';
import 'package:foxy/use_case/game_asset/extract_game_icons_use_case.dart';
import 'package:foxy/use_case/mpq/mpq_export_use_case.dart';
import 'package:foxy/view_model/foxy_state_view_model.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:foxy/view_model/update_view_model.dart';
import 'package:foxy/view_model/workflow/combined_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/dbc_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/dbc_import_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/icon_extract_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/mpq_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:foxy_game_file/foxy_game_file.dart';
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
/// dropped from the SignalBuilder's dependency set and the buttons never rebuild
/// when that task finishes.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late DbcSyncUtil util;
  late DbcImportWorkflowViewModel importVm;
  late DbcExportWorkflowViewModel exportVm;
  late MpqExportWorkflowViewModel mpqVm;
  late CombinedExportWorkflowViewModel combinedVm;
  late _MemoryConfigUtil cfg;
  late FoxyStateViewModel stateVm;
  late LocaleQuerySettings localeSettings;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_setting_flow_');
    cfg = _MemoryConfigUtil({'mpq_dir': tempDir.path, 'dbc_dir': tempDir.path});
    util = DbcSyncUtil(
      exportWorkerEntry: _SuccessWorker.run,
      mpqWorkerEntry: _SuccessMpqWorker.run,
    );
    final registry = _FakeRegistry();

    GetIt.instance.reset();
    GetIt.instance.registerSingleton<ConfigUtil>(cfg);
    GetIt.instance.registerSingleton(AgentProviderConfigUseCase(cfg));
    localeSettings = LocaleQuerySettings();
    GetIt.instance.registerSingleton(localeSettings);
    stateVm = FoxyStateViewModel();
    GetIt.instance.registerSingleton(stateVm);
    stateVm.setLocaleSettings(hasLocaleTables: true, localeEnabled: true);
    GetIt.instance.registerSingleton<DbcSyncUtil>(util);
    GetIt.instance.registerSingleton<DbcExportRegistry>(registry);

    final importUseCase = ImportDbcUseCase(configUtil: cfg, dbcSyncUtil: util);
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
    final combinedUseCase = CombinedExportUseCase(
      registry: registry,
      dbcSyncUtil: util,
      configUtil: cfg,
    );
    final iconUseCase = ExtractGameIconsUseCase(
      configUtil: cfg,
      outputDir: tempDir.path,
      workerEntry: _SuccessIconWorker.run,
    );

    importVm = _RunningDbcImportViewModel(
      useCase: importUseCase,
      configUtil: cfg,
    );
    exportVm = DbcExportWorkflowViewModel(
      useCase: exportUseCase,
      configUtil: cfg,
    );
    mpqVm = MpqExportWorkflowViewModel(useCase: mpqUseCase, configUtil: cfg);
    combinedVm = CombinedExportWorkflowViewModel(
      useCase: combinedUseCase,
      configUtil: cfg,
    );
    final iconVm = IconExtractWorkflowViewModel(
      useCase: iconUseCase,
      configUtil: cfg,
    );

    GetIt.instance.registerSingleton(importVm);
    GetIt.instance.registerSingleton(exportVm);
    GetIt.instance.registerSingleton(mpqVm);
    GetIt.instance.registerSingleton(combinedVm);
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

  Finder dbcImportButton() => find.widgetWithText(ShadButton, '导入 DBC');

  Finder dbcExportButton() => find.widgetWithText(ShadButton, '导出 DBC');

  Finder mpqExportButton() => find.widgetWithText(ShadButton, '导出 MPQ');

  Finder combinedExportButton() => find.widgetWithText(ShadButton, '一键导出');

  ShadButton buttonOf(WidgetTester tester, Finder finder) =>
      tester.widget<ShadButton>(finder);

  final preferencesPage = ShadApp(
    navigatorKey: FoxyRouter.router.navigatorKey,
    home: const Scaffold(
      body: SettingPage(initialSection: SettingSection.preferences),
    ),
  );
  final dataPage = ShadApp(
    navigatorKey: FoxyRouter.router.navigatorKey,
    home: const Scaffold(
      body: SettingPage(initialSection: SettingSection.data),
    ),
  );

  testWidgets('Settings categories and actions adapt to desktop window width', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1215, 726));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const ShadApp(home: Scaffold(body: SettingPage())));
    final setup = GetIt.instance.get<SetupStatusViewModel>();
    setup.serverDir.value = tempDir.path;
    setup.serverDirExists.value = true;
    setup.dbcPath.value = tempDir.path;
    await tester.pump();

    expect(find.text('目录设置'), findsOneWidget);
    expect(find.text(tempDir.path), findsOneWidget);
    expect(find.byTooltip(tempDir.path), findsNothing);
    expect(find.textContaining('DBC 目录：'), findsNothing);
    expect(find.text('提取游戏图标'), findsOneWidget);
    expect(find.text('一键导出'), findsNothing);
    final environmentLabels = find.text('游戏环境');
    final sidebarTitle = find.text('设置');
    expect(
      tester.widget<Text>(environmentLabels.last).style,
      tester.widget<Text>(sidebarTitle).style,
    );
    expect(
      tester.getTopLeft(environmentLabels.last).dy,
      tester.getTopLeft(sidebarTitle).dy,
    );
    expect(
      tester.getTopLeft(environmentLabels.last).dy,
      lessThan(tester.getTopLeft(environmentLabels.first).dy),
    );

    await tester.tap(find.widgetWithText(ShadButton, '数据工具'));
    await tester.pumpAndSettle();
    expect(find.text('目录设置'), findsNothing);
    expect(combinedExportButton().hitTestable(), findsOneWidget);

    final exportButton = dbcExportButton();
    final minimumWidthRight = tester.getTopRight(exportButton).dx;
    await tester.binding.setSurfaceSize(const Size(1535, 726));
    await tester.pumpAndSettle();
    expect(tester.getTopRight(exportButton).dx - minimumWidthRight, 320);

    await tester.tap(find.widgetWithText(ShadButton, '关于 Foxy'));
    await tester.pumpAndSettle();
    expect(
      find.widgetWithText(ShadButton, '检查更新').hitTestable(),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Setting or changing a game directory opens the system picker', (
    tester,
  ) async {
    const channel = MethodChannel('plugins.flutter.io/file_selector');
    final messenger = tester.binding.defaultBinaryMessenger;
    final initialDirectories = <Object?>[];
    String? selection;
    messenger.setMockMethodCallHandler(channel, (call) async {
      expect(call.method, 'getDirectoryPath');
      initialDirectories.add(call.arguments['initialDirectory']);
      return selection;
    });
    addTearDown(() => messenger.setMockMethodCallHandler(channel, null));

    await tester.pumpWidget(const ShadApp(home: Scaffold(body: SettingPage())));
    final configure = find.widgetWithText(ShadButton, '浏览目录');
    await tester.tap(configure.first);
    await tester.pumpAndSettle();
    expect(initialDirectories, [null]);
    expect(find.byType(ShadDialog), findsNothing);
    expect(cfg.data['client_dir'], isNull);

    final setup = GetIt.instance.get<SetupStatusViewModel>();
    selection = tempDir.path;
    await tester.runAsync(() async {
      final saved = Completer<void>();
      final unsubscribe = setup.serverDir.subscribe((path) {
        if (path == tempDir.path) saved.complete();
      });
      try {
        await tester.tap(configure.last);
        await saved.future.timeout(const Duration(seconds: 5));
      } finally {
        unsubscribe();
      }
    });
    await tester.pumpAndSettle();
    expect(initialDirectories, [null, null]);
    expect(cfg.data['server_dir'], tempDir.path);
    expect(find.text(tempDir.path), findsOneWidget);
    expect(find.byType(ShadDialog), findsNothing);

    selection = null;
    await tester.tap(configure.last);
    await tester.pumpAndSettle();
    expect(initialDirectories, [null, null, tempDir.path]);
    expect(cfg.data['server_dir'], tempDir.path);
    expect(find.byType(ShadDialog), findsNothing);
  });

  testWidgets('One click starts and completes icon extraction', (tester) async {
    cfg.data['client_dir'] = tempDir.path;
    await tester.pumpWidget(const ShadApp(home: Scaffold(body: SettingPage())));
    final extract = find.widgetWithText(ShadButton, '提取');
    await tester.ensureVisible(extract);
    await tester.pumpAndSettle();

    final iconVm = GetIt.instance.get<IconExtractWorkflowViewModel>();
    await tester.runAsync(() async {
      final finished = Completer<void>();
      final unsubscribe = iconVm.status.subscribe((status) {
        if (status == WorkflowStatus.succeeded) finished.complete();
      });
      try {
        await tester.tap(extract);
        await tester.pump();
        await tester.pump();
        expect(find.text('开始提取'), findsNothing);
        await finished.future.timeout(const Duration(seconds: 5));
      } finally {
        unsubscribe();
      }
    });
    await tester.pumpAndSettle();

    expect(find.text('提取完成'), findsOneWidget);
    expect(cfg.data['icons_extracted'], isTrue);
  });

  testWidgets(
    'Settings can open and save an existing model provider configuration',
    (tester) async {
      cfg.data.addAll({
        'agent_base_url': 'https://example.test/v1',
        'agent_model': 'old-model',
        'agent_api_key': 'test-key',
      });
      await tester.pumpWidget(
        ShadApp(
          navigatorKey: FoxyRouter.router.navigatorKey,
          home: const Scaffold(body: SettingPage()),
        ),
      );
      await tester.tap(find.widgetWithText(ShadButton, '编辑偏好'));
      await tester.pumpAndSettle();
      final configure = find.widgetWithText(ShadButton, '配置');
      await tester.ensureVisible(configure);
      await tester.tap(configure);
      await tester.pumpAndSettle();

      final dialog = find.byType(AgentProviderDialog);
      final inputs = find.descendant(
        of: dialog,
        matching: find.byType(ShadInput),
      );
      expect(
        tester.widget<ShadInput>(inputs.at(0)).controller?.text,
        'https://example.test/v1',
      );
      expect(
        tester.widget<ShadInput>(inputs.at(1)).controller?.text,
        'old-model',
      );
      expect(tester.widget<ShadInput>(inputs.at(2)).obscureText, isTrue);
      final reasoningSwitch = find.descendant(
        of: dialog,
        matching: find.byType(ShadSwitch),
      );
      expect(tester.widget<ShadSwitch>(reasoningSwitch).value, isFalse);
      await tester.tap(reasoningSwitch);

      await tester.enterText(inputs.at(1), 'new-model');
      await tester.tap(find.widgetWithText(ShadButton, '保存'));
      await tester.pumpAndSettle();

      expect(dialog, findsNothing);
      expect(cfg.data['agent_model'], 'new-model');
      expect(cfg.data['agent_api_key'], 'test-key');
      expect(cfg.data['agent_request_reasoning_summary'], isTrue);
      final provider = await GetIt.instance
          .get<AgentProviderConfigUseCase>()
          .load();
      expect(provider?.requestReasoningSummary, isTrue);
      expect(find.text('模型服务商配置已保存'), findsOneWidget);
    },
  );

  testWidgets(
    'The locale toggle persists its value and updates subsequent queries',
    (tester) async {
      await tester.pumpWidget(preferencesPage);
      final toggle = find.byType(ShadSwitch);
      expect(tester.widget<ShadSwitch>(toggle).value, isTrue);

      await tester.tap(toggle);
      await tester.pumpAndSettle();

      expect(cfg.data['locale_enabled'], isFalse);
      expect(stateVm.localeEnabled.value, isFalse);
      expect(localeSettings.localeEnabled, isFalse);
      expect(tester.widget<ShadSwitch>(toggle).value, isFalse);
      expect(cfg.data['dbc_dir'], tempDir.path);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpWidget(preferencesPage);
      expect(tester.widget<ShadSwitch>(toggle).value, isFalse);

      await tester.tap(toggle);
      await tester.pumpAndSettle();
      expect(cfg.data['locale_enabled'], isTrue);
      expect(stateVm.localeEnabled.value, isTrue);
      expect(localeSettings.localeEnabled, isTrue);
    },
  );

  testWidgets('The locale toggle is disabled when locale tables are missing', (
    tester,
  ) async {
    stateVm.setLocaleSettings(hasLocaleTables: false, localeEnabled: false);
    await tester.pumpWidget(preferencesPage);

    final toggle = tester.widget<ShadSwitch>(find.byType(ShadSwitch));
    expect(toggle.value, isFalse);
    expect(toggle.enabled, isFalse);
    expect(find.text('当前数据库未检测到本地化表。'), findsOneWidget);
    expect(cfg.data.containsKey('locale_enabled'), isFalse);
  });

  testWidgets(
    'A failed locale settings save preserves the previous toggle and query state',
    (tester) async {
      cfg.failUpdate = true;
      await tester.pumpWidget(preferencesPage);
      await tester.tap(find.byType(ShadSwitch));
      await tester.pumpAndSettle();

      final toggle = tester.widget<ShadSwitch>(find.byType(ShadSwitch));
      expect(toggle.value, isTrue);
      expect(toggle.enabled, isTrue);
      expect(stateVm.localeEnabled.value, isTrue);
      expect(localeSettings.localeEnabled, isTrue);
      expect(cfg.data.containsKey('locale_enabled'), isFalse);
      expect(find.textContaining('保存本地化设置失败'), findsOneWidget);
      expect(find.text('错误'), findsOneWidget);
      await tester.tap(find.text('确定'));
      await tester.pumpAndSettle();
      expect(find.textContaining('保存本地化设置失败'), findsNothing);
    },
  );

  testWidgets(
    'Recomputing while the shared utility is busy re-enables buttons when the job ends',
    (tester) async {
      var rebuilds = 0;
      await tester.pumpWidget(
        ShadApp(
          home: Scaffold(
            body: Column(
              children: [
                // Same busy condition as the DBC section of Settings.
                SignalBuilder(
                  builder: (_) {
                    rebuilds++;
                    final busy =
                        importVm.isRunning ||
                        exportVm.isRunning ||
                        mpqVm.isRunning ||
                        combinedVm.isRunning;
                    return Text('dbc:${busy ? 'busy' : 'free'}');
                  },
                ),
                // The MPQ section uses two SignalBuilders. The shared utility also marks
                // the MPQ view model busy during a combined export.
                SignalBuilder(
                  builder: (_) {
                    final busy =
                        mpqVm.isRunning ||
                        importVm.isRunning ||
                        exportVm.isRunning;
                    return Text('mpq:${busy ? 'busy' : 'free'}');
                  },
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
      expect(rebuilds, 1);
      expect(find.text('dbc:free'), findsOneWidget);

      // The shared utility makes importVm.isRunning true, short-circuiting the
      // remaining reads while the MPQ task is running.
      util.running.value = true;
      mpqVm.status.value = WorkflowStatus.running;
      await tester.pump();
      expect(rebuilds, 2, reason: '任务开始必须触发重建');
      expect(find.text('dbc:busy'), findsOneWidget);
      expect(find.text('mpq:busy'), findsOneWidget);

      // The utility resets and MPQ succeeds. The early return previously dropped
      // the mpqVm.status dependency. Without tracking util.running, SignalBuilder
      // never rebuilt and the button stayed disabled.
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
    },
  );

  testWidgets(
    'One click starts DBC import and one click closes the dialog after completion or cancellation',
    (tester) async {
      await tester.pumpWidget(dataPage);
      final nav = tester.state<NavigatorState>(find.byType(Navigator).first);
      await tester.ensureVisible(dbcImportButton());
      await tester.pumpAndSettle();
      await tester.tap(dbcImportButton());
      await tester.pumpAndSettle();
      expect(find.text('正在导入 DBC'), findsOneWidget);
      expect(find.text('取消导入'), findsOneWidget);

      await nav.maybePop();
      await tester.pumpAndSettle();
      expect(find.text('正在导入 DBC'), findsOneWidget);

      importVm.status.value = WorkflowStatus.succeeded;
      await tester.pumpAndSettle();
      expect(find.text('导入完成'), findsOneWidget);
      await tester.tap(find.text('确定'));
      await tester.pumpAndSettle();
      expect(find.byType(ShadDialog), findsNothing);

      await tester.tap(dbcImportButton());
      await tester.pumpAndSettle();
      await tester.tap(find.text('取消导入'));
      await tester.pumpAndSettle();
      expect(find.text('正在取消…'), findsOneWidget);

      const error = '导入已取消';
      importVm.errorMessage.value = error;
      importVm.status.value = WorkflowStatus.failed;
      await tester.pumpAndSettle();
      expect(find.text(error), findsOneWidget);
      expect(find.text('重试').hitTestable(), findsOneWidget);
      await tester.tap(find.text('确定'));
      await tester.pumpAndSettle();
      expect(find.byType(ShadDialog), findsNothing);
    },
  );

  testWidgets(
    'All three export dialogs use configured paths and hide the directory',
    (tester) async {
      final dbcPath = '${tempDir.path}${Platform.pathSeparator}dbc';
      final mpqPath = '${tempDir.path}${Platform.pathSeparator}mpq';
      cfg.data.addAll({'dbc_dir': dbcPath, 'mpq_dir': mpqPath});
      await tester.pumpWidget(dataPage);
      final cases = [
        (
          button: dbcExportButton(),
          patch: false,
          finish: () {
            expect(exportVm.outputDirectory.value, dbcPath);
            exportVm.status.value = WorkflowStatus.succeeded;
          },
        ),
        (
          button: mpqExportButton(),
          patch: true,
          finish: () {
            expect(mpqVm.outputDirectory.value, mpqPath);
            mpqVm.status.value = WorkflowStatus.succeeded;
          },
        ),
        (
          button: combinedExportButton(),
          patch: true,
          finish: () {
            expect(combinedVm.dbcOutputDirectory.value, dbcPath);
            expect(combinedVm.mpqOutputDirectory.value, mpqPath);
            combinedVm.status.value = WorkflowStatus.succeeded;
          },
        ),
      ];

      for (final scenario in cases) {
        await tester.ensureVisible(scenario.button);
        await tester.pumpAndSettle();
        await tester.tap(scenario.button);
        await tester.pumpAndSettle();

        expect(find.text('浏览'), findsNothing);
        expect(
          find.text('MPQ 文件名'),
          scenario.patch ? findsOneWidget : findsNothing,
        );
        expect(
          buttonOf(tester, find.widgetWithText(ShadButton, '导出')).enabled,
          isTrue,
        );

        scenario.finish();
        await tester.pumpAndSettle();
        expect(find.text('导出完成'), findsOneWidget);
        expect(find.textContaining(tempDir.path), findsNothing);
        if (scenario.patch) {
          expect(
            find.textContaining(
              MpqExportWorkflowViewModel.defaultPatchFileName,
            ),
            findsOneWidget,
          );
        }
        await tester.tap(find.text('确定'));
        await tester.pumpAndSettle();
      }
    },
  );

  testWidgets('Completing MPQ export re-enables DBC import and export', (
    tester,
  ) async {
    await tester.pumpWidget(dataPage);
    await tester.pump();
    await tester.pump();

    // All four buttons are initially enabled.
    expect(buttonOf(tester, dbcImportButton()).onPressed, isNotNull);
    expect(buttonOf(tester, dbcExportButton()).onPressed, isNotNull);
    expect(buttonOf(tester, mpqExportButton()).onPressed, isNotNull);
    expect(buttonOf(tester, combinedExportButton()).onPressed, isNotNull);

    // Run the MPQ workflow through a real isolate with a scripted success worker.
    await tester.runAsync(() async {
      await mpqVm.prepare();
      mpqVm.setOutputDirectory(tempDir.path);
      mpqVm.setFileName('patch-zhCN-5.mpq');
      await mpqVm.start();
    });
    expect(mpqVm.status.value, WorkflowStatus.succeeded);
    await tester.pump();

    // The view model has reset, as checked in dbc_sync_util_test.
    expect(mpqVm.isRunning, isFalse, reason: 'MPQ VM 必须已复位');
    expect(exportVm.isRunning, isFalse, reason: '导出 VM 必须已复位');
    expect(importVm.isRunning, isFalse, reason: '导入 VM 必须已复位');
    expect(util.isRunning, isFalse, reason: 'DbcSyncUtil 必须已复位');

    // Pump several frames to account for scheduling.
    for (var i = 0; i < 5; i++) {
      await tester.pump();
    }

    // The buttons must be enabled again after the export finishes.
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
    expect(
      buttonOf(tester, combinedExportButton()).onPressed,
      isNotNull,
      reason: 'MPQ 导出完成后「一键导出」按钮必须恢复可用',
    );

    // Scroll below the combined export section to the DBC export button
    // and open its dialog.
    await tester.ensureVisible(dbcExportButton());
    await tester.pumpAndSettle();
    await tester.tap(dbcExportButton());
    await tester.pump();
    await tester.pump();
    expect(
      find.descendant(
        of: find.byType(ShadDialog),
        matching: find.text('导出 DBC'),
      ),
      findsOneWidget,
    );

    // After closing it, scroll back to the top and click the combined export
    // button to open its dialog.
    await tester.tap(find.text('取消'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(combinedExportButton());
    await tester.pumpAndSettle();
    await tester.tap(combinedExportButton());
    await tester.pump();
    await tester.pump();
    expect(
      find.descendant(
        of: find.byType(ShadDialog),
        matching: find.text('一键导出 DBC + MPQ'),
      ),
      findsOneWidget,
      reason: '点击「一键导出」必须打开组合导出对话框',
    );
  });
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
  bool failUpdate = false;

  _MemoryConfigUtil(this.data);

  @override
  String get configPath => 'memory:config.yaml';

  @override
  Future<Map<String, dynamic>> load() async => Map<String, dynamic>.of(data);

  @override
  Future<void> update(Map<String, dynamic> values) async {
    if (failUpdate) throw const FileSystemException('permission denied');
    data.addAll(values);
  }
}

final class _RunningDbcImportViewModel extends DbcImportWorkflowViewModel {
  _RunningDbcImportViewModel({
    required super.useCase,
    required super.configUtil,
  });

  @override
  Future<void> start() async {
    status.value = WorkflowStatus.running;
    progress.value = 0.5;
  }
}

final class _SuccessIconWorker {
  static Future<void> run(GameIconExtractWorkerArgs args) async {
    args.sendPort.send((
      'result',
      const GameIconExtractionResult(
        extracted: 1,
        skipped: 0,
        failed: 0,
        errors: [],
        cancelled: false,
      ),
    ));
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
