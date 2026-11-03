import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/repository/quest_info_repository.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/view_model/quest_info_detail_view_model.dart';
import 'package:foxy/view_model/quest_sort_detail_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late EventBus bus;
  final events = <EntityWrittenEvent>[];
  setUp(() {
    events.clear();
    bus = EventBus(sync: true);
    bus.on<EntityWrittenEvent>().listen(events.add);
    GetIt.instance.registerSingleton<EventBus>(bus);
  });
  tearDown(() async {
    bus.destroy();
    await GetIt.instance.reset();
  });

  test('QuestInfo 普通保存保留全部语言，语言回填保留 ID 和 Flags 草稿', () async {
    final row = _localizedRow('InfoName_lang');
    final driver = _Driver(row);
    GetIt.instance.registerSingleton<QuestInfoRepository>(
      _InfoRepository(Laconic(driver)),
    );
    final vm = QuestInfoDetailViewModel();
    addTearDown(vm.dispose);
    await vm.initSignals(key: 1);
    vm.nameController.init('名称草稿');
    await vm.persist();
    row['InfoName_lang_zhCN'] = '名称草稿';
    expect(driver.updates.last, [...row.values, 1]);

    vm.idController.init(2);
    vm.infoNameLangFlagsController.init(123);
    vm.applyInfoNameLocales(_editedLocales);
    expect(vm.nameController.collect(), 'edited zhCN');
    expect(vm.entity.value!.infoNameLangEnUS, 'edited enUS');
    await vm.persist();
    expect(driver.updates.last, [..._editedRow('InfoName_lang').values, 1]);
    expect(vm.persistedKey.value, 2);
    expect(events.last.log.module, 'quest_info');
    expect(events.last.log.entityName, 'edited zhCN');
  });

  test('QuestSort 普通保存保留全部语言，语言回填保留 ID 和 Flags 草稿', () async {
    final row = _localizedRow('SortName_lang');
    final driver = _Driver(row);
    GetIt.instance.registerSingleton<QuestSortRepository>(
      _SortRepository(Laconic(driver)),
    );
    final vm = QuestSortDetailViewModel();
    addTearDown(vm.dispose);
    await vm.initSignals(key: 1);
    vm.nameController.init('名称草稿');
    await vm.persist();
    row['SortName_lang_zhCN'] = '名称草稿';
    expect(driver.updates.last, [...row.values, 1]);

    vm.idController.init(2);
    vm.sortNameLangFlagsController.init(123);
    vm.applySortNameLocales(_editedLocales);
    expect(vm.nameController.collect(), 'edited zhCN');
    expect(vm.entity.value!.sortNameLangEnUS, 'edited enUS');
    await vm.persist();
    expect(driver.updates.last, [..._editedRow('SortName_lang').values, 1]);
    expect(vm.persistedKey.value, 2);
    expect(events.last.log.module, 'quest_sort');
    expect(events.last.log.entityName, 'edited zhCN');
  });

  for (final (name, prefix, limit) in [
    ('QuestInfo', 'InfoName_lang', 65535),
    ('QuestSort', 'SortName_lang', 32768),
  ]) {
    group(name, () {
      late _Driver driver;
      late Future<int> Function() create;
      late Future<int> Function(int) copy;
      setUp(() {
        driver = _Driver(_localizedRow(prefix));
        if (name == 'QuestInfo') {
          final repository = _InfoRepository(Laconic(driver));
          create = () async => (await repository.createQuestInfo()).id;
          copy = repository.copyQuestInfo;
        } else {
          final repository = _SortRepository(Laconic(driver));
          create = () async => (await repository.createQuestSort()).id;
          copy = repository.copyQuestSort;
        }
      });

      test('创建与复制允许分配上限 ID，耗尽后拒绝分配', () async {
        driver.maxId = limit - 1;
        expect(await create(), limit);
        expect(await copy(1), limit);
        expect(driver.inserts.single, [
          ...{...driver.source, 'ID': limit}.values,
        ]);
        await expectLater(create(), throwsA(isA<IdExhaustedException>()));
        await expectLater(copy(1), throwsA(isA<IdExhaustedException>()));
        expect(driver.insertAttempts, 1);
      });

      test('复制冲突后返回实际主键并保留全部语言和 Flags', () async {
        driver.collide = true;
        final key = await copy(1);
        expect(key, 12);
        expect(driver.inserts.single, [
          ...{...driver.source, 'ID': key}.values,
        ]);
      });

      test('冲突重试在 ID 耗尽时停止，不写入越界 ID', () async {
        driver.maxId = limit - 1;
        driver.collide = true;
        await expectLater(copy(1), throwsA(isA<IdExhaustedException>()));
        expect(driver.insertAttempts, 1);
        expect(driver.inserts, isEmpty);
      });
    });
  }
}

Map<String, dynamic> _localizedRow(String prefix) => {
  'ID': 1,
  for (final locale in DbcLocale.values)
    '${prefix}_${locale.code}': 'original ${locale.code}',
  '${prefix}_Flags': 37,
};

final _editedLocales = [
  for (final locale in DbcLocale.values)
    DbcLocaleFieldValue(locale: locale, value: 'edited ${locale.code}'),
];

Map<String, dynamic> _editedRow(String prefix) => {
  'ID': 2,
  for (final locale in _editedLocales)
    '${prefix}_${locale.locale.code}': locale.value,
  '${prefix}_Flags': 123,
};

class _InfoRepository extends QuestInfoRepository {
  @override
  final Laconic laconic;
  _InfoRepository(this.laconic);
}

class _SortRepository extends QuestSortRepository {
  @override
  final Laconic laconic;
  _SortRepository(this.laconic);
}

class _Driver implements DatabaseDriver {
  final Map<String, dynamic> source;
  int maxId = 10;
  bool collide = false;
  int insertAttempts = 0;
  final inserts = <List<Object?>>[];
  final updates = <List<Object?>>[];
  _Driver(this.source);

  @override
  final SqlGrammar grammar = MysqlGrammar();

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async => [
    LaconicResult.fromMap(
      sql.toLowerCase().contains('max(') ? {'max_id': maxId} : source,
    ),
  ];

  @override
  Future<void> statement(String sql, [List<Object?> params = const []]) async {
    insertAttempts++;
    maxId = params.first as int;
    if (collide && insertAttempts == 1) {
      throw LaconicException(
        'duplicate primary key',
        driver: 'mysql',
        code: '1062',
      );
    }
    inserts.add(List.of(params));
  }

  @override
  Future<int> affectingStatement(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    updates.add(List.of(params));
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
