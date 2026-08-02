import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_template_spell_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/repository/creature_template_spell_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/creature_template_spell_linked_list_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('CreatureTemplateSpellKey 和 Brief 完整覆盖两列主键', () {
    const entity = CreatureTemplateSpellEntity(creatureID: 10, index: 2);
    final key = CreatureTemplateSpellKey.fromEntity(entity);
    final same = CreatureTemplateSpellKey.fromEntity(
      entity.copyWith(spell: 123),
    );
    const brief = BriefCreatureTemplateSpellEntity(creatureID: 10, index: 2);

    expect(key, same);
    expect(key.hashCode, same.hashCode);
    expect(
      key,
      isNot(CreatureTemplateSpellKey.fromEntity(entity.copyWith(index: 3))),
    );
    expect(brief.key, key);
  });

  group('CreatureTemplateSpellRepository write contract', () {
    test('UPDATE 使用完整旧 key 定位并写入全部 candidate 字段', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestCreatureTemplateSpellRepository(
        Laconic(_RecordingDriver(), listen: queries.add),
      );
      const originalKey = CreatureTemplateSpellKey(creatureID: 10, index: 2);
      const candidate = CreatureTemplateSpellEntity(
        creatureID: 11,
        index: 3,
        spell: 123,
        verifiedBuild: 12340,
      );

      await repository.updateCreatureTemplateSpell(originalKey, candidate);

      expect(queries, hasLength(1));
      final sql = queries.single.sql;
      final setColumns = sql
          .substring(sql.indexOf(' set ') + 5, sql.indexOf(' where '))
          .split(', ')
          .map((assignment) => assignment.split(' = ').first)
          .toList();
      final bindings = queries.single.bindings;

      // 断言列→值映射而不是绑定下标，SET 子句的列顺序由 Entity 字段声明
      // 顺序决定，不属于写入契约。反引号是保留字列 `Index` 的转义要求。
      expect(Map.fromIterables(setColumns, bindings.take(setColumns.length)), {
        '`CreatureID`': candidate.creatureID,
        '`Index`': candidate.index,
        '`Spell`': candidate.spell,
        '`VerifiedBuild`': candidate.verifiedBuild,
      });
      expect(bindings.skip(setColumns.length).toList(), [
        originalKey.creatureID,
        originalKey.index,
      ]);
    });

    test('UPDATE 与 DELETE 零行结果报告旧记录不存在', () async {
      final repository = _TestCreatureTemplateSpellRepository(
        Laconic(_RecordingDriver(affectedRows: 0)),
      );
      const key = CreatureTemplateSpellKey(creatureID: 10, index: 2);

      await expectLater(
        repository.updateCreatureTemplateSpell(
          key,
          const CreatureTemplateSpellEntity(),
        ),
        throwsA(isA<RecordNotFoundException>()),
      );
      await expectLater(
        repository.destroyCreatureTemplateSpell(key),
        throwsA(isA<RecordNotFoundException>()),
      );
    });

    test('Brief 查询不加载完整行并稳定分页', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestCreatureTemplateSpellRepository(
        Laconic(_RecordingDriver(), listen: queries.add),
      );

      await repository.getBriefCreatureTemplateSpells(10, page: 2);

      expect(queries.single.sql, isNot(contains('cts.*')));
      expect(queries.single.sql.toLowerCase(), contains('order by'));
      expect(queries.single.bindings, [10, 50, 50]);
    });
  });

  group('CreatureTemplateSpell inline identity', () {
    late _FakeCreatureTemplateSpellRepository repository;

    setUp(() {
      repository = _FakeCreatureTemplateSpellRepository([
        const CreatureTemplateSpellEntity(creatureID: 10, index: 2, spell: 123),
      ]);
      GetIt.instance.registerSingleton<CreatureTemplateSpellRepository>(
        repository,
      );
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());
    });

    tearDown(() async {
      await GetIt.instance.reset();
    });

    test('修改两列 candidate key 仍按完整旧 key 更新并清空范围状态', () async {
      final viewModel = CreatureTemplateSpellLinkedListViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(linkKey: 10);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);
      const originalKey = CreatureTemplateSpellKey(creatureID: 10, index: 2);

      viewModel.creatureIDController.init(11);
      viewModel.indexController.init(3);
      await viewModel.persist();

      expect(repository.updateKeys, [originalKey]);
      expect(repository.rows.single.creatureID, 11);
      expect(repository.rows.single.index, 3);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
    });

    test('保存失败保留旧 editingKey 供修正后重试', () async {
      final viewModel = CreatureTemplateSpellLinkedListViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(linkKey: 10);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);
      final originalKey = viewModel.editingKey.value;
      repository.failUpdates = true;
      viewModel.indexController.init(3);

      await expectLater(viewModel.persist(), throwsA(isA<StateError>()));
      expect(viewModel.editingKey.value, originalKey);

      repository.failUpdates = false;
      await viewModel.persist();
      expect(repository.updateKeys, [originalKey, originalKey]);
    });

    test('父范围变化和新建会清空 editingKey', () async {
      final viewModel = CreatureTemplateSpellLinkedListViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(linkKey: 10);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);

      await viewModel.setLinkKey(12);
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.creatureIDController.collect(), 12);

      await viewModel.create();
      expect(viewModel.editingKey.value, isNull);
      viewModel.spellController.init(456);
      await viewModel.persist();
      expect(repository.storeCount, 1);
    });
  });
}

class _FakeCreatureTemplateSpellRepository
    extends CreatureTemplateSpellRepository {
  final List<CreatureTemplateSpellEntity> rows;
  bool failUpdates = false;
  int storeCount = 0;
  final updateKeys = <CreatureTemplateSpellKey>[];

  _FakeCreatureTemplateSpellRepository(this.rows);

  @override
  Future<int> countCreatureTemplateSpells(int creatureID) async {
    return rows.where((row) => row.creatureID == creatureID).length;
  }

  @override
  Future<CreatureTemplateSpellEntity> createCreatureTemplateSpell(
    int creatureID,
  ) async {
    final indexes = rows
        .where((row) => row.creatureID == creatureID)
        .map((row) => row.index);
    return CreatureTemplateSpellEntity(
      creatureID: creatureID,
      index: CreatureTemplateSpellRepository.nextAvailableIndex(indexes),
    );
  }

  @override
  Future<List<BriefCreatureTemplateSpellEntity>> getBriefCreatureTemplateSpells(
    int creatureID, {
    int page = 1,
  }) async {
    return rows
        .where((row) => row.creatureID == creatureID)
        .map(
          (row) => BriefCreatureTemplateSpellEntity(
            creatureID: row.creatureID,
            index: row.index,
            spell: row.spell,
            verifiedBuild: row.verifiedBuild,
          ),
        )
        .toList();
  }

  @override
  Future<CreatureTemplateSpellEntity?> getCreatureTemplateSpell(
    CreatureTemplateSpellKey key,
  ) async {
    for (final row in rows) {
      if (CreatureTemplateSpellKey.fromEntity(row) == key) return row;
    }
    return null;
  }

  @override
  Future<void> storeCreatureTemplateSpell(
    CreatureTemplateSpellEntity spell,
  ) async {
    storeCount++;
    rows.add(spell);
  }

  @override
  Future<void> updateCreatureTemplateSpell(
    CreatureTemplateSpellKey originalKey,
    CreatureTemplateSpellEntity spell,
  ) async {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    final index = rows.indexWhere(
      (row) => CreatureTemplateSpellKey.fromEntity(row) == originalKey,
    );
    if (index < 0) throw StateError('missing');
    rows[index] = spell;
  }
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

class _TestCreatureTemplateSpellRepository
    extends CreatureTemplateSpellRepository {
  @override
  final Laconic laconic;

  _TestCreatureTemplateSpellRepository(this.laconic);
}
