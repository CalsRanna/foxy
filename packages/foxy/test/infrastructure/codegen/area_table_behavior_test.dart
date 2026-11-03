import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/view_model/area_table_detail_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late _Driver driver;
  late _Repository repository;
  late EventBus bus;
  final events = <EntityWrittenEvent>[];
  setUp(() {
    driver = _Driver();
    repository = _Repository(Laconic(driver));
    bus = EventBus(sync: true);
    events.clear();
    bus.on<EntityWrittenEvent>().listen(events.add);
    GetIt.instance.registerSingleton<EventBus>(bus);
    GetIt.instance.registerSingleton<AreaTableRepository>(repository);
  });
  tearDown(() async {
    bus.destroy();
    await GetIt.instance.reset();
  });

  Future<AreaTableDetailViewModel> form({int? key}) async {
    final vm = AreaTableDetailViewModel();
    addTearDown(vm.dispose);
    await vm.initSignals(key: key);
    return vm;
  }

  test('保存保留全部语言，语言回填保留草稿，改 ID 时排除自身 AreaBit', () async {
    final vm = await form(key: 1);
    vm.nameController.init('区域名称草稿');
    await vm.persist();
    expect(
      driver.rows[1],
      _source.copyWith(areaNameLangZhCN: '区域名称草稿').toJson(),
    );

    vm.idController.init(2);
    vm.flagsController.init(0x40000001);
    vm.factionGroupMaskController.init(4);
    vm.areaNameLangFlagsController.init(127);
    vm.ambientMultiplierController.init(0.5);
    vm.applyAreaNameLocales([
      for (final locale in DbcLocale.values)
        DbcLocaleFieldValue(locale: locale, value: 'edited ${locale.code}'),
    ]);
    expect(vm.nameController.collect(), 'edited zhCN');
    expect(vm.entity.value!.areaNameLangEnUS, 'edited enUS');
    await vm.persist();
    expect(driver.rows.containsKey(1), isFalse);
    expect(driver.rows[2], {
      ..._source.toJson(),
      'ID': 2,
      'Flags': 0x40000001,
      'FactionGroupMask': 4,
      'AreaName_lang_Flags': 127,
      'Ambient_multiplier': 0.5,
      for (final locale in DbcLocale.values)
        'AreaName_lang_${locale.code}': 'edited ${locale.code}',
    });
    expect(vm.persistedKey.value, 2);
    expect(events.last.log.module, 'area_table');
    expect(events.last.log.entityName, 'edited zhCN');
  });

  for (final key in [null, 1]) {
    test('${key == null ? '新建' : '更新'}拒绝重复 AreaBit 和无效父区域，修正后可保存', () async {
      final vm = await form(key: key);
      vm.areaBitController.init(key == null ? 50 : 90);
      await expectLater(vm.persist(), throwsA(isA<DuplicateKeyException>()));
      expect(driver.insertAttempts, 0);
      expect(driver.updatedKeys, isEmpty);
      expect(vm.persistedKey.value, key);
      expect(vm.submitting.value, isFalse);
      expect(vm.errorMessage.value, isNotEmpty);
      expect(events, isEmpty);

      vm.areaBitController.init(101);
      vm.parentAreaIdController.init(999);
      await expectLater(vm.persist(), throwsA(isA<RecordNotFoundException>()));
      expect(driver.insertAttempts, 0);
      expect(driver.updatedKeys, isEmpty);
      expect(vm.areaBitController.collect(), 101);
      expect(vm.parentAreaIdController.collect(), 999);
      expect(vm.persistedKey.value, key);
      expect(vm.submitting.value, isFalse);

      vm.parentAreaIdController.init(0);
      await vm.persist();
      final row = driver.rows[vm.persistedKey.value]!;
      expect(row['ParentAreaID'], 0);
      expect(row['AreaBit'], 101);
      expect(vm.errorMessage.value, isNull);
    });
  }

  test('新建分别分配 ID 和 AreaBit，主键冲突后同步实际 ID 并支持再次保存', () async {
    driver.collide = true;
    final vm = await form();
    expect(vm.idController.collect(), 11);
    expect(vm.areaBitController.collect(), 91);
    vm.nameController.init('新区域');
    await vm.persist();
    expect(vm.persistedKey.value, 12);
    expect(vm.entity.value!.id, 12);
    expect(vm.idController.collect(), 12);
    expect(vm.areaBitController.collect(), 91);
    expect(driver.rows[12]!['AreaBit'], 91);

    await vm.persist();
    expect(driver.updatedKeys, [(12, 12)]);
    expect(driver.rows[12]!['AreaName_lang_zhCN'], '新区域');
  });

  for (final collide in [false, true]) {
    test('复制${collide ? '发生主键冲突' : '无冲突'}时分配新 AreaBit，保留多语言并返回实际 ID', () async {
      driver.collide = collide;
      final key = await repository.copyAreaTable(1);
      expect(key, collide ? 12 : 11);
      expect(driver.rows[key], _source.copyWith(id: key, areaBit: 91).toJson());
      expect(driver.rows[1], _source.toJson());
    });
  }

  test('复制也校验父区域，拒绝复制父区域已不存在的记录', () async {
    driver.rows.remove(10);
    await expectLater(
      repository.copyAreaTable(1),
      throwsA(isA<RecordNotFoundException>()),
    );
    expect(driver.insertAttempts, 0);
  });
}

final _source = AreaTableEntity.fromJson({
  ...const AreaTableEntity(
    id: 1,
    continentId: 530,
    parentAreaId: 10,
    areaBit: 50,
    flags: 65,
    soundProviderPref: 2,
    soundProviderPrefUnderwater: 3,
    ambienceId: 4,
    zoneMusic: 5,
    introSound: 6,
    explorationLevel: 70,
    areaNameLangFlags: 37,
    factionGroupMask: 2,
    liquidTypeId0: 11,
    liquidTypeId1: 12,
    liquidTypeId2: 13,
    liquidTypeId3: 14,
    minElevation: -4.5,
    ambientMultiplier: 0.75,
    lightId: 7,
  ).toJson(),
  for (final locale in DbcLocale.values)
    'AreaName_lang_${locale.code}': 'original ${locale.code}',
});

class _Repository extends AreaTableRepository {
  @override
  final Laconic laconic;
  _Repository(this.laconic);
}

class _Driver implements DatabaseDriver {
  final rows = {
    1: _source.toJson(),
    10: const AreaTableEntity(id: 10, areaBit: 90).toJson(),
  };
  bool collide = false;
  int insertAttempts = 0;
  final updatedKeys = <(int, int)>[];

  @override
  final SqlGrammar grammar = MysqlGrammar();

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    final query = sql.toLowerCase().replaceAll('`', '');
    if (query.contains('max(')) {
      final column = query.contains('max(areabit)') ? 'AreaBit' : 'ID';
      return [
        LaconicResult.fromMap({
          'max_id': rows.values.map((row) => row[column] as int).reduce(max),
        }),
      ];
    }
    if (query.contains('count(')) {
      final excludedId = query.contains('id != ?') ? params[1] : null;
      return [
        LaconicResult.fromMap({
          'aggregate': rows.values
              .where(
                (row) =>
                    row['AreaBit'] == params.first && row['ID'] != excludedId,
              )
              .length,
        }),
      ];
    }
    final row = rows[params.first];
    return row == null ? [] : [LaconicResult.fromMap(row)];
  }

  @override
  Future<void> statement(String sql, [List<Object?> params = const []]) async {
    insertAttempts++;
    final row = Map<String, dynamic>.fromIterables(
      _source.toJson().keys,
      params,
    );
    final id = row['ID'] as int;
    if (collide && insertAttempts == 1) {
      rows[id] = AreaTableEntity(id: id, areaBit: 0).toJson();
      throw LaconicException(
        'duplicate primary key',
        driver: 'mysql',
        code: '1062',
      );
    }
    if (rows.containsKey(id)) {
      throw LaconicException(
        'duplicate primary key',
        driver: 'mysql',
        code: '1062',
      );
    }
    rows[id] = row;
  }

  @override
  Future<int> affectingStatement(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    final oldId = params.last as int;
    if (!rows.containsKey(oldId)) return 0;
    final row = Map<String, dynamic>.fromIterables(
      _source.toJson().keys,
      params.take(params.length - 1),
    );
    final id = row['ID'] as int;
    updatedKeys.add((oldId, id));
    rows.remove(oldId);
    rows[id] = row;
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
