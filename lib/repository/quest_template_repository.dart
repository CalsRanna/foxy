import 'package:foxy/model/quest_template.dart';
import 'package:foxy/model/quest_template_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// quest_template 表的数据访问层
///
/// 主键: ID (int unsigned, 单列)
/// 列表查询通过 LEFT JOIN quest_template_locale 得到本地化标题。
class QuestTemplateRepository with RepositoryMixin {
  static const _table = 'quest_template';

  /// 搜索列表（带筛选和分页）
  Future<List<BriefQuestTemplate>> search({
    QuestTemplateFilterEntity? filter,
    int page = 1,
  }) async {
    return paginate(filter: filter, page: page);
  }

  /// 分页查询
  Future<List<BriefQuestTemplate>> paginate({
    QuestTemplateFilterEntity? filter,
    required int page,
  }) async {
    try {
      final offset = (page - 1) * kPageSize;
      var builder = laconic.table('${_table} AS qt');
      const fields = [
        'qt.ID',
        'qt.LogTitle',
        'qtl.Title',
        'qt.QuestDescription',
        'qtl.Details',
        'qt.QuestType',
        'qt.QuestLevel',
        'qt.MinLevel',
      ];
      builder = builder.select(fields);
      builder = builder.leftJoin(
        'quest_template_locale AS qtl',
        (join) => join.on('qt.ID', 'qtl.ID').on('qtl.locale', '"zhCN"'),
      );
      builder = _applyFilter(builder, filter);
      builder = builder.limit(kPageSize).offset(offset);
      final results = await builder.get();
      return results
          .map((e) => BriefQuestTemplate.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 计数
  Future<int> count({QuestTemplateFilterEntity? filter}) async {
    try {
      var builder = laconic.table('${_table} AS qt');
      builder = builder.leftJoin(
        'quest_template_locale AS qtl',
        (join) => join.on('qt.ID', 'qtl.ID').on('qtl.locale', '"zhCN"'),
      );
      builder = _applyFilter(builder, filter);
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  /// 根据主键查找
  Future<QuestTemplate?> find(int id) async {
    try {
      final builder = laconic.table(_table).where('ID', id);
      final result = await builder.first();
      return QuestTemplate.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 创建：返回下一个可用 ID 的空白对象（不落库）
  Future<QuestTemplate> create() async {
    try {
      final result = await laconic
          .table(_table)
          .select(['MAX(ID) as max_id'])
          .first();
      final maxId = result.toMap()['max_id'] as int?;
      final model = QuestTemplate();
      model.id = (maxId ?? 0) + 1;
      return model;
    } catch (e) {
      final model = QuestTemplate();
      model.id = 1;
      return model;
    }
  }

  /// 更新（根据 ID）
  Future<void> update(int id, QuestTemplate model) async {
    final json = model.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', id).update(json);
  }

  /// 存储（insert）
  Future<void> store(QuestTemplate model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  /// 删除（根据主键）
  Future<void> destroy(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  /// 复制：取新 ID = MAX+1
  Future<void> copy(int id) async {
    final original = await find(id);
    if (original == null) return;
    final next = await create();
    original.id = next.id;
    await store(original);
  }

  /// 应用筛选条件到 query builder
  dynamic _applyFilter(dynamic builder, QuestTemplateFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      final idValue = int.tryParse(filter.id) ?? 0;
      builder = builder.where('qt.ID', idValue);
    }
    if (filter.title.isNotEmpty) {
      builder = builder.whereAny(
        ['qt.LogTitle', 'qtl.Title'],
        '%${filter.title}%',
        operator: 'like',
      );
    }
    return builder;
  }
}