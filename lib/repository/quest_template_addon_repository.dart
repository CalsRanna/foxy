import 'package:foxy/entity/quest_template_addon.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// quest_template_addon 表的数据访问层
///
/// 1:1 子表，主键 ID 与 quest_template 共享。
/// 仅提供 getQuestTemplateAddon/createQuestTemplateAddon/storeQuestTemplateAddon/update 四个操作。
class QuestTemplateAddonRepository with RepositoryMixin {
  static const _table = 'quest_template_addon';

  /// 根据 ID 查找
  Future<QuestTemplateAddon?> getQuestTemplateAddon(int id) async {
    try {
      final result = await laconic.table(_table).where('ID', id).first();
      return QuestTemplateAddon.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 创建：返回与 quest_template ID 关联的空白对象（不落库）
  Future<QuestTemplateAddon> createQuestTemplateAddon(int id) async {
    final model = QuestTemplateAddon(id: id);
    return model;
  }

  /// 存储（insert）
  Future<void> storeQuestTemplateAddon(QuestTemplateAddon model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  /// 更新（根据 ID）
  Future<void> updateQuestTemplateAddon(
    int id,
    QuestTemplateAddon model,
  ) async {
    final json = model.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', id).update(json);
  }
}
