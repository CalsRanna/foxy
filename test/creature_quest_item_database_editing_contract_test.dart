import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_quest_item_entity.dart';
import 'package:foxy/repository/creature_quest_item_repository.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  test('CreatureQuestItemKey 和 Brief 完整覆盖两列主键', () {
    const entity = CreatureQuestItemEntity(creatureEntry: 10, idx: 2);
    final key = CreatureQuestItemKey.fromEntity(entity);
    final same = CreatureQuestItemKey.fromEntity(entity.copyWith(itemId: 123));
    const brief = BriefCreatureQuestItemEntity(creatureEntry: 10, idx: 2);

    expect(key, same);
    expect(key.hashCode, same.hashCode);
    expect(
      key,
      isNot(CreatureQuestItemKey.fromEntity(entity.copyWith(idx: 3))),
    );
    expect(brief.key, key);
  });

  test('UPDATE 使用完整旧 key 定位并写入 candidate 四列', () async {
    final queries = <LaconicQuery>[];
    final repository = _TestRepository(
      Laconic(_RecordingDriver(), listen: queries.add),
    );
    const oldKey = CreatureQuestItemKey(creatureEntry: 10, idx: 2);
    const candidate = CreatureQuestItemEntity(
      creatureEntry: 11,
      idx: 3,
      itemId: 123,
      verifiedBuild: 12340,
    );

    await repository.updateCreatureQuestItem(oldKey, candidate);

    expect(queries.single.bindings, [
      ...candidate.toJson().values,
      oldKey.creatureEntry,
      oldKey.idx,
    ]);
  });

  test('UPDATE、DELETE 零行报错且 Brief 查询稳定分页', () async {
    final missingRepository = _TestRepository(
      Laconic(_RecordingDriver(affectedRows: 0)),
    );
    const key = CreatureQuestItemKey(creatureEntry: 10, idx: 2);
    await expectLater(
      missingRepository.updateCreatureQuestItem(
        key,
        const CreatureQuestItemEntity(),
      ),
      throwsA(isA<StateError>()),
    );
    await expectLater(
      missingRepository.destroyCreatureQuestItem(key),
      throwsA(isA<StateError>()),
    );

    final queries = <LaconicQuery>[];
    final repository = _TestRepository(
      Laconic(_RecordingDriver(), listen: queries.add),
    );
    await repository.getBriefCreatureQuestItems(10, page: 2);
    expect(queries.single.sql, isNot(contains('cq.*')));
    expect(queries.single.sql.toLowerCase(), contains('order by'));
    expect(
      queries.single.bindings.sublist(queries.single.bindings.length - 2),
      [50, 50],
    );
  });

  test('UI、Full Entity 和 ViewModel 遵守迁移边界', () {
    final entity = File(
      'lib/entity/creature_quest_item_entity.dart',
    ).readAsStringSync();
    final repository = File(
      'lib/repository/creature_quest_item_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/creature_template/creature_quest_item_collection_editor_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/creature_template/creature_quest_item_view.dart',
    ).readAsStringSync();

    expect(entity, isNot(contains('final String itemName;')));
    expect(entity, isNot(contains('this.itemName')));
    expect(repository, isNot(contains('saveCreatureQuestItem')));
    expect(
      viewModel,
      contains('final editingKey = signal<CreatureQuestItemKey?>(null)'),
    );
    expect(viewModel, contains('Future<void> destroy('));
    expect(view, isNot(contains('readOnly: true')));
    expect(view, contains('FoxyPagination('));
  });
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

class _TestRepository extends CreatureQuestItemRepository {
  @override
  final Laconic laconic;
  _TestRepository(this.laconic);
}
