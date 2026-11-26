import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:foxy/repository/dbc_export_registry.dart';
import 'package:foxy/use_case/dbc/dbc_export_shared.dart';
import 'package:foxy/use_case/mpq/mpq_export_use_case.dart';

void main() {
  test(
    'Table counts run concurrently in batches within the configured limit',
    () async {
      final registry = _CountingRegistry();

      final tables = await DbcExportShared.loadDbcExportTables(registry);

      expect(tables, hasLength(DbcDefinitions.all.length));
      expect(registry.calls, DbcDefinitions.all.length);
      expect(
        registry.maxActive,
        DbcExportShared.countBatchSize,
        reason: '每批内并发，而批与批之间串行',
      );
      expect(registry.maxActive, greaterThan(1), reason: '不再是逐表串行');
    },
  );

  test(
    'A failed count disables only that table and returns the remaining tables',
    () async {
      final failing = DbcDefinitions.all[3];
      final registry = _CountingRegistry(failingTables: {failing.tableName});

      final tables = await DbcExportShared.loadDbcExportTables(registry);

      final failed = tables.firstWhere((table) => table.definition == failing);
      expect(failed.countError, isNotNull);
      expect(failed.recordCount, isNull);
      expect(
        tables.where((table) => table.countError == null),
        hasLength(DbcDefinitions.all.length - 1),
      );
    },
  );

  test('Tables are returned in file name order', () async {
    final tables = await DbcExportShared.loadDbcExportTables(
      _CountingRegistry(),
    );

    final fileNames = tables
        .map((table) => table.definition.fileName)
        .toList(growable: false);
    expect(fileNames, orderedEquals(fileNames.toList()..sort()));
  });

  test('The MPQ use case uses the shared export entry point', () async {
    final registry = _CountingRegistry();
    final useCase = MpqExportUseCase(
      registry: registry,
      dbcSyncUtil: DbcSyncUtil(),
      configUtil: _MemoryConfigUtil({}),
    );

    final tables = await useCase.loadTables();

    expect(tables, hasLength(DbcDefinitions.all.length));
    expect(registry.calls, DbcDefinitions.all.length);
  });
}

/// Counts `countRows` calls and tracks the peak in-flight count, so a
/// regression to sequential counting (peak 1) is caught.
final class _CountingRegistry implements DbcExportRegistry {
  final Set<String> failingTables;

  int calls = 0;
  int _active = 0;
  int maxActive = 0;
  _CountingRegistry({this.failingTables = const {}});

  @override
  bool contains(String tableName) => true;

  @override
  Future<DbcExportCountResult> countRows(String tableName) async {
    calls++;
    _active++;
    if (_active > maxActive) maxActive = _active;
    await Future<void>.delayed(const Duration(milliseconds: 1));
    _active--;
    if (failingTables.contains(tableName)) {
      return DbcExportCountResult.failure(StateError('count failed'));
    }
    return const DbcExportCountResult.success(1);
  }

  @override
  Future<List<Map<String, dynamic>>> loadRows(String tableName) async => [
    {'ID': 1},
  ];
}

/// In-memory ConfigUtil (no real IO).
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
