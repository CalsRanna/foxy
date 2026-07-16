import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/mail_template_entity.dart';
import 'package:foxy/entity/mail_template_filter_entity.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class MailTemplateRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_mail_template';

  @override
  String get dbcLocaleTableName => _table;

  Future<void> copyMailTemplate(int id) async {
    final source = await getMailTemplate(id);
    if (source == null) return;
    final json = source.toJson();
    json['ID'] = await nextMaxPlusOne(_table, 'ID');
    await laconic.table(_table).insert([json]);
  }

  Future<int> countMailTemplates({MailTemplateFilterEntity? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<MailTemplateEntity> createMailTemplate() async {
    return MailTemplateEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyMailTemplate(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefMailTemplateEntity>> getBriefMailTemplates({
    int page = 1,
    MailTemplateFilterEntity? filter,
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

  Future<MailTemplateEntity?> getMailTemplate(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty
        ? null
        : MailTemplateEntity.fromJson(rows.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getMailTemplateLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<MailTemplateEntity>> getMailTemplates() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => MailTemplateEntity.fromJson(row.toMap())).toList();
  }

  Future<void> saveMailTemplate(MailTemplateEntity template) async {
    if (await getMailTemplate(template.id) == null) {
      await storeMailTemplate(template);
    } else {
      await updateMailTemplate(template);
    }
  }

  Future<void> saveMailTemplateLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeMailTemplate(MailTemplateEntity template) async {
    final json = template.toJson();
    final id = template.id > 0
        ? template.id
        : await nextMaxPlusOne(_table, 'ID');
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateMailTemplate(MailTemplateEntity template) async {
    final json = template.toJson()..remove('ID');
    await laconic.table(_table).where('ID', template.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    MailTemplateFilterEntity? filter,
  ) {
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
