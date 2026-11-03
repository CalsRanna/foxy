import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/model/dbc/dbc_locale.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/view_model/achievement_detail_view_model.dart';
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
    GetIt.instance.registerSingleton<AchievementRepository>(repository);
  });
  tearDown(() async {
    bus.destroy();
    await GetIt.instance.reset();
  });

  Future<AchievementDetailViewModel> form({int? key}) async {
    final vm = AchievementDetailViewModel();
    addTearDown(vm.dispose);
    await vm.initSignals(key: key);
    return vm;
  }

  test('保存保留三组语言及 Flags，文本可编辑且未选择阵营时使用 -1', () async {
    final vm = await form(key: 1);
    expect(
      [
        vm.titleLangFlags.value,
        vm.descriptionLangFlags.value,
        vm.rewardLangFlags.value,
      ],
      [17, 18, 19],
    );
    await vm.persist();
    expect(driver.updates.last, [..._source.toJson().values, 1]);

    vm.factionController.controller.value = null;
    vm.titleLangZhCNController.init('标题草稿');
    vm.descriptionLangZhCNController.init('描述草稿');
    vm.rewardLangZhCNController.init('奖励草稿');
    vm.rewardLangRuRUController.init('reward draft ruRU');
    vm.flagsController.init(0x101);
    await vm.persist();
    expect(driver.updates.last, [
      ..._source
          .copyWith(
            faction: -1,
            titleLangZhCN: '标题草稿',
            descriptionLangZhCN: '描述草稿',
            rewardLangZhCN: '奖励草稿',
            rewardLangRuRU: 'reward draft ruRU',
            flags: 0x101,
          )
          .toJson()
          .values,
      1,
    ]);
    expect(events.last.log.module, 'achievement');
    expect(events.last.log.entityName, '标题草稿');
  });

  test('三组语言依次回填互不覆盖，并保留数值和 Flags 信号草稿', () async {
    final vm = await form(key: 1);
    vm.idController.init(2);
    vm.factionController.init(0);
    vm.pointsController.init(50);
    vm.minimumCriteriaController.init(3);
    vm.titleLangFlags.value = 101;
    vm.descriptionLangFlags.value = 102;
    vm.rewardLangFlags.value = 103;
    vm.titleLangZhCNController.init('标题草稿');
    vm.descriptionLangZhCNController.init('描述草稿');
    vm.rewardLangZhCNController.init('奖励草稿');
    final expected = _source
        .copyWith(
          id: 2,
          faction: 0,
          points: 50,
          minimumCriteria: 3,
          titleLangFlags: 101,
          descriptionLangFlags: 102,
          rewardLangFlags: 103,
          titleLangZhCN: '标题草稿',
          descriptionLangZhCN: '描述草稿',
          rewardLangZhCN: '奖励草稿',
        )
        .toJson();

    for (final (prefix, apply) in [
      ('Title_lang', vm.applyTitleLocales),
      ('Description_lang', vm.applyDescriptionLocales),
      ('Reward_lang', vm.applyRewardLocales),
    ]) {
      final values = [
        for (final locale in DbcLocale.values)
          DbcLocaleFieldValue(
            locale: locale,
            value: 'edited $prefix ${locale.code}',
          ),
      ];
      apply(values);
      expected.addAll({
        for (final item in values) '${prefix}_${item.locale.code}': item.value,
      });
      expect(vm.entity.value!.toJson(), expected);
      final originalKey = vm.persistedKey.value;
      await vm.persist();
      expect(driver.updates.last, [...expected.values, originalKey]);
      expect(vm.persistedKey.value, 2);
    }
  });

  test('新建保留默认值，冲突后同步实际主键并以该主键再次保存', () async {
    driver.collide = true;
    final vm = await form();
    expect(vm.idController.collect(), 11);
    expect(vm.factionController.collect(), -1);
    expect(vm.instanceIdController.collect(), -1);
    vm.titleLangZhCNController.init('新成就');
    await vm.persist();
    expect(vm.persistedKey.value, 12);
    expect(vm.entity.value!.id, 12);
    expect(vm.idController.collect(), 12);
    expect(driver.inserts.single, vm.entity.value!.toJson().values);

    await vm.persist();
    expect(driver.updates.single, [...vm.entity.value!.toJson().values, 12]);
    expect(vm.entity.value!.titleLangZhCN, '新成就');
  });

  test('复制冲突返回实际 ID，并保留三组语言、Flags 和其他字段', () async {
    driver.collide = true;
    final key = await repository.copyAchievement(1);
    expect(key, 12);
    expect(driver.inserts.single, _source.copyWith(id: key).toJson().values);
  });

  test('创建和复制允许分配 ID 65535，耗尽后拒绝分配', () async {
    driver.maxId = 65534;
    expect((await repository.createAchievement()).id, 65535);
    expect(await repository.copyAchievement(1), 65535);
    expect(driver.inserts.single.first, 65535);
    await expectLater(
      repository.createAchievement(),
      throwsA(isA<IdExhaustedException>()),
    );
    await expectLater(
      repository.copyAchievement(1),
      throwsA(isA<IdExhaustedException>()),
    );
    expect(driver.insertAttempts, 1);
  });

  test('冲突重试在 ID 上限耗尽时停止，不写入 65536', () async {
    driver.maxId = 65534;
    driver.collide = true;
    await expectLater(
      repository.copyAchievement(1),
      throwsA(isA<IdExhaustedException>()),
    );
    expect(driver.insertAttempts, 1);
    expect(driver.inserts, isEmpty);
  });
}

final _source = AchievementEntity.fromJson({
  ...const AchievementEntity(
    id: 1,
    faction: 1,
    instanceId: 33,
    supercedes: 7,
    titleLangFlags: 17,
    descriptionLangFlags: 18,
    rewardLangFlags: 19,
    category: 8,
    points: 10,
    uiOrder: 4,
    flags: 5,
    iconId: 9,
    minimumCriteria: 2,
    sharesCriteria: 6,
  ).toJson(),
  for (final prefix in ['Title_lang', 'Description_lang', 'Reward_lang'])
    for (final locale in DbcLocale.values)
      '${prefix}_${locale.code}': 'original $prefix ${locale.code}',
});

class _Repository extends AchievementRepository {
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
