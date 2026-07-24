import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/page/smart_script/smart_script_detail_view_model.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('SmartScriptKey 与 Brief 覆盖四列主键', () {
    const entity = SmartScriptEntity(
      entryOrGuid: 10,
      sourceType: 1,
      id: 2,
      link: 3,
    );
    final key = SmartScriptKey.fromEntity(entity);
    final same = SmartScriptKey.fromEntity(entity.copyWith(comment: 'x'));
    const brief = BriefSmartScriptEntity(
      entryOrGuid: 10,
      sourceType: 1,
      id: 2,
      link: 3,
      comment: '测试脚本',
    );

    expect(key, same);
    expect(key.hashCode, same.hashCode);
    expect(
      key,
      isNot(SmartScriptKey.fromEntity(entity.copyWith(sourceType: 2))),
    );
    expect(key, isNot(SmartScriptKey.fromEntity(entity.copyWith(link: 4))));
    expect(brief.key, key);
    expect(brief.displayName, '测试脚本');
  });

  test('UPDATE 用旧四列 key 定位并写入 candidate 全部 31 列', () async {
    final queries = <LaconicQuery>[];
    final repository = _TestRepository(
      Laconic(_RecordingDriver(), listen: queries.add),
    );
    const oldKey = SmartScriptKey(
      entryOrGuid: 10,
      sourceType: 0,
      id: 2,
      link: 3,
    );
    const candidate = SmartScriptEntity(
      entryOrGuid: 11,
      sourceType: 1,
      id: 4,
      link: 5,
      eventType: 6,
      actionType: 7,
      targetType: 8,
      comment: 'candidate',
    );

    await repository.updateSmartScript(oldKey, candidate);

    expect(queries.single.bindings, [
      ...candidate.toJson().values,
      oldKey.entryOrGuid,
      oldKey.sourceType,
      oldKey.id,
      oldKey.link,
    ]);
  });

  test('UPDATE 和 DELETE 零行报告旧记录不存在', () async {
    final repository = _TestRepository(
      Laconic(_RecordingDriver(affectedRows: 0)),
    );
    const key = SmartScriptKey(entryOrGuid: 10, sourceType: 0, id: 2, link: 3);
    await expectLater(
      repository.updateSmartScript(key, const SmartScriptEntity()),
      throwsA(isA<StateError>()),
    );
    await expectLater(
      repository.destroySmartScript(key),
      throwsA(isA<StateError>()),
    );
  });

  group('persisted detail identity', () {
    late _FakeRepository repository;

    setUp(() {
      repository = _FakeRepository([
        const SmartScriptEntity(
          entryOrGuid: 10,
          sourceType: 0,
          id: 2,
          link: 0,
          eventType: 4,
          actionType: 24,
          targetType: 1,
        ),
      ]);
      GetIt.instance.registerSingleton<SmartScriptRepository>(repository);
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());
      GetIt.instance.registerSingleton<EventBus>(EventBus());
      final activityLogRepository = _FakeActivityLogRepository();
      GetIt.instance.registerSingleton<ActivityLogRepository>(
        activityLogRepository,
      );
      GetIt.instance.registerSingleton(
        ActivityLogService(activityLogRepository),
      );
    });

    tearDown(() async => GetIt.instance.reset());

    test('主键更新失败保留旧 key，重试后切换到新 key', () async {
      const oldKey = SmartScriptKey(
        entryOrGuid: 10,
        sourceType: 0,
        id: 2,
        link: 0,
      );
      final viewModel = SmartScriptDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(key: oldKey);
      viewModel.entryOrGuidController.init(11);
      viewModel.idController.init(3);
      viewModel.linkController.init(4);
      repository.failUpdates = true;

      await expectLater(viewModel.persist(), throwsA(isA<StateError>()));
      expect(viewModel.persistedKey.value, oldKey);

      repository.failUpdates = false;
      await viewModel.persist();
      const newKey = SmartScriptKey(
        entryOrGuid: 11,
        sourceType: 0,
        id: 3,
        link: 4,
      );
      expect(repository.updateKeys, [oldKey, oldKey]);
      expect(viewModel.persistedKey.value, newKey);
      expect(viewModel.entity.value, isNotNull);
    });

    test('新建候选在表单打开时已有显式 id，保存不重新分配', () async {
      repository.rows.clear();
      final viewModel = SmartScriptDetailViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals();
      expect(viewModel.idController.collect(), 1);
      viewModel.entryOrGuidController.init(20);
      viewModel.eventTypeController.init(4);
      viewModel.actionTypeController.init(24);
      viewModel.targetTypeController.init(1);

      await viewModel.persist();

      expect(repository.stored.single.id, 1);
      expect(viewModel.persistedKey.value?.id, 1);
    });
  });

  test('Full/Brief、typed route 与键控件遵守迁移边界', () {
    final entity = File(
      'lib/entity/smart_script_entity.dart',
    ).readAsStringSync();
    final repository = File(
      'lib/repository/smart_script_repository.dart',
    ).readAsStringSync();
    final detailViewModel = File(
      'lib/page/smart_script/smart_script_detail_view_model.dart',
    ).readAsStringSync();
    final detailPage = File(
      'lib/page/smart_script/smart_script_detail_page.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/smart_script/smart_script_view.dart',
    ).readAsStringSync();
    final generated = File('lib/router/router.gr.dart').readAsStringSync();

    expect(entity, isNot(matches(RegExp(r'class\s+BriefSmartScriptEntity\b'))));
    expect(repository, isNot(contains('saveSmartScript')));
    expect(
      detailViewModel,
      contains('final persistedKey = signal<SmartScriptKey?>'),
    );
    expect(detailViewModel, isNot(contains('nextIdFor(t.')));
    expect(detailPage, contains('final SmartScriptKey? scriptKey'));
    expect(generated, contains('SmartScriptKey? scriptKey'));
    expect(view, isNot(contains('ownerEditable')));
    expect(
      view,
      isNot(
        contains(
          "_numberItem('ID', 'id', viewModel.idController, readOnly: true)",
        ),
      ),
    );
  });
}

class _FakeRepository extends SmartScriptRepository {
  final List<SmartScriptEntity> rows;
  bool failUpdates = false;
  final updateKeys = <SmartScriptKey>[];
  final stored = <SmartScriptEntity>[];

  _FakeRepository(this.rows);

  @override
  Future<SmartScriptEntity> createSmartScript({
    int entryOrGuid = 0,
    int sourceType = 0,
  }) async => SmartScriptEntity(
    entryOrGuid: entryOrGuid,
    sourceType: sourceType,
    id: 1,
  );

  @override
  Future<SmartScriptEntity?> getSmartScript(SmartScriptKey key) async {
    for (final row in rows) {
      if (SmartScriptKey.fromEntity(row) == key) return row;
    }
    return null;
  }

  @override
  Future<void> storeSmartScript(SmartScriptEntity script) async {
    stored.add(script);
    rows.add(script);
  }

  @override
  Future<void> updateSmartScript(
    SmartScriptKey originalKey,
    SmartScriptEntity script,
  ) async {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    final index = rows.indexWhere(
      (row) => SmartScriptKey.fromEntity(row) == originalKey,
    );
    if (index < 0) throw StateError('missing');
    rows[index] = script;
  }
}

class _FakeActivityLogRepository extends ActivityLogRepository {
  @override
  void storeActivityLogBestEffort(ActivityLogEntity log) {}
}

class _RecordingDriver implements DatabaseDriver {
  @override
  final SqlGrammar grammar = MysqlGrammar();
  final int affectedRows;
  _RecordingDriver({this.affectedRows = 1});

  @override
  Future<int> affectingStatement(
    String sql, [
    List<Object?> params = const [],
  ]) async => affectedRows;
  @override
  Future<void> close() async {}
  @override
  Future<int> insertAndGetId(
    String sql, [
    List<Object?> params = const [],
  ]) async => 1;
  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async => const [];
  @override
  Future<void> statement(String sql, [List<Object?> params = const []]) async {}
  @override
  Future<T> transaction<T>(Future<T> Function() action) => action();
}

class _TestRepository extends SmartScriptRepository {
  @override
  final Laconic laconic;
  _TestRepository(this.laconic);
}
