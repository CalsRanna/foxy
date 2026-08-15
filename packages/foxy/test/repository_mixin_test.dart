import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/repository/repository_mixin.dart';

class _Probe with RepositoryMixin {}

void main() {
  final probe = _Probe();

  group('prepareWriteJson 标识符白名单', () {
    test('普通列名通过并加反引号', () {
      expect(probe.prepareWriteJson({'entry': 1}), {'`entry`': 1});
    });

    test('含空白拒绝', () {
      expect(
        () => probe.prepareWriteJson({'foo bar': 1}),
        throwsArgumentError,
      );
    });

    test('段中混入反引号拒绝', () {
      expect(() => probe.prepareWriteJson({'a``b': 1}), throwsArgumentError);
    });

    test('含分号拒绝', () {
      expect(() => probe.prepareWriteJson({'a;drop': 1}), throwsArgumentError);
    });

    test('含连字符拒绝', () {
      expect(() => probe.prepareWriteJson({'a-b': 1}), throwsArgumentError);
    });
  });

  group('nextMaxPlusOne 标识符白名单', () {
    test('合法点分表名通过校验后到达数据库层', () {
      expect(
        () => probe.nextMaxPlusOne('foxy.dbc_item', 'ID'),
        throwsA(isA<DatabaseNotConnectedException>()),
      );
    });

    test('反引号整段包裹的 where 键通过校验', () {
      expect(
        () => probe.nextMaxPlusOne(
          't',
          'ID',
          where: {'`CreatureID`': 1},
        ),
        throwsA(isA<DatabaseNotConnectedException>()),
      );
    });

    test('非法表名被拒绝', () {
      expect(
        () => probe.nextMaxPlusOne('a;b', 'ID'),
        throwsArgumentError,
      );
    });

    test('非法 where 键被拒绝', () {
      expect(
        () => probe.nextMaxPlusOne('t', 'ID', where: {'a``b': 1}),
        throwsArgumentError,
      );
    });
  });
}
