import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/mail_template_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefMailTemplateEntity(id: 7).key, key);
  });

  test('MailTemplate Repository 使用显式键并保留本表 locale API', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/mail_template_repository.dart',
    );
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeMailTemplate('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(json)'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveMailTemplateLocales('));
    expect(source, isNot(contains('saveMailTemplate(MailTemplateEntity')));
    expect(source, isNot(contains("remove('ID')")));
  });
}
