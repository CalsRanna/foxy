import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// quest_request_items_locale 表的数据访问层
/// 复合主键: (ID, Locale)
class QuestRequestItemsLocaleRepository with RepositoryMixin {
  static const _table = 'quest_request_items_locale';

  /// 按 ID 查询该 QuestRequestItems 的所有 locale
  Future<List<QuestRequestItemsLocaleEntity>> getQuestRequestItemsLocales(
    int id,
  ) async {
    try {
      final results = await laconic.table(_table).where('ID', id).get();
      return results
          .map((e) => QuestRequestItemsLocaleEntity.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 删除-然后-重新插入模式（replaceAll）
  Future<void> replaceAll(
    int id,
    List<QuestRequestItemsLocaleEntity> locales,
  ) async {
    await laconic.table(_table).where('ID', id).delete();
    if (locales.isNotEmpty) {
      await laconic
          .table(_table)
          .insert(locales.map((l) => l.toJson()).toList());
    }
  }
}
