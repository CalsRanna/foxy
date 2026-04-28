import 'package:foxy/model/quest_request_items.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// quest_request_items 表的数据访问层
///
/// 1:1 子表，主键 ID 与 quest_template 共享。
/// 仅提供 find/create/store/update 四个操作。
class QuestRequestItemsRepository with RepositoryMixin {
  static const _table = 'quest_request_items';

  /// 根据 ID 查找
  Future<QuestRequestItems?> getQuestRequestItems(int id) async {
    try {
      final result = await laconic.table(_table).where('ID', id).first();
      return QuestRequestItems.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 创建：返回与 quest_template ID 关联的空白对象（不落库）
  Future<QuestRequestItems> createQuestRequestItems(int id) async {
    final model = QuestRequestItems();
    model.id = id;
    return model;
  }

  /// 存储（insert）
  Future<void> storeQuestRequestItems(QuestRequestItems model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  /// 更新（根据 ID）
  Future<void> updateQuestRequestItems(int id, QuestRequestItems model) async {
    final json = model.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', id).update(json);
  }
}
