import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards against regressing the vendored mysql_client safety patches.
void main() {
  final poolFile = File('packages/mysql_client/lib/src/mysql_client/pool.dart');

  test('withConnection releases connections in finally', () {
    expect(poolFile.existsSync(), isTrue);
    final source = poolFile.readAsStringSync();
    expect(source.contains('finally'), isTrue);
    expect(source.contains('_releaseConnection(conn)'), isTrue);
    // Must not use the leaky pre-patch pattern of release only after await.
    final leaky = RegExp(
      r'final result = await callback\(conn\);\s*_releaseConnection\(conn\);',
    );
    expect(leaky.hasMatch(source), isFalse);
  });

  test('spell_rank repository escapes reserved word rank', () {
    final repo = File('lib/repository/spell_rank_repository.dart');
    final source = repo.readAsStringSync();
    expect(source.contains(".where('`rank`'"), isTrue);
    expect(source.contains("orderBy('sr.`rank`')"), isTrue);
    // Unescaped where('rank' must not remain.
    expect(RegExp(r"\.where\('rank'").hasMatch(source), isFalse);
  });
}
