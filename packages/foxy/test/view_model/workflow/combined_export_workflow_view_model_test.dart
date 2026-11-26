import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/model/dbc/dbc_export_table.dart';
import 'package:foxy/model/dbc/dbc_sync_progress.dart';
import 'package:foxy/use_case/combined/combined_export_use_case.dart';
import 'package:foxy/view_model/workflow/combined_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/mpq_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:path/path.dart' as p;

void main() {
  late _MemoryConfigUtil configUtil;
  late _FakeCombinedExportUseCase useCase;

  setUp(() {
    configUtil = _MemoryConfigUtil({});
    useCase = _FakeCombinedExportUseCase();
  });

  CombinedExportWorkflowViewModel buildVm() =>
      CombinedExportWorkflowViewModel(useCase: useCase, configUtil: configUtil);

  test('prepare loads dbc_dir, mpq_dir, and the default file name and populates table counts', () async {
    final dbcDir = r'D:\server\dbc';
    final mpqDir = r'D:\client\Data\zhCN';
    await configUtil.update({'dbc_dir': dbcDir, 'mpq_dir': mpqDir});
    useCase.tables = [
      DbcExportTable(definition: DbcDefinitions.byTable['dbc_spell_duration']!),
    ];

    final vm = buildVm();
    await vm.prepare();

    expect(vm.dbcOutputDirectory.value, dbcDir);
    expect(vm.mpqOutputDirectory.value, mpqDir);
    expect(vm.fileName.value, MpqExportWorkflowViewModel.defaultPatchFileName);
    expect(vm.items.value, hasLength(1));
    expect(vm.items.value.single.canSelect, isTrue);
    expect(vm.status.value, WorkflowStatus.idle);
  });

  test(
    'prepare leaves output directories null when they are unconfigured',
    () async {
      useCase.tables = [
        DbcExportTable(
          definition: DbcDefinitions.byTable['dbc_spell_duration']!,
        ),
      ];

      final vm = buildVm();
      await vm.prepare();

      expect(vm.dbcOutputDirectory.value, isNull);
      expect(vm.mpqOutputDirectory.value, isNull);
      expect(vm.isRunning, isFalse);
    },
  );

  test('start fails validation without selected tables', () async {
    final vm = buildVm();
    await vm.prepare();
    vm.setAllSelectableSelected(false);

    await expectLater(vm.start(), throwsA(anything));
    expect(vm.status.value, WorkflowStatus.failed);
    expect(vm.errorMessage.value, isNotNull);
    expect(useCase.executedInputs, isEmpty);
  });

  test(
    'start fails validation when the DBC directory is not configured',
    () async {
      final vm = buildVm();
      await vm.prepare();
      vm.setMpqOutputDirectory(r'D:\client\Data\zhCN');

      await expectLater(vm.start(), throwsA(anything));
      expect(vm.status.value, WorkflowStatus.failed);
      expect(vm.errorMessage.value, isNotNull);
      expect(useCase.executedInputs, isEmpty);
    },
  );

  test(
    'start fails validation when the MPQ directory is not configured',
    () async {
      final vm = buildVm();
      await vm.prepare();
      vm.setDbcOutputDirectory(r'D:\server\dbc');

      await expectLater(vm.start(), throwsA(anything));
      expect(vm.status.value, WorkflowStatus.failed);
      expect(vm.errorMessage.value, isNotNull);
      expect(useCase.executedInputs, isEmpty);
    },
  );

  test('start supplies both directories and the file name and sets succeeded on success', () async {
    final dbcDir = r'D:\server\dbc';
    final mpqDir = r'D:\client\Data\zhCN';
    await configUtil.update({'dbc_dir': dbcDir, 'mpq_dir': mpqDir});
    useCase.tables = [
      DbcExportTable(definition: DbcDefinitions.byTable['dbc_spell_duration']!),
    ];

    final vm = buildVm();
    await vm.prepare();
    vm.setFileName('custom.MPQ');

    await vm.start();

    expect(useCase.executedInputs, hasLength(1));
    expect(useCase.executedInputs.single.dbcOutputDirectory, dbcDir);
    expect(
      useCase.executedInputs.single.mpqFilePath,
      p.join(mpqDir, 'custom.MPQ'),
    );
    expect(vm.status.value, WorkflowStatus.succeeded);
    expect(vm.result.value?.success, isTrue);
  });

  test('setFileName falls back to the default when empty', () async {
    final vm = buildVm();
    vm.setFileName('   ');
    expect(vm.fileName.value, MpqExportWorkflowViewModel.defaultPatchFileName);
  });
}

/// Fake combined export use case: records executed inputs and returns a
/// success result; loadTables is scripted. The superclass fields are never
/// touched.
final class _FakeCombinedExportUseCase extends CombinedExportUseCase {
  List<DbcExportTable> tables = [];

  final executedInputs = <CombinedExportInput>[];
  _FakeCombinedExportUseCase() : super.protected();

  @override
  bool get isRunning => false;

  @override
  Future<DbcSyncResult> execute(CombinedExportInput input) async {
    executedInputs.add(input);
    return const DbcSyncResult(
      operation: DbcSyncOperation.export,
      completed: 1,
      skipped: 0,
      errors: [],
    );
  }

  @override
  Future<List<DbcExportTable>> loadTables() async => tables;
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
