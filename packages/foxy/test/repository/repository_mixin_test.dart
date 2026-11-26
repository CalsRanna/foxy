import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/repository/repository_mixin.dart';

void main() {
  final probe = _Probe();

  group('prepareWriteJson identifier allowlist', () {
    test('Valid column names are accepted and backtick-quoted', () {
      expect(probe.prepareWriteJson({'entry': 1}), {'`entry`': 1});
    });

    test('Identifiers containing whitespace are rejected', () {
      expect(() => probe.prepareWriteJson({'foo bar': 1}), throwsArgumentError);
    });

    test('Identifiers containing embedded backticks are rejected', () {
      expect(() => probe.prepareWriteJson({'a``b': 1}), throwsArgumentError);
    });

    test('Identifiers containing semicolons are rejected', () {
      expect(() => probe.prepareWriteJson({'a;drop': 1}), throwsArgumentError);
    });

    test('Identifiers containing hyphens are rejected', () {
      expect(() => probe.prepareWriteJson({'a-b': 1}), throwsArgumentError);
    });
  });

  group('nextMaxPlusOne identifier allowlist', () {
    test('Valid dotted table names pass validation and reach the database', () {
      expect(
        () => probe.nextMaxPlusOne('foxy.dbc_item', 'ID'),
        throwsA(isA<DatabaseNotConnectedException>()),
      );
    });

    test('Fully backtick-quoted WHERE keys pass validation', () {
      expect(
        () => probe.nextMaxPlusOne('t', 'ID', where: {'`CreatureID`': 1}),
        throwsA(isA<DatabaseNotConnectedException>()),
      );
    });

    test('Invalid table names are rejected', () {
      expect(() => probe.nextMaxPlusOne('a;b', 'ID'), throwsArgumentError);
    });

    test('Invalid WHERE keys are rejected', () {
      expect(
        () => probe.nextMaxPlusOne('t', 'ID', where: {'a``b': 1}),
        throwsArgumentError,
      );
    });
  });

  group('maxIdExpression', () {
    test('Regular column names are backtick-quoted', () {
      expect(probe.maxIdExpression('spell_id'), 'max(`spell_id`) as max_id');
    });

    test('Already quoted columns are not quoted again', () {
      expect(probe.maxIdExpression('`spell_id`'), 'max(`spell_id`) as max_id');
    });

    test('Reserved column names are protected by quoting', () {
      expect(probe.maxIdExpression('rank'), 'max(`rank`) as max_id');
    });

    test('Invalid column names are rejected', () {
      expect(() => probe.maxIdExpression('a;b'), throwsArgumentError);
    });
  });
}

class _Probe with RepositoryMixin {}
