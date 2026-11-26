import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/model/dbc/dbc_sync_progress.dart';
import 'package:foxy/use_case/dbc/check_dbc_reminder_use_case.dart';

void main() {
  test('No missing tables means no reminder or configuration write', () async {
    final config = _FakeConfigUtil();
    final useCase = CheckDbcReminderUseCase(
      checkTables: () async => [_ready('dbc_spell')],
      configUtil: config,
    );

    final result = await useCase.execute();

    expect(result.shouldRemind, isFalse);
    expect(result.missingTables, isEmpty);
    expect(result.newlyMissing, isEmpty);
    expect(config.data, isEmpty);
  });

  test(
    'The first missing-table reminder records the full missing set',
    () async {
      final config = _FakeConfigUtil();
      final useCase = CheckDbcReminderUseCase(
        checkTables: () async => [
          _ready('dbc_spell'),
          _missing('dbc_skill_tiers'),
          _missing('dbc_skill_line_ability'),
        ],
        configUtil: config,
      );

      final result = await useCase.execute();

      expect(result.shouldRemind, isTrue);
      expect(result.missingTables, [
        'dbc_skill_line_ability',
        'dbc_skill_tiers',
      ]);
      expect(result.newlyMissing, [
        'dbc_skill_line_ability',
        'dbc_skill_tiers',
      ]);
      expect(config.data[CheckDbcReminderUseCase.notifiedKey], [
        'dbc_skill_line_ability',
        'dbc_skill_tiers',
      ]);
    },
  );

  test('An unchanged missing set does not trigger another reminder', () async {
    final config = _FakeConfigUtil({
      CheckDbcReminderUseCase.notifiedKey: ['dbc_skill_tiers'],
    });
    final useCase = CheckDbcReminderUseCase(
      checkTables: () async => [_missing('dbc_skill_tiers')],
      configUtil: config,
    );

    final result = await useCase.execute();

    expect(result.shouldRemind, isFalse);
    expect(result.missingTables, ['dbc_skill_tiers']);
    expect(result.newlyMissing, isEmpty);
    // Baseline is unchanged.
    expect(config.data, hasLength(1));
  });

  test('New missing tables trigger a reminder and replace the baseline with the full missing set', () async {
    final config = _FakeConfigUtil({
      CheckDbcReminderUseCase.notifiedKey: ['dbc_skill_tiers'],
    });
    final useCase = CheckDbcReminderUseCase(
      checkTables: () async => [
        _missing('dbc_skill_tiers'),
        _missing('dbc_skill_line_ability'),
      ],
      configUtil: config,
    );

    final result = await useCase.execute();

    expect(result.shouldRemind, isTrue);
    expect(result.missingTables, ['dbc_skill_line_ability', 'dbc_skill_tiers']);
    expect(result.newlyMissing, ['dbc_skill_line_ability']);
    expect(config.data[CheckDbcReminderUseCase.notifiedKey], [
      'dbc_skill_line_ability',
      'dbc_skill_tiers',
    ]);
  });
}

DbcTableCheckResult _missing(String tableName) =>
    DbcTableCheckResult(tableName: tableName, state: DbcTableState.missing);

DbcTableCheckResult _ready(String tableName) =>
    DbcTableCheckResult(tableName: tableName, state: DbcTableState.ready);

/// In-memory ConfigUtil fake (the real one persists YAML to disk).
class _FakeConfigUtil implements ConfigUtil {
  final Map<String, dynamic> data;

  _FakeConfigUtil([Map<String, dynamic>? initial])
    : data = Map<String, dynamic>.from(initial ?? const {});

  @override
  String get configPath => 'fake';

  @override
  Future<Map<String, dynamic>> load() async => data;

  @override
  Future<void> update(Map<String, dynamic> values) async {
    data.addAll(values);
  }
}
