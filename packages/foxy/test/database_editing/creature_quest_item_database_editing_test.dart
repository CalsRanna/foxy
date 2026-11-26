import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_quest_item_entity.dart';
import 'package:foxy/repository/creature_quest_item_repository.dart';
import 'package:laconic/laconic.dart';

import 'repository_contract.dart';
import 'row_key_expectations.dart';

void main() {
  test(
    'CreatureQuestItemKey and its brief entity include both primary key fields',
    () {
      const entity = CreatureQuestItemEntity(creatureEntry: 10, idx: 2);
      final key = CreatureQuestItemKey.fromEntity(entity);
      const brief = BriefCreatureQuestItemEntity(creatureEntry: 10, idx: 2);

      expectRowKeyEquality(
        key,
        CreatureQuestItemKey.fromEntity,
        sameKeyRow: entity.copyWith(itemId: 123),
        differentKeyRows: [entity.copyWith(idx: 3)],
      );
      expect(brief.key, key);
    },
  );

  group('CreatureQuestItemRepository write contract', () {
    const oldKey = CreatureQuestItemKey(creatureEntry: 10, idx: 2);
    const candidate = CreatureQuestItemEntity(
      creatureEntry: 11,
      idx: 3,
      itemId: 123,
      verifiedBuild: 12340,
    );

    testRepositoryWrites(
      createRepository: _TestRepository.new,
      originalKey: oldKey,
      candidate: candidate,
      missingCandidate: const CreatureQuestItemEntity(),
      update: (repository, key, row) =>
          repository.updateCreatureQuestItem(key, row),
      destroy: (repository, key) => repository.destroyCreatureQuestItem(key),
      expectedBindings: [
        ...candidate.toJson().values,
        oldKey.creatureEntry,
        oldKey.idx,
      ],
    );

    testBriefPagination(
      queryPageTwo: (laconic) =>
          _TestRepository(laconic).getBriefCreatureQuestItems(10, page: 2),
      tableAlias: 'cq',
    );
  });
}

class _TestRepository extends CreatureQuestItemRepository {
  @override
  final Laconic laconic;
  _TestRepository(this.laconic);
}
