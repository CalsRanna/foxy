// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_template_repository.dart';

final class MailTemplateFilter {
  final String id;
  final String subject;

  const MailTemplateFilter({this.id = '', this.subject = ''});

  factory MailTemplateFilter.fromJson(Map<String, dynamic> json) {
    return MailTemplateFilter(
      id: json['id']?.toString() ?? '',
      subject: json['subject']?.toString() ?? '',
    );
  }

  MailTemplateFilter copyWith({String? id, String? subject}) {
    return MailTemplateFilter(
      id: id ?? this.id,
      subject: subject ?? this.subject,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'subject': subject};
  }
}

mixin _MailTemplateRepositoryMixin
    on RepositoryMixin, DbcLocaleRepositoryMixin {
  String get _table => 'foxy.dbc_mail_template';

  Future<void> destroyMailTemplate(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_mail_template record not found');
    }
  }

  Future<MailTemplateEntity?> getMailTemplate(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return MailTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getMailTemplateLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveMailTemplateLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeMailTemplate(MailTemplateEntity mailTemplate) async {
    if (mailTemplate.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(mailTemplate);
    final json = prepareWriteJson(mailTemplate.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = mailTemplate.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_mail_template',
          );
        }
        rethrow;
      }
    }
    return mailTemplate.id;
  }

  Future<void> updateMailTemplate(
    int originalKey,
    MailTemplateEntity mailTemplate,
  ) async {
    await _beforeUpdate(originalKey, mailTemplate);
    final json = prepareWriteJson(mailTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_mail_template');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_mail_template record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(MailTemplateEntity mailTemplate) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    MailTemplateEntity mailTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
