import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/use_case/dbc/check_dbc_reminder_use_case.dart';

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

DbcTableCheckResult _missing(String tableName) => DbcTableCheckResult(
  tableName: tableName,
  state: DbcTableState.missing,
);

DbcTableCheckResult _ready(String tableName) => DbcTableCheckResult(
  tableName: tableName,
  state: DbcTableState.ready,
);

void main() {
  test('无缺失表时不提醒也不写配置', () async {
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

  test('有缺失且从未提醒时提醒并写入全量缺失', () async {
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
    expect(result.missingTables, ['dbc_skill_line_ability', 'dbc_skill_tiers']);
    expect(result.newlyMissing, ['dbc_skill_line_ability', 'dbc_skill_tiers']);
    expect(
      config.data[CheckDbcReminderUseCase.notifiedKey],
      ['dbc_skill_line_ability', 'dbc_skill_tiers'],
    );
  });

  test('缺失集合与上次提醒相同时不再提醒', () async {
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

  test('出现新增缺失时提醒并更新基线为全量缺失', () async {
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
    expect(
      config.data[CheckDbcReminderUseCase.notifiedKey],
      ['dbc_skill_line_ability', 'dbc_skill_tiers'],
    );
  });
}
