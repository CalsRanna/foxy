import 'package:foxy/entity/quest_template_addon_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'quest_template_addon_repository.g.dart';

@FoxyRepository(QuestTemplateAddonEntity)
class QuestTemplateAddonRepository
    with RepositoryMixin, _QuestTemplateAddonRepositoryMixin {
  static const _table = 'quest_template_addon';

  Future<int> copyQuestTemplateAddon(int key) async {
    final source = await getQuestTemplateAddon(key);
    if (source == null) {
      throw StateError('原任务模板附加数据不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeQuestTemplateAddon(copied);
    return copied.id;
  }

  Future<int> countQuestTemplateAddons() {
    return laconic.table(_table).count();
  }

  Future<QuestTemplateAddonEntity> createQuestTemplateAddon([int? id]) async {
    return QuestTemplateAddonEntity(
      id: id ?? await nextMaxPlusOne(_table, 'ID'),
    );
  }

  Future<List<BriefQuestTemplateAddonEntity>> getBriefQuestTemplateAddons({
    int page = 1,
  }) async {
    final results = await laconic
        .table(_table)
        .select([
          'ID',
          'MaxLevel',
          'PrevQuestID',
          'NextQuestID',
          'SpecialFlags',
        ])
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefQuestTemplateAddonEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<QuestTemplateAddonEntity>> getQuestTemplateAddons() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => QuestTemplateAddonEntity.fromJson(row.toMap()))
        .toList();
  }
}
