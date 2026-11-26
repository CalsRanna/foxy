import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:laconic/laconic.dart';

import 'recording_driver.dart';

void testRepositoryWrites<R, K, E>({
  required R Function(Laconic) createRepository,
  required K originalKey,
  required E candidate,
  required E missingCandidate,
  required Future<void> Function(R, K, E) update,
  required Future<void> Function(R, K) destroy,
  required List<Object?> expectedBindings,
  void Function(LaconicQuery)? verifyUpdate,
}) {
  testUpdateQuery(
    execute: (laconic) =>
        update(createRepository(laconic), originalKey, candidate),
    verify: (query) {
      expect(query.bindings, expectedBindings);
      verifyUpdate?.call(query);
    },
  );

  testMissingWrites(
    createRepository: createRepository,
    update: (repository) => update(repository, originalKey, missingCandidate),
    destroy: (repository) => destroy(repository, originalKey),
  );
}

void testUpdateQuery({
  required Future<void> Function(Laconic) execute,
  required void Function(LaconicQuery) verify,
}) {
  test(
    'UPDATE matches the complete old key and binds all candidate columns',
    () async {
      final queries = <LaconicQuery>[];
      await execute(Laconic(RecordingDriver(), listen: queries.add));

      expect(queries, hasLength(1));
      final query = queries.single;
      expect(query.sql.toLowerCase(), startsWith('update'));
      verify(query);
    },
  );
}

void testMissingWrites<R>({
  required R Function(Laconic) createRepository,
  required Future<void> Function(R) update,
  required Future<void> Function(R) destroy,
}) {
  test(
    'UPDATE and DELETE report a missing record when zero rows are affected',
    () async {
      final repository = createRepository(
        Laconic(RecordingDriver(affectedRows: 0)),
      );
      final notFound = throwsA(isA<RecordNotFoundException>());

      await expectLater(update(repository), notFound);
      await expectLater(destroy(repository), notFound);
    },
  );
}

void testBriefPagination({
  required Future<void> Function(Laconic) queryPageTwo,
  String? tableAlias,
  void Function(LaconicQuery)? verifyQuery,
}) {
  test('Brief queries explicitly select columns, sort deterministically, and paginate', () async {
    final queries = <LaconicQuery>[];
    await queryPageTwo(Laconic(RecordingDriver(), listen: queries.add));

    final query = queries.single;
    final wildcard = tableAlias == null ? '*' : '$tableAlias.*';
    final sql = query.sql.toLowerCase();
    expect(query.sql, isNot(contains(wildcard)));
    expect(sql, contains('order by'));
    expect(sql, contains('limit ? offset ?'));
    expect(query.bindings.sublist(query.bindings.length - 2), [50, 50]);
    verifyQuery?.call(query);
  });
}
