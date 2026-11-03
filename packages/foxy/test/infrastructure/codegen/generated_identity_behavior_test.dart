import 'dart:async';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/view_model/emote_text_detail_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late EventBus bus;
  setUp(() {
    bus = EventBus(sync: true);
    GetIt.instance.registerSingleton<EventBus>(bus);
  });
  tearDown(() async {
    bus.destroy();
    await GetIt.instance.reset();
  });

  Future<EmoteTextDetailViewModel> form(_CollisionDriver driver) async {
    GetIt.instance.registerSingleton<EmoteTextRepository>(
      _Repository(Laconic(driver)),
    );
    final vm = EmoteTextDetailViewModel();
    addTearDown(() {
      if (!vm.isDisposed) vm.dispose();
    });
    await vm.initSignals();
    expect(vm.idController.collect(), 100);
    return vm;
  }

  for (final collide in [false, true]) {
    test('${collide ? '主键冲突重分配' : '无冲突'}后同步实际主键并支持再次保存', () async {
      final driver = _CollisionDriver(collide: collide);
      final vm = await form(driver);
      final expectedKey = collide ? 101 : 100;
      await vm.persist();

      expect(driver.writtenId, expectedKey);
      expect(vm.persistedKey.value, expectedKey);
      expect(vm.entity.value!.id, expectedKey);
      expect(vm.idController.collect(), expectedKey);

      await vm.persist();
      expect(driver.updatedKeys, [(expectedKey, expectedKey)]);
    });
  }

  test('复制发生主键冲突时返回实际写入主键', () async {
    final driver = _CollisionDriver(collide: true);
    final repository = _Repository(Laconic(driver));
    final returnedKey = await repository.copyEmoteText(1);
    expect(driver.writtenId, 101);
    expect(returnedKey, driver.writtenId);
  });

  test('保存等待期间销毁表单后不再写入已释放的控制器', () async {
    final gate = Completer<void>();
    final driver = _CollisionDriver(collide: true, retryGate: gate);
    final vm = await form(driver);
    final pending = vm.persist();
    await driver.retryStarted.future;
    vm.dispose();
    gate.complete();
    await pending;
    expect(driver.writtenId, 101);
    expect(vm.entity.value!.id, 101);
  });

  test('主键重分配保留保存等待期间其他字段的新输入', () async {
    final gate = Completer<void>();
    final driver = _CollisionDriver(collide: true, retryGate: gate);
    final vm = await form(driver);
    final pending = vm.persist();
    await driver.retryStarted.future;
    vm.nameController.init('editing while saving');
    gate.complete();
    await pending;
    expect(vm.idController.collect(), 101);
    expect(vm.nameController.collect(), 'editing while saving');
  });
}

class _Repository extends EmoteTextRepository {
  @override
  final Laconic laconic;
  _Repository(this.laconic);
}

class _CollisionDriver implements DatabaseDriver {
  final bool collide;
  final Completer<void>? retryGate;
  final retryStarted = Completer<void>();
  final updatedKeys = <(int, int)>[];
  int insertAttempts = 0;
  int? writtenId;
  final rows = <int, Map<String, dynamic>>{
    1: const EmoteTextEntity(id: 1, name: 'source').toJson(),
    99: const EmoteTextEntity(id: 99).toJson(),
  };
  _CollisionDriver({required this.collide, this.retryGate});

  @override
  final SqlGrammar grammar = MysqlGrammar();

  LaconicException duplicate() =>
      LaconicException('duplicate primary key', driver: 'mysql', code: '1062');

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    if (sql.toLowerCase().contains('max(')) {
      return [
        LaconicResult.fromMap({'max_id': rows.keys.reduce(max)}),
      ];
    }
    final row = rows[params.first];
    return row == null ? [] : [LaconicResult.fromMap(row)];
  }

  @override
  Future<void> statement(String sql, [List<Object?> params = const []]) async {
    if (!sql.toLowerCase().startsWith('insert')) throw StateError(sql);
    insertAttempts++;
    final id = params.first as int;
    if (collide && insertAttempts == 1) {
      rows[id] = EmoteTextEntity(id: id, name: 'concurrent insert').toJson();
      throw duplicate();
    }
    if (rows.containsKey(id)) throw duplicate();
    if (insertAttempts > 1) {
      retryStarted.complete();
      await retryGate?.future;
    }
    writtenId = id;
    rows[id] = EmoteTextEntity(id: id).toJson();
  }

  @override
  Future<int> affectingStatement(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    final newId = params.first as int;
    final oldId = params.last as int;
    updatedKeys.add((oldId, newId));
    if (newId != oldId && rows.containsKey(newId)) throw duplicate();
    return 1;
  }

  @override
  Future<void> close() async {}
  @override
  Future<int> insertAndGetId(
    String sql, [
    List<Object?> params = const [],
  ]) async => throw UnimplementedError();
  @override
  Future<T> transaction<T>(Future<T> Function() action) => action();
}
