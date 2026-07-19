import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_mail_template_entity.dart';
import 'package:foxy/entity/mail_template_key.dart';

void main() {
  test('MailTemplateKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = MailTemplateKey(id: 7);
    expect(key, const MailTemplateKey(id: 7));
    expect(key.hashCode, const MailTemplateKey(id: 7).hashCode);
    expect(const BriefMailTemplateEntity(id: 7).key, key);
  });

  test('MailTemplate Repository 使用显式键并保留本表 locale API', () {
    final source = File(
      'lib/repository/mail_template_repository.dart',
    ).readAsStringSync();
    expect(source, contains('MailTemplateKey key'));
    expect(source, contains('Future<void> storeMailTemplate('));
    expect(source, contains('MailTemplateKey originalKey'));
    expect(source, contains('.update(template.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveMailTemplateLocales('));
    expect(source, isNot(contains('saveMailTemplate(MailTemplateEntity')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefMailTemplate 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_mail_template_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
