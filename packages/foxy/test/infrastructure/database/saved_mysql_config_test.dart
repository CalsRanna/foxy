import 'package:foxy/infrastructure/database/saved_mysql_config.dart';
import 'package:test/test.dart';

void main() {
  test('uses the existing MySQL defaults for missing values', () {
    final config = SavedMysqlConfig.fromMap({});

    expect(config.host, '127.0.0.1');
    expect(config.port, 3306);
    expect(config.database, 'acore_world');
    expect(config.username, 'acore');
    expect(config.password, 'acore');
    expect(config.useSsl, isFalse);
    expect(config.allowPublicKeyRetrieval, isTrue);
  });

  test('reads saved settings and disables key retrieval with TLS', () {
    final config = SavedMysqlConfig.fromMap({
      'host': 'db.example.test',
      'port': '63306',
      'database': 'world',
      'username': 'reader',
      'password': 'test-password',
      'use_ssl': true,
    });

    expect(config.host, 'db.example.test');
    expect(config.port, 63306);
    expect(config.database, 'world');
    expect(config.username, 'reader');
    expect(config.password, 'test-password');
    expect(config.useSsl, isTrue);
    expect(config.allowPublicKeyRetrieval, isFalse);
  });

  test('keeps integer ports and falls back for unparseable ones', () {
    expect(SavedMysqlConfig.fromMap({'port': 3307}).port, 3307);
    expect(SavedMysqlConfig.fromMap({'port': 'invalid'}).port, 3306);
    expect(SavedMysqlConfig.fromMap({'use_ssl': 'true'}).useSsl, isFalse);
  });
}
