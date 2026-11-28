import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/model/dbc/dbc_export_table.dart';
import 'package:foxy/page/scaffold/scaffold_page.dart';
import 'package:foxy/repository/dbc_export_registry.dart';
import 'package:foxy/repository/feature_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/use_case/combined/combined_export_use_case.dart';
import 'package:foxy/use_case/dbc/check_dbc_reminder_use_case.dart';
import 'package:foxy/use_case/dbc/export_dbc_use_case.dart';
import 'package:foxy/use_case/dbc/import_dbc_use_case.dart';
import 'package:foxy/use_case/mpq/mpq_export_use_case.dart';
import 'package:foxy/view_model/feature_state_view_model.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:foxy/view_model/workflow/combined_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/dbc_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/dbc_import_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/mpq_export_workflow_view_model.dart';
import 'package:foxy/widget/form/foxy_detail_form_scope.dart';
import 'package:foxy/widget/form/foxy_string_input.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

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
  });

  tearDown(() async {
    importVm.dispose();
    exportVm.dispose();
    mpqVm.dispose();
    combinedVm.dispose();
    await GetIt.instance.reset();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('window_manager'), null);
  });

  Future<void> pumpScaffold(WidgetTester tester, Widget child) async {
    router = RootStackRouter.build(
      routes: [
        NamedRouteDef(
          name: 'ScaffoldRoute',
          path: '/',
          builder: (_, _) => const ScaffoldPage(),
          children: [
            NamedRouteDef(
              name: 'DetailRoute',
              path: '',
              builder: (_, _) => child,
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(ShadApp.router(routerConfig: router.config()));
    await tester.pumpAndSettle();
  }

  Future<void> pressSave(WidgetTester tester) async {
    final modifier = Platform.isMacOS
        ? LogicalKeyboardKey.metaLeft
        : LogicalKeyboardKey.controlLeft;
    await tester.sendKeyDownEvent(modifier);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyS);
    await tester.sendKeyUpEvent(modifier);
  }

  test(
    'FieldControllerMixin tracks edits, reverts, and partial clean sync',
    () {
      final vm = _FakeDetailViewModel();
      addTearDown(vm.dispose);

      vm.nameController.init('狼');
      vm.countController.init(10);
      vm.nullableController.init(null);
      vm.enumController.init(1);
      expect(vm.hasUnsavedChanges, isFalse);

      vm.markClean();
      expect(vm.hasUnsavedChanges, isFalse);

      vm.nameController.controller.text = '霜狼';
      expect(vm.hasUnsavedChanges, isTrue);

      vm.nameController.controller.text = '狼';
      expect(vm.hasUnsavedChanges, isFalse);

      vm.nullableController.setNull(false);
      expect(vm.hasUnsavedChanges, isTrue);
      vm.nullableController.setNull(true);
      expect(vm.hasUnsavedChanges, isFalse);

      vm.countController.controller.text = '20';
      vm.nameController.init('本地化名称');
      vm.syncCleanSnapshot(vm.nameController);
      expect(vm.hasUnsavedChanges, isTrue);

      vm.countController.controller.text = '10';
      expect(vm.hasUnsavedChanges, isFalse);
    },
  );

  testWidgets('Cmd/Ctrl+S saves the currently visible detail tab only', (
    tester,
  ) async {
    final tab0Vm = _FakeDetailViewModel()..nameController.init('初始值');
    final tab1Vm = _FakeDetailViewModel()..nameController.init('补充初始值');
    addTearDown(tab0Vm.dispose);
    addTearDown(tab1Vm.dispose);

    var tab0Saves = 0;
    var tab1Saves = 0;

    await pumpScaffold(
      tester,
      ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FoxyTab(
            tabs: const [Text('主表'), Text('补充')],
            contents: [
              FoxyDetailFormScope(
                viewModel: tab0Vm,
                loading: tab0Vm.loading,
                submitting: tab0Vm.submitting,
                errorMessage: tab0Vm.errorMessage,
                onSave: () async {
                  tab0Vm.submitting.value = true;
                  tab0Saves++;
                  tab0Vm.submitting.value = false;
                },
                child: FoxyStringInput(
                  controller: tab0Vm.nameController,
                  placeholder: 'name',
                ),
              ),
              FoxyDetailFormScope(
                viewModel: tab1Vm,
                loading: tab1Vm.loading,
                submitting: tab1Vm.submitting,
                errorMessage: tab1Vm.errorMessage,
                onSave: () async {
                  tab1Vm.submitting.value = true;
                  tab1Saves++;
                  tab1Vm.submitting.value = false;
                },
                child: FoxyStringInput(
                  controller: tab1Vm.nameController,
                  placeholder: 'addon',
                ),
              ),
            ],
          ),
        ],
      ),
    );

    await tester.enterText(find.byType(EditableText).first, '已修改');
    await tester.pump();
    expect(tab0Vm.hasUnsavedChanges, isTrue);

    await pressSave(tester);
    await tester.pumpAndSettle();
    expect(tab0Saves, 1);
    expect(tab1Saves, 0);
    expect(tab0Vm.hasUnsavedChanges, isFalse);

    await tester.tap(find.text('补充'));
    await tester.pumpAndSettle();

    await pressSave(tester);
    await tester.pumpAndSettle();
    expect(tab0Saves, 1);
    expect(tab1Saves, 1);
  });

  testWidgets('Leaving a dirty detail form prompts before navigating', (
    tester,
  ) async {
    final vm = _FakeDetailViewModel()..nameController.init('初始名称');
    addTearDown(vm.dispose);

    await pumpScaffold(
      tester,
      FoxyDetailFormScope(
        viewModel: vm,
        loading: vm.loading,
        submitting: vm.submitting,
        errorMessage: vm.errorMessage,
        onSave: () async {
          vm.submitting.value = true;
          vm.errorMessage.value = null;
          vm.submitting.value = false;
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FoxyStringInput(
            controller: vm.nameController,
            placeholder: 'name',
          ),
        ),
      ),
    );

    final facade = GetIt.instance.get<RouterFacade>();
    expect(facade.activeMenu, RouterMenu.dashboard);

    // Clean form navigates without confirmation.
    await tester.tap(find.byIcon(RouterMenu.more.icon));
    await tester.pumpAndSettle();
    expect(find.text('未保存的更改'), findsNothing);
    expect(facade.activeMenu, RouterMenu.more);

    // Edit form to make it dirty, then try leaving via sidebar.
    await tester.enterText(find.byType(EditableText), '改过但未保存');
    await tester.pump();
    expect(vm.hasUnsavedChanges, isTrue);

    await tester.tap(find.byIcon(RouterMenu.setting.icon));
    await tester.pumpAndSettle();
    expect(find.text('未保存的更改'), findsOneWidget);

    // Staying cancels navigation.
    await tester.tap(find.text('留下'));
    await tester.pumpAndSettle();
    expect(find.text('未保存的更改'), findsNothing);
    expect(facade.activeMenu, RouterMenu.more);

    // Discarding proceeds with navigation.
    await tester.tap(find.byIcon(RouterMenu.setting.icon));
    await tester.pumpAndSettle();
    await tester.tap(find.text('放弃更改'));
    await tester.pumpAndSettle();
    expect(facade.activeMenu, RouterMenu.setting);
  });

  testWidgets('Failed save keeps the form dirty', (tester) async {
    final vm = _FakeDetailViewModel()..nameController.init('原值');
    addTearDown(vm.dispose);

    await pumpScaffold(
      tester,
      FoxyDetailFormScope(
        viewModel: vm,
        loading: vm.loading,
        submitting: vm.submitting,
        errorMessage: vm.errorMessage,
        onSave: () async {
          vm.submitting.value = true;
          vm.errorMessage.value = '保存失败';
          vm.submitting.value = false;
        },
        child: FoxyStringInput(
          controller: vm.nameController,
          placeholder: 'name',
        ),
      ),
    );

    await tester.enterText(find.byType(EditableText), '新值');
    await tester.pump();
    expect(vm.hasUnsavedChanges, isTrue);

    await pressSave(tester);
    await tester.pumpAndSettle();
    expect(vm.hasUnsavedChanges, isTrue);
  });
}

class _CombinedExportUseCase extends CombinedExportUseCase {
  _CombinedExportUseCase() : super.protected();

  @override
  bool get isRunning => false;

  @override
  Future<List<DbcExportTable>> loadTables() async => [];
}

class _CompleteSetupViewModel extends SetupStatusViewModel {
  _CompleteSetupViewModel({required super.configUtil});

  @override
  bool get isSetupComplete => true;

  @override
  Future<void> prepare() async {}
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

class _FakeDetailViewModel with FieldControllerMixin {
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final nameController = registerController(StringFieldController());
  late final countController = registerController(IntFieldController());
  late final nullableController = registerController(
    NullableStringFieldController(),
  );
  late final enumController = registerController(
    EnumFieldController<int>(fallback: 0),
  );

  void dispose() => disposeControllers();
}

class _MemoryConfigUtil extends ConfigUtil {
  @override
  Future<Map<String, dynamic>> load() async => {};
}
