import 'dart:io';
import 'dart:isolate';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_registry.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_worker.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/infrastructure/dbc/mpq_export_worker.dart';
import 'package:foxy/use_case/dbc/export_dbc_use_case.dart';
import 'package:foxy/use_case/mpq/mpq_export_use_case.dart';
import 'package:foxy/view_model/mpq_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/workflow_status.dart';

/// Reproduces the reported bug: after an MPQ export completes, the next
/// DBC task must not be rejected as busy. Uses a real [DbcSyncUtil] with a
/// scripted success worker so the isolate lifecycle is exercised end-to-end.
void main() {
  test('MPQ 导出完成后 VM 与 DbcSyncUtil 均复位，DBC 导出立即可用', () async {
    final tempDir = Directory.systemTemp.createTempSync('foxy_export_flow_');
    addTearDown(() async {
      if (await tempDir.exists()) await tempDir.delete(recursive: true);
    });

    final util = DbcSyncUtil(
      exportWorkerEntry: _SuccessExportWorker.run,
      mpqWorkerEntry: _SuccessMpqWorker.run,
    );
    final registry = _FakeRegistry();
    final cfg = _MemoryConfigUtil({
      'mpq_dir': tempDir.path,
      'dbc_dir': tempDir.path,
    });

    final mpqUseCase = MpqExportUseCase(
      registry: registry,
      dbcSyncUtil: util,
      configUtil: cfg,
    );
    final mpqVm = MpqExportWorkflowViewModel(
      useCase: mpqUseCase,
      configUtil: cfg,
    );

    await mpqVm.prepare();
    expect(mpqVm.status.value, WorkflowStatus.idle);
    expect(mpqVm.isRunning, isFalse);

    await mpqVm.start().timeout(const Duration(seconds: 10));
    expect(mpqVm.status.value, WorkflowStatus.succeeded);
    expect(
      mpqVm.isRunning,
      isFalse,
      reason: 'MPQ 导出完成后 VM 不得残留运行状态（busy 置灰按钮的根因）',
    );
    expect(
      util.isRunning,
      isFalse,
      reason: 'MPQ 导出完成后共享 DbcSyncUtil 不得残留运行状态',
    );
    expect(util.operation, isNull);

    // 紧接着的 DBC 导出不得被拒为 busy。
    final dbcUseCase = ExportDbcUseCase(
      registry: registry,
      dbcSyncUtil: util,
      configUtil: cfg,
    );
    final result = await dbcUseCase
        .execute(
          ExportDbcInput(
            definitions: [DbcDefinitions.byTable['dbc_spell_duration']!],
            outputDirectory: tempDir.path,
          ),
        )
        .timeout(const Duration(seconds: 10));
    expect(result.success, isTrue);
    expect(util.isRunning, isFalse);
  });
}

/// Scripted success worker for both export entries: registers the control
/// port, emits one count, then a success result, and exits.
final class _SuccessExportWorker {
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

/// MPQ worker entry must accept [MpqExportWorkerArgs]; same scripted body.
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
