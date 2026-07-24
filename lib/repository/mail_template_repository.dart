import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/mail_template_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'mail_template_repository.g.dart';

@FoxyRepository(MailTemplateEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('subject')
class MailTemplateRepository
    with
        RepositoryMixin,
        DbcLocaleRepositoryMixin,
        _MailTemplateRepositoryMixin {
  static const _table = 'foxy.dbc_mail_template';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyMailTemplate(int key) async {
    final source = await getMailTemplate(key);
    if (source == null) {
      throw StateError('原邮件模板不存在，可能已被其他操作修改或删除');
    }
    final copied = MailTemplateEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeMailTemplate(copied);
    return copied.id;
  }

  Future<int> countMailTemplates({MailTemplateFilter? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<MailTemplateEntity> createMailTemplate() async {
    return MailTemplateEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefMailTemplateEntity>> getBriefMailTemplates({
    int page = 1,
    MailTemplateFilter? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'Subject_lang_zhCN',
      'Body_lang_zhCN',
    ]);
    builder = _applyFilter(builder, filter);
    final rows = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefMailTemplateEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<DbcLocaleFieldValue>> getMailTemplateLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<MailTemplateEntity>> getMailTemplates() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => MailTemplateEntity.fromJson(row.toMap())).toList();
  }

  Future<void> saveMailTemplateLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeMailTemplate(MailTemplateEntity template) async {
    if (template.id <= 0) {
      throw StateError('邮件模板 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([template.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('邮件模板 ${template.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, MailTemplateFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.subject.isNotEmpty) {
      builder = builder.where(
        'Subject_lang_zhCN',
        '%${filter.subject}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
