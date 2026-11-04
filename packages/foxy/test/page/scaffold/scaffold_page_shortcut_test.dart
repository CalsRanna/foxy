import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/model/dbc/dbc_export_table.dart';
import 'package:foxy/page/scaffold/scaffold_page.dart';
import 'package:foxy/page/setting/combined_export_dialog.dart';
import 'package:foxy/repository/dbc_export_registry.dart';
import 'package:foxy/repository/feature_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/use_case/combined/combined_export_use_case.dart';
import 'package:foxy/use_case/dbc/check_dbc_reminder_use_case.dart';
import 'package:foxy/use_case/dbc/export_dbc_use_case.dart';
import 'package:foxy/use_case/dbc/import_dbc_use_case.dart';
import 'package:foxy/use_case/mpq/mpq_export_use_case.dart';
import 'package:foxy/view_model/feature_state_view_model.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:foxy/view_model/workflow/combined_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/dbc_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/dbc_import_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/mpq_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late RootStackRouter router;
  late DbcImportWorkflowViewModel importVm;
  late DbcExportWorkflowViewModel exportVm;
  late MpqExportWorkflowViewModel mpqVm;
  late CombinedExportWorkflowViewModel combinedVm;

  setUp(() async {
    await GetIt.instance.reset();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('window_manager'),
          (_) async => false,
        );
    final config = _MemoryConfigUtil();
    final sync = DbcSyncUtil();
    final registry = _EmptyRegistry();
    importVm = DbcImportWorkflowViewModel(
      useCase: ImportDbcUseCase(configUtil: config, dbcSyncUtil: sync),
      configUtil: config,
    );
    exportVm = DbcExportWorkflowViewModel(
      useCase: ExportDbcUseCase(
        registry: registry,
        dbcSyncUtil: sync,
        configUtil: config,
      ),
      configUtil: config,
    );
    mpqVm = MpqExportWorkflowViewModel(
      useCase: MpqExportUseCase(
        registry: registry,
        dbcSyncUtil: sync,
        configUtil: config,
      ),
      configUtil: config,
    );
    combinedVm = CombinedExportWorkflowViewModel(
      useCase: _CombinedExportUseCase(),
      configUtil: config,
    );
    GetIt.instance.registerSingleton(importVm);
    GetIt.instance.registerSingleton(exportVm);
    GetIt.instance.registerSingleton(mpqVm);
    GetIt.instance.registerSingleton(combinedVm);
    GetIt.instance.registerSingleton(
      FeatureStateViewModel(repository: FeatureRepository()),
    );
    GetIt.instance.registerSingleton<SetupStatusViewModel>(
      _CompleteSetupViewModel(configUtil: config),
    );
    GetIt.instance.registerSingleton(RouterFacade());
    GetIt.instance.registerSingleton(
      CheckDbcReminderUseCase(configUtil: config, checkTables: () async => []),
    );
    router = RootStackRouter.build(
      routes: [
        NamedRouteDef(
          name: 'ScaffoldRoute',
          path: '/',
          builder: (_, _) => const ScaffoldPage(),
          children: [
            NamedRouteDef(
              name: 'FirstRoute',
              path: '',
              builder: (_, _) => const Center(child: Text('页面一')),
            ),
            NamedRouteDef(
              name: 'SecondRoute',
              path: 'second',
              builder: (_, _) =>
                  const Center(child: ShadInput(placeholder: Text('页面二搜索'))),
            ),
          ],
        ),
      ],
    );
  });

  tearDown(() async {
    router.dispose();
    importVm.dispose();
    exportVm.dispose();
    mpqVm.dispose();
    combinedVm.dispose();
    await GetIt.instance.reset();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('window_manager'), null);
  });

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(ShadApp.router(routerConfig: router.config()));
    await tester.pumpAndSettle();
  }

  Future<void> pressExport(WidgetTester tester, {bool shift = true}) async {
    final modifier = Platform.isMacOS
        ? LogicalKeyboardKey.metaLeft
        : LogicalKeyboardKey.controlLeft;
    await tester.sendKeyDownEvent(modifier);
    if (shift) await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyE);
    if (shift) await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyUpEvent(modifier);
  }

  testWidgets('任意页面可打开一键导出，输入框聚焦时也生效', (tester) async {
    await pumpApp(tester);
    expect(find.text('页面一'), findsOneWidget);

    await pressExport(tester);
    await tester.pumpAndSettle();
    expect(find.byType(CombinedExportDialog), findsOneWidget);
    expect(find.text('开始导出'), findsOneWidget);

    await tester.tap(find.text('关闭'));
    await tester.pumpAndSettle();
    final innerRouter = router.innerRouterOf<StackRouter>('ScaffoldRoute')!;
    innerRouter.push(const NamedRoute('SecondRoute'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(ShadInput), 'spell');

    await pressExport(tester);
    await tester.pumpAndSettle();
    expect(find.byType(CombinedExportDialog), findsOneWidget);
    await tester.tap(find.text('关闭'));
    await tester.pumpAndSettle();
    expect(find.text('spell'), findsOneWidget);
  });

  testWidgets('连续按键和对话框打开后再次触发不会叠加导出弹窗', (tester) async {
    await pumpApp(tester);
    await pressExport(tester);
    await pressExport(tester);
    await tester.pumpAndSettle();
    await pressExport(tester);
    await tester.pumpAndSettle();
    expect(find.byType(CombinedExportDialog), findsOneWidget);

    await tester.tap(find.text('关闭'));
    await tester.pumpAndSettle();
    expect(find.byType(CombinedExportDialog), findsNothing);
    await pressExport(tester);
    await tester.pumpAndSettle();
    expect(find.byType(CombinedExportDialog), findsOneWidget);
  });

  testWidgets('DBC 或 MPQ 任务忙碌时不触发，结束后恢复', (tester) async {
    await pumpApp(tester);
    final statuses = [
      importVm.status,
      exportVm.status,
      mpqVm.status,
      combinedVm.status,
    ];
    for (final status in statuses) {
      for (final busy in [
        WorkflowStatus.preparing,
        WorkflowStatus.running,
        WorkflowStatus.cancelling,
      ]) {
        status.value = busy;
        await pressExport(tester);
        await tester.pumpAndSettle();
        expect(find.byType(CombinedExportDialog), findsNothing);
      }
      status.value = WorkflowStatus.succeeded;
    }
    await pressExport(tester);
    await tester.pumpAndSettle();
    expect(find.byType(CombinedExportDialog), findsOneWidget);
  });

  testWidgets('缺少 Shift 时不触发导出', (tester) async {
    await pumpApp(tester);
    await pressExport(tester, shift: false);
    await tester.pumpAndSettle();
    expect(find.byType(CombinedExportDialog), findsNothing);
  });
}

class _MemoryConfigUtil extends ConfigUtil {
  @override
  Future<Map<String, dynamic>> load() async => {};
}

class _CompleteSetupViewModel extends SetupStatusViewModel {
  _CompleteSetupViewModel({required super.configUtil});

  @override
  Future<void> prepare() async {}

  @override
  bool get isSetupComplete => true;
}

class _CombinedExportUseCase extends CombinedExportUseCase {
  _CombinedExportUseCase() : super.protected();

  @override
  bool get isRunning => false;

  @override
  Future<List<DbcExportTable>> loadTables() async => [];
}

class _EmptyRegistry implements DbcExportRegistry {
  @override
  bool contains(String tableName) => false;

  @override
  Future<DbcExportCountResult> countRows(String tableName) async =>
      const DbcExportCountResult.success(0);

  @override
  Future<List<Map<String, dynamic>>> loadRows(String tableName) async => [];
}
