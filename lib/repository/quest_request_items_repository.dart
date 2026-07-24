import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'quest_request_items_repository.g.dart';

@FoxyRepository(QuestRequestItemsEntity)
class QuestRequestItemsRepository
    with RepositoryMixin, _QuestRequestItemsRepositoryMixin {
  static const _table = 'quest_request_items';

  Future<int> copyQuestRequestItems(int key) async {
    final source = await getQuestRequestItems(key);
    if (source == null) {
      throw StateError('原任务提交物品数据不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeQuestRequestItems(copied);
    return copied.id;
  }

  Future<int> countQuestRequestItems() {
    return laconic.table(_table).count();
  }

  Future<QuestRequestItemsEntity> createQuestRequestItems([int? id]) async {
    return QuestRequestItemsEntity(
      id: id ?? await nextMaxPlusOne(_table, 'ID'),
    );
  }

  Future<List<BriefQuestRequestItemsEntity>> getBriefQuestRequestItems({
    int page = 1,
  }) async {
    final results = await laconic
        .table(_table)
        .select([
          'ID',
          'EmoteOnComplete',
          'EmoteOnIncomplete',
          'CompletionText',
        ])
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefQuestRequestItemsEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<QuestRequestItemsEntity>> getQuestRequestItemsList() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => QuestRequestItemsEntity.fromJson(row.toMap()))
        .toList();
  }
}
