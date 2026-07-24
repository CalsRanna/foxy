// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_template_repository.dart';

mixin _MailTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyMailTemplate(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_mail_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<MailTemplateEntity?> getMailTemplate(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_mail_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return MailTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeMailTemplate(MailTemplateEntity mailTemplate) async {
    if (mailTemplate.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(mailTemplate);
    final json = _prepareWriteJson(mailTemplate.toJson());
    try {
      await laconic.table('foxy.dbc_mail_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateMailTemplate(
    int originalKey,
    MailTemplateEntity mailTemplate,
  ) async {
    await _beforeUpdate(originalKey, mailTemplate);
    final json = _prepareWriteJson(mailTemplate.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_mail_template'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(MailTemplateEntity mailTemplate) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    MailTemplateEntity mailTemplate,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
