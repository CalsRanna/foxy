import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/database/database.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

/// Connection settings for the real-MySQL integration suite (tag
/// `integration`, see `dart_test.yaml`).
///
/// The suite only ever talks to a throwaway MySQL instance. The default port
/// is 3307 on purpose: 3306 is where a developer's real AzerothCore/`foxy`
/// database usually listens, and these tests create — plus, with
/// [allowDropFoxyDatabase], drop — the `foxy` schema name that
/// `MigrationRunner` hardcodes (`create database if not exists foxy`).
///
/// Local run:
/// ```
/// docker run -d --rm -p 3307:3306 -e MYSQL_ROOT_PASSWORD=foxy mysql:8.0
/// flutter test --tags integration --run-skipped
/// ```
///
/// Overrides: `FOXY_TEST_MYSQL_HOST`, `_PORT`, `_USER`, `_PASSWORD`,
/// `_DATABASE`. The database defaults to `mysql` (always present) so the suite
/// can bootstrap the `foxy` schema itself instead of requiring it to exist.
MysqlConfig integrationMysqlConfig() {
  final env = Platform.environment;
  return MysqlConfig(
    host: env['FOXY_TEST_MYSQL_HOST'] ?? '127.0.0.1',
    port: int.parse(env['FOXY_TEST_MYSQL_PORT'] ?? '3307'),
    database: env['FOXY_TEST_MYSQL_DATABASE'] ?? 'mysql',
    username: env['FOXY_TEST_MYSQL_USER'] ?? 'root',
    password: env['FOXY_TEST_MYSQL_PASSWORD'] ?? 'foxy',
    // Same TLS stance as BootstrapApplicationUseCase: with TLS off, MySQL 8's
    // caching_sha2_password needs the server RSA public key.
    useSsl: false,
    allowPublicKeyRetrieval: true,
  );
}

/// Whether the destructive `drop database foxy` test may run.
///
/// Opt-in only: pointing the suite at a machine that already owns a `foxy`
/// schema must never wipe it.
bool get allowDropFoxyDatabase =>
    Platform.environment['FOXY_TEST_MYSQL_ALLOW_DROP'] == '1';

/// Connects the app's real singleton and probes the server.
///
/// Fails loudly instead of skipping when the instance is unreachable: a
/// silently skipped database suite would leave the CI gate empty.
Future<void> connectIntegrationDatabase() async {
  final config = integrationMysqlConfig();
  try {
    await Database.instance.connect(config);
    await Database.instance.laconic.statement('select version()');
  } catch (error) {
    await Database.instance.close();
    fail(
      'integration MySQL unreachable at ${config.host}:${config.port} '
      '(user: ${config.username}, database: ${config.database}) — $error\n'
      'Start a throwaway instance first, e.g.:\n'
      '  docker run -d --rm -p 3307:3306 -e MYSQL_ROOT_PASSWORD=foxy '
      'mysql:8.0',
    );
  }
}
