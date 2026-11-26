import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/model/dbc/dbc_export_table.dart';
import 'package:foxy/model/dbc/dbc_sync_progress.dart';
import 'package:foxy/use_case/mpq/mpq_export_use_case.dart';
import 'package:foxy/view_model/workflow/mpq_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';
import 'package:path/path.dart' as p;

void main() {
  late _MemoryConfigUtil configUtil;
  late _FakeMpqExportUseCase useCase;

  setUp(() {
    configUtil = _MemoryConfigUtil({});
    useCase = _FakeMpqExportUseCase();
  });

  MpqExportWorkflowViewModel buildVm() =>
      MpqExportWorkflowViewModel(useCase: useCase, configUtil: configUtil);

  test('prepare loads mpq_dir and the default file name and populates table counts', () async {
    final mpqDir = r'D:\client\Data\zhCN';
    await configUtil.update({'mpq_dir': mpqDir});
    useCase.tables = [
      DbcExportTable(definition: DbcDefinitions.byTable['dbc_spell_duration']!),
    ];

    final vm = buildVm();
    await vm.prepare();

    expect(vm.outputDirectory.value, mpqDir);
    expect(vm.fileName.value, MpqExportWorkflowViewModel.defaultPatchFileName);
    expect(vm.items.value, hasLength(1));
    expect(vm.items.value.single.canSelect, isTrue);
    expect(vm.status.value, WorkflowStatus.idle);
  });

  test('prepare leaves the output directory null without mpq_dir', () async {
    useCase.tables = [
      DbcExportTable(definition: DbcDefinitions.byTable['dbc_spell_duration']!),
    ];

    final vm = buildVm();
    await vm.prepare();

    expect(vm.outputDirectory.value, isNull);
    expect(vm.isRunning, isFalse);
  });

  test('start fails validation without selected tables', () async {
    final vm = buildVm();
    await vm.prepare();
    vm.setAllSelectableSelected(false);

    await expectLater(vm.start(), throwsA(anything));
    expect(vm.status.value, WorkflowStatus.failed);
    expect(vm.errorMessage.value, isNotNull);
    expect(useCase.executedPaths, isEmpty);
  });

  test(
    'start fails validation when the output directory is not configured',
    () async {
      final vm = buildVm();
      await vm.prepare();

      await expectLater(vm.start(), throwsA(anything));
      expect(vm.status.value, WorkflowStatus.failed);
      expect(vm.errorMessage.value, isNotNull);
      expect(useCase.executedPaths, isEmpty);
    },
  );

  test(
    'start uses the directory and file name and sets succeeded on success',
    () async {
      final mpqDir = r'D:\client\Data\zhCN';
      await configUtil.update({'mpq_dir': mpqDir});
      useCase.tables = [
        DbcExportTable(
          definition: DbcDefinitions.byTable['dbc_spell_duration']!,
        ),
      ];

      final vm = buildVm();
      await vm.prepare();
      vm.setFileName('custom.mpq');

      await vm.start();

      expect(useCase.executedPaths, [p.join(mpqDir, 'custom.mpq')]);
      expect(vm.status.value, WorkflowStatus.succeeded);
      expect(vm.result.value?.success, isTrue);
    },
  );

  test('setFileName falls back to the default when empty', () async {
    final vm = buildVm();
    vm.setFileName('   ');
    expect(vm.fileName.value, MpqExportWorkflowViewModel.defaultPatchFileName);
  });
}

/// Fake MPQ export use case: records executed paths and returns a success
/// result; loadTables is scripted. The superclass fields are never touched.
final class _FakeMpqExportUseCase extends MpqExportUseCase {
  List<DbcExportTable> tables = [];

  final executedPaths = <String>[];
  _FakeMpqExportUseCase() : super.protected();

  @override
  bool get isRunning => false;

  @override
  Future<DbcSyncResult> execute(MpqExportInput input) async {
    executedPaths.add(input.mpqFilePath);
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
