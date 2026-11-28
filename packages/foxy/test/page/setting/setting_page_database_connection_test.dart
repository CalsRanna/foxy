import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/feature_entity.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/database/database.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/model/dbc/dbc_export_table.dart';
import 'package:foxy/page/setting/setting_page.dart';
import 'package:foxy/repository/dbc_export_registry.dart';
import 'package:foxy/repository/feature_repository.dart';
import 'package:foxy/repository/locale_query_settings.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/use_case/agent/agent_provider_config_use_case.dart';
import 'package:foxy/use_case/combined/combined_export_use_case.dart';
import 'package:foxy/use_case/dbc/export_dbc_use_case.dart';
import 'package:foxy/use_case/dbc/import_dbc_use_case.dart';
import 'package:foxy/use_case/game_asset/extract_game_icons_use_case.dart';
import 'package:foxy/use_case/mpq/mpq_export_use_case.dart';
import 'package:foxy/view_model/feature_state_view_model.dart';
import 'package:foxy/view_model/foxy_state_view_model.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:foxy/view_model/update_view_model.dart';
import 'package:foxy/view_model/workflow/combined_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/dbc_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/dbc_import_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/icon_extract_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/mpq_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DbcImportWorkflowViewModel importVm;
  late DbcExportWorkflowViewModel exportVm;
  late MpqExportWorkflowViewModel mpqVm;
  late CombinedExportWorkflowViewModel combinedVm;
  late IconExtractWorkflowViewModel iconVm;
  late FoxyStateViewModel stateVm;
  late FeatureStateViewModel featureVm;
  late RouterFacade routerFacade;
  late RootStackRouter router;

  setUp(() async {
    await Database.instance.close();
    await GetIt.instance.reset();

    final config = _MemoryConfigUtil();
    final sync = DbcSyncUtil();
    final registry = _EmptyRegistry();

    GetIt.instance.registerSingleton<ConfigUtil>(config);
    GetIt.instance.registerSingleton(AgentProviderConfigUseCase(config));
    GetIt.instance.registerSingleton(LocaleQuerySettings());
    stateVm = FoxyStateViewModel()
      ..setLocaleSettings(hasLocaleTables: true, localeEnabled: true);
    GetIt.instance.registerSingleton(stateVm);
    featureVm = FeatureStateViewModel(repository: FeatureRepository())
      ..replaceFeatures([
        FeatureEntity(
          id: 1,
          name: '生物模板',
          description: '生物模板管理',
          icon: 'pawPrint',
          routerMenu: 'creatureTemplate',
          isPinned: true,
          isFavorite: true,
          createdAt: DateTime(2026),
          updatedAt: DateTime(2026),
        ),
      ]);
    GetIt.instance.registerSingleton(featureVm);
    routerFacade = RouterFacade()..navigateToMenu(RouterMenu.setting);
    GetIt.instance.registerSingleton(routerFacade);

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
    iconVm = IconExtractWorkflowViewModel(
      useCase: ExtractGameIconsUseCase(
        configUtil: config,
        outputDir: Directory.systemTemp.path,
      ),
      configUtil: config,
    );
    GetIt.instance.registerSingleton(importVm);
    GetIt.instance.registerSingleton(exportVm);
    GetIt.instance.registerSingleton(mpqVm);
    GetIt.instance.registerSingleton(combinedVm);
    GetIt.instance.registerSingleton(iconVm);
    GetIt.instance.registerSingleton(SetupStatusViewModel(configUtil: config));
    GetIt.instance.registerSingleton(UpdateViewModel());
  });

  tearDown(() async {
    await Database.instance.close();
    importVm.dispose();
    exportVm.dispose();
    mpqVm.dispose();
    combinedVm.dispose();
    iconVm.dispose();
    await GetIt.instance.reset();
  });

  Future<void> pumpSettings(WidgetTester tester) async {
    router = RootStackRouter.build(
      routes: [
        NamedRouteDef(
          name: 'ScaffoldRoute',
          path: '/',
          builder: (_, _) => const Scaffold(body: AutoRouter()),
          children: [
            NamedRouteDef(
              name: 'SettingRoute',
              path: '',
              builder: (_, _) => const SettingPage(),
            ),
          ],
        ),
        NamedRouteDef(
          name: BootstrapRoute.name,
          path: '/bootstrap',
          builder: (_, _) => const Scaffold(body: Center(child: Text('连接页面'))),
        ),
      ],
    );
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(ShadApp.router(routerConfig: router.config()));
    await tester.pumpAndSettle();
  }

  testWidgets('Shows database connection summary including SSL flag', (
    tester,
  ) async {
    await Database.instance.connect(
      MysqlConfig(
        host: '127.0.0.1',
        port: 63306,
        database: 'acore_world',
        username: 'root',
        password: 'secret',
        useSsl: true,
      ),
    );

    await pumpSettings(tester);

    expect(
      find.text('root@127.0.0.1:63306 / acore_world · SSL'),
      findsOneWidget,
    );
  });

  testWidgets('Disconnect button is disabled while a data workflow runs', (
    tester,
  ) async {
    await Database.instance.connect(
      MysqlConfig(
        host: '127.0.0.1',
        port: 3306,
        database: 'acore_world',
        username: 'root',
        password: 'secret',
      ),
    );

    await pumpSettings(tester);

    final disconnectButton = find.widgetWithText(ShadButton, '退出连接');
    expect(tester.widget<ShadButton>(disconnectButton).onPressed, isNotNull);

    importVm.status.value = WorkflowStatus.running;
    await tester.pump();
    expect(tester.widget<ShadButton>(disconnectButton).onPressed, isNull);

    importVm.status.value = WorkflowStatus.succeeded;
    await tester.pump();
    expect(tester.widget<ShadButton>(disconnectButton).onPressed, isNotNull);
  });

  testWidgets(
    'Confirming disconnect closes DB, resets state, and opens bootstrap',
    (tester) async {
      await Database.instance.connect(
        MysqlConfig(
          host: '127.0.0.1',
          port: 3306,
          database: 'acore_world',
          username: 'root',
          password: 'secret',
        ),
      );

      await pumpSettings(tester);

      // Cancelling keeps the active connection and stays on settings.
      await tester.tap(find.widgetWithText(ShadButton, '退出连接'));
      await tester.pumpAndSettle();
      expect(find.text('退出当前连接'), findsOneWidget);

      await tester.tap(find.widgetWithText(ShadButton, '取消'));
      await tester.pumpAndSettle();
      expect(Database.instance.config, isNotNull);
      expect(find.text('连接页面'), findsNothing);

      // Confirming disconnects, resets global session state, and routes to bootstrap.
      await tester.tap(find.widgetWithText(ShadButton, '退出连接'));
      await tester.pumpAndSettle();
      final confirmButtons = find.descendant(
        of: find.byType(ShadDialog),
        matching: find.widgetWithText(ShadButton, '退出连接'),
      );
      await tester.tap(confirmButtons);
      await tester.pumpAndSettle();

      expect(Database.instance.config, isNull);
      expect(stateVm.initialized.value, isFalse);
      expect(featureVm.allFeatures.value, isEmpty);
      expect(routerFacade.activeMenu, RouterMenu.dashboard);
      expect(find.text('连接页面'), findsOneWidget);
    },
  );
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

class _MemoryConfigUtil extends ConfigUtil {
  @override
  Future<Map<String, dynamic>> load() async => {};
}
