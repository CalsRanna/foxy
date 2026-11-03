import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/repository/spell_item_enchantment_repository.dart';
import 'package:foxy/view_model/spell_item_enchantment_detail_view_model.dart';
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
    GetIt.instance.registerSingleton<SpellItemEnchantmentRepository>(
      repository,
    );
  });
  tearDown(() async {
    bus.destroy();
    await GetIt.instance.reset();
  });

  Future<SpellItemEnchantmentDetailViewModel> form({int? key}) async {
    final vm = SpellItemEnchantmentDetailViewModel();
    addTearDown(vm.dispose);
    await vm.initSignals(key: key);
    return vm;
  }

  test('表单往返保存保留多语言和效果参数，语言回填不覆盖其他草稿', () async {
    final vm = await form(key: 1);
    await vm.persist();
    expect(driver.updates.last, [..._source.toJson().values, 1]);

    vm.effect0Controller.init(2);
    vm.effectArg0Controller.numberController.controller.text = '-7';
    vm.effect1Controller.init(5);
    vm.effectArg1Controller.selectController.init(48);
    vm.effect2Controller.init(7);
    vm.effectArg2Controller.numberController.init(321);
    vm.flagsController.init(9);
    vm.nameController.init('名称草稿');
    await vm.persist();
    final edited = _source.copyWith(
      effect0: 2,
      effectArg0: -7,
      effect1: 5,
      effectArg1: 48,
      effect2: 7,
      effectArg2: 321,
      flags: 9,
      nameLangZhCN: '名称草稿',
    );
    expect(driver.updates.last, [...edited.toJson().values, 1]);

    vm.idController.init(2);
    vm.nameLangFlagsController.init(127);
    vm.effectArg1Controller.selectController.init(29);
    vm.applyNameLocales([
      for (final locale in DbcLocale.values)
        DbcLocaleFieldValue(locale: locale, value: 'edited ${locale.code}'),
    ]);
    expect(vm.nameController.collect(), 'edited zhCN');
    expect(vm.entity.value!.nameLangEnUS, 'edited enUS');
    await vm.persist();
    expect(driver.updates.last, [
      ...{
        ...edited.toJson(),
        'ID': 2,
        'Name_lang_Flags': 127,
        'EffectArg1': 29,
        for (final locale in DbcLocale.values)
          'Name_lang_${locale.code}': 'edited ${locale.code}',
      }.values,
      1,
    ]);
    expect(vm.persistedKey.value, 2);
    expect(events.last.log.module, 'spell_item_enchantment');
    expect(events.last.log.entityName, 'edited zhCN');
  });

  test('新建遇到主键冲突后同步实际主键，再次保存使用新主键', () async {
    driver.collide = true;
    final vm = await form();
    vm.nameController.init('新附魔');
    vm.effect0Controller.init(5);
    vm.effectArg0Controller.selectController.init(48);
    await vm.persist();
    expect(vm.persistedKey.value, 12);
    expect(vm.entity.value!.id, 12);
    expect(vm.idController.collect(), 12);
    expect(driver.inserts.single, vm.entity.value!.toJson().values.toList());

    await vm.persist();
    expect(driver.updates.single, [...vm.entity.value!.toJson().values, 12]);
    expect(vm.entity.value!.effectArg0, 48);
  });

  test('复制冲突返回实际写入主键，并保留多语言和效果数据', () async {
    driver.collide = true;
    final key = await repository.copySpellItemEnchantment(1);
    expect(key, 12);
    expect(driver.inserts.single, _source.copyWith(id: key).toJson().values);
  });

  test('创建和复制允许 int32 最大 ID，耗尽后停止分配', () async {
    driver.maxId = 0x7ffffffe;
    expect((await repository.createSpellItemEnchantment()).id, 0x7fffffff);
    expect(await repository.copySpellItemEnchantment(1), 0x7fffffff);
    expect(driver.inserts.single.first, 0x7fffffff);
    await expectLater(
      repository.createSpellItemEnchantment(),
      throwsA(isA<IdExhaustedException>()),
    );
    await expectLater(
      repository.copySpellItemEnchantment(1),
      throwsA(isA<IdExhaustedException>()),
    );
    expect(driver.insertAttempts, 1);
  });

  test('冲突重试在 int32 ID 耗尽时停止，不写入越界 ID', () async {
    driver.maxId = 0x7ffffffe;
    driver.collide = true;
    await expectLater(
      repository.copySpellItemEnchantment(1),
      throwsA(isA<IdExhaustedException>()),
    );
    expect(driver.insertAttempts, 1);
    expect(driver.inserts, isEmpty);
  });
}

final _source = SpellItemEnchantmentEntity.fromJson({
  ...const SpellItemEnchantmentEntity(
    id: 1,
    charges: 3,
    effect0: 1,
    effect1: 4,
    effect2: 5,
    effectPointsMin0: 11,
    effectPointsMin1: 12,
    effectPointsMin2: 13,
    effectPointsMax0: 21,
    effectPointsMax1: 22,
    effectPointsMax2: 23,
    effectArg0: 123,
    effectArg1: 6,
    effectArg2: 29,
    nameLangFlags: 37,
    itemVisual: 7,
    flags: 5,
    srcItemId: 1234,
    conditionId: 8,
    requiredSkillId: 333,
    requiredSkillRank: 150,
    minLevel: 20,
  ).toJson(),
  for (final locale in DbcLocale.values)
    'Name_lang_${locale.code}': 'original ${locale.code}',
});

class _Repository extends SpellItemEnchantmentRepository {
  @override
  final Laconic laconic;
  _Repository(this.laconic);
}

class _Driver implements DatabaseDriver {
  int maxId = 10;
  bool collide = false;
  int insertAttempts = 0;
  final inserts = <List<Object?>>[];
  final updates = <List<Object?>>[];

  @override
  final SqlGrammar grammar = MysqlGrammar();

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async => [
    LaconicResult.fromMap(
      sql.toLowerCase().contains('max(') ? {'max_id': maxId} : _source.toJson(),
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
