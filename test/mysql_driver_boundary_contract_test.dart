import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('MySQL 客户端由 laconic_mysql 私有维护', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final lockfile = File('pubspec.lock').readAsStringSync();
    final errorUtil = File(
      'lib/infrastructure/database/mysql_error_util.dart',
    ).readAsStringSync();

    expect(pubspec, contains('laconic_mysql: ^2.1.0'));
    expect(pubspec, isNot(contains('mysql_client:')));
    expect(pubspec, isNot(contains('dependency_overrides:')));
    expect(lockfile, contains('version: "2.1.0"'));
    expect(lockfile, contains('source: hosted'));
    expect(lockfile, isNot(contains('third_party/mysql_client')));
    expect(Directory('third_party/mysql_client').existsSync(), isFalse);
    expect(errorUtil, contains("package:laconic_mysql/laconic_mysql.dart"));
    expect(errorUtil, isNot(contains('package:mysql_client/')));
  });
}
