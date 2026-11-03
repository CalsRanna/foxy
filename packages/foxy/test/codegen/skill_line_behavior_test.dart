import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/model/dbc/dbc_locale.dart';
import 'package:foxy/entity/skill_line_entity.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/repository/skill_line_repository.dart';
import 'package:foxy/view_model/skill_line_detail_view_model.dart';
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
    GetIt.instance.registerSingleton<SkillLineRepository>(repository);
  });
  tearDown(() async {
    bus.destroy();
    await GetIt.instance.reset();
  });

  Future<SkillLineDetailViewModel> form({int? key}) async {
    final vm = SkillLineDetailViewModel();
    addTearDown(vm.dispose);
    await vm.initSignals(key: key);
    return vm;
  }

  test('普通保存保留三组全部语言、Flags 和基础字段，中文输入可独立修改', () async {
    final vm = await form(key: 1);
    await vm.persist();
    expect(driver.updates.last, [..._source.toJson().values, 1]);

    vm.displayNameLangZhCNController.init('名称草稿');
    vm.descriptionLangZhCNController.init('描述草稿');
    vm.alternateVerbLangZhCNController.init('动词草稿');
    await vm.persist();
    expect(driver.updates.last, [
      ..._source
          .copyWith(
            displayNameLangZhCN: '名称草稿',
            descriptionLangZhCN: '描述草稿',
            alternateVerbLangZhCN: '动词草稿',
          )
          .toJson()
          .values,
      1,
    ]);
    expect(events.last.log.module, 'skill_line');
    expect(events.last.log.entityName, '名称草稿');
  });

  test('依次回填三组语言互不覆盖，保存保留其他中文和数值草稿', () async {
    final vm = await form(key: 1);
    vm.idController.init(2);
    vm.categoryIdController.init(9);
    vm.skillCostsIdController.init(10);
    vm.spellIconIdController.init(11);
    vm.canLinkController.init(0);
    vm.displayNameLangFlagsController.init(101);
    vm.descriptionLangFlagsController.init(102);
    vm.alternateVerbLangFlagsController.init(103);
    vm.displayNameLangZhCNController.init('名称草稿');
    vm.descriptionLangZhCNController.init('描述草稿');
    vm.alternateVerbLangZhCNController.init('动词草稿');
    final expected = _source
        .copyWith(
          id: 2,
          categoryId: 9,
          skillCostsId: 10,
          spellIconId: 11,
          canLink: 0,
          displayNameLangFlags: 101,
          descriptionLangFlags: 102,
          alternateVerbLangFlags: 103,
          displayNameLangZhCN: '名称草稿',
          descriptionLangZhCN: '描述草稿',
          alternateVerbLangZhCN: '动词草稿',
        )
        .toJson();

    for (final (prefix, apply) in [
      ('DisplayName_lang', vm.applyDisplayNameLocales),
      ('Description_lang', vm.applyDescriptionLocales),
      ('AlternateVerb_lang', vm.applyAlternateVerbLocales),
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
      expect(
        vm.entity.value!.toJson()['${prefix}_enUS'],
        'edited $prefix enUS',
      );
      final originalKey = vm.persistedKey.value;
      await vm.persist();
      expect(driver.updates.last, [...expected.values, originalKey]);
      expect(vm.entity.value!.toJson(), expected);
      expect(vm.persistedKey.value, 2);
    }
  });

  test('新建预填 MAX+1，冲突后同步实际主键并以该主键再次保存', () async {
    driver.collide = true;
    final vm = await form();
    expect(vm.idController.collect(), 11);
    expect(vm.persistedKey.value, isNull);
    vm.displayNameLangZhCNController.init('新技能');
    await vm.persist();
    expect(vm.persistedKey.value, 12);
    expect(vm.entity.value!.id, 12);
    expect(vm.idController.collect(), 12);
    expect(driver.inserts.single, vm.entity.value!.toJson().values);

    await vm.persist();
    expect(driver.updates.single, [...vm.entity.value!.toJson().values, 12]);
    expect(vm.entity.value!.displayNameLangZhCN, '新技能');
  });

  test('复制冲突返回实际 ID，并保留三组语言、Flags 和基础字段', () async {
    driver.collide = true;
    final key = await repository.copySkillLine(1);
    expect(key, 12);
    expect(driver.inserts.single, _source.copyWith(id: key).toJson().values);
  });
}

final _source = SkillLineEntity.fromJson({
  ...const SkillLineEntity(
    id: 1,
    categoryId: 3,
    skillCostsId: 4,
    spellIconId: 5,
    canLink: 1,
    displayNameLangFlags: 17,
    descriptionLangFlags: 18,
    alternateVerbLangFlags: 19,
  ).toJson(),
  for (final prefix in [
    'DisplayName_lang',
    'Description_lang',
    'AlternateVerb_lang',
  ])
    for (final locale in DbcLocale.values)
      '${prefix}_${locale.code}': 'original $prefix ${locale.code}',
});

class _Repository extends SkillLineRepository {
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
