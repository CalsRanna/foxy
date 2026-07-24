import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'quest_template_repository.g.dart';

@FoxyRepository(QuestTemplateEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('title')
class QuestTemplateRepository
    with RepositoryMixin, _QuestTemplateRepositoryMixin {
  static const _table = 'quest_template';

  Future<int> copyQuestTemplate(int key) async {
    final source = await getQuestTemplate(key);
    if (source == null) {
      throw StateError('原任务模板不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeQuestTemplate(copied);
    return copied.id;
  }

  Future<int> countQuestTemplates({QuestTemplateFilter? filter}) async {
    final needsLocaleJoin =
        localeEnabled && filter != null && filter.title.isNotEmpty;
    if (!needsLocaleJoin) {
      var builder = laconic.table(_table);
      if (filter != null && filter.id.isNotEmpty) {
        var idValue = int.tryParse(filter.id) ?? 0;
        builder = builder.where('ID', idValue);
      }
      if (filter != null && filter.title.isNotEmpty) {
        builder = builder.where(
          'LogTitle',
          '%${filter.title}%',
          comparator: 'like',
        );
      }
      return builder.count();
    }
    var builder = laconic.table('$_table AS qt');
    builder = builder.leftJoin(
      'quest_template_locale AS qtl',
      (join) => join.on('qt.ID', 'qtl.ID').where('qtl.locale', 'zhCN'),
    );
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<QuestTemplateEntity> createQuestTemplate() async {
    return QuestTemplateEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefQuestTemplateEntity>> getBriefQuestTemplates({
    int page = 1,
    QuestTemplateFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS qt');
    final fields = <String>[
      'qt.ID',
      'qt.LogTitle',
      if (localeEnabled) 'qtl.Title AS localeTitle',
      'qt.QuestDescription',
      if (localeEnabled) 'qtl.Details AS localeDetails',
      'qt.QuestType',
      'qt.QuestLevel',
      'qt.MinLevel',
    ];
    builder = builder.select(fields);
    if (localeEnabled) {
      builder = builder.leftJoin(
        'quest_template_locale AS qtl',
        (join) => join.on('qt.ID', 'qtl.ID').where('qtl.locale', 'zhCN'),
      );
    }
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('qt.ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefQuestTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<QuestTemplateEntity>> getQuestTemplates() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => QuestTemplateEntity.fromJson(e.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, QuestTemplateFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      var idValue = int.tryParse(filter.id) ?? 0;
      builder = builder.where('qt.ID', idValue);
    }
    if (filter.title.isNotEmpty) {
      if (localeEnabled) {
        builder = builder.whereAny(
          ['qt.LogTitle', 'qtl.Title'],
          '%${filter.title}%',
          comparator: 'like',
        );
      } else {
        builder = builder.where(
          'qt.LogTitle',
          '%${filter.title}%',
          comparator: 'like',
        );
      }
    }
    return builder;
  }
}
