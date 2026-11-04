import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/repository/locale_query_settings.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  final settings = LocaleQuerySettings();

  setUp(() {
    GetIt.instance.registerSingleton(settings);
  });
  tearDown(() => GetIt.instance.reset());

  for (final enabled in [false, true]) {
    test('扩展费用物品名称遵循 locale_enabled=$enabled', () async {
      settings.update(localeEnabled: enabled);
      final queries = <LaconicQuery>[];
      final repository = _Repository(
        Laconic(
          _ReadDriver({
            'ID': 7,
            'ItemID0': 10,
            'ItemID1': 20,
            'itemName0': '主表物品一',
            'itemName1': '主表物品二',
            if (enabled) 'itemLocaleName0': '本地化物品一',
            if (enabled) 'itemLocaleName1': '本地化物品二',
          }),
          listen: queries.add,
        ),
      );

      final items = await repository.getBriefItemExtendedCosts();

      final query = queries.single;
      if (enabled) {
        expect(
          RegExp('item_template_locale').allMatches(query.sql),
          hasLength(2),
        );
        expect(query.sql, contains('itl.Name as itemLocaleName0'));
        expect(query.sql, contains('itl2.Name as itemLocaleName1'));
        expect(query.bindings.where((value) => value == 'zhCN'), hasLength(2));
      } else {
        expect(query.sql, isNot(contains('item_template_locale')));
        expect(query.sql, isNot(contains('itl.')));
        expect(query.sql, isNot(contains('itl2.')));
        expect(items.single.itemLocaleName0, isEmpty);
        expect(items.single.itemLocaleName1, isEmpty);
      }
      expect(items.single.id, 7);
      expect(items.single.displayItemName(0), enabled ? '本地化物品一' : '主表物品一');
      expect(items.single.displayItemName(1), enabled ? '本地化物品二' : '主表物品二');
    });
  }
}

class _Repository extends ItemExtendedCostRepository {
  @override
  final Laconic laconic;

  _Repository(this.laconic);
}

final class _ReadDriver implements DatabaseDriver {
  final Map<String, Object?> row;

  _ReadDriver(this.row);

  @override
  final SqlGrammar grammar = MysqlGrammar();

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async => [LaconicResult.fromMap(row)];

  @override
  Future<void> close() async {}

  @override
  Future<int> affectingStatement(
    String sql, [
    List<Object?> params = const [],
  ]) => throw UnimplementedError();

  @override
  Future<int> insertAndGetId(String sql, [List<Object?> params = const []]) =>
      throw UnimplementedError();

  @override
  Future<void> statement(String sql, [List<Object?> params = const []]) =>
      throw UnimplementedError();

  @override
  Future<T> transaction<T>(Future<T> Function() action) =>
      throw UnimplementedError();
}
