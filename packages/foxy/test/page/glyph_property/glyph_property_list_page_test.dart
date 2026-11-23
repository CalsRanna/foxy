import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/page/glyph_property/glyph_property_list_page.dart';
import 'package:foxy/repository/glyph_property_repository.dart';
import 'package:foxy/view_model/glyph_property_list_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  tearDown(() => GetIt.instance.reset());

  testWidgets('显示法术编号并将筛选条件用于列表和总数', (tester) async {
    final queries = <LaconicQuery>[];
    GetIt.instance.registerSingleton<GlyphPropertyRepository>(
      _GlyphPropertyRepository(Laconic(_ReadDriver(), listen: queries.add)),
    );
    GetIt.instance.registerFactory(GlyphPropertyListViewModel.new);

    await tester.pumpWidget(
      const ShadApp(home: Scaffold(body: GlyphPropertyListPage())),
    );
    await tester.pumpAndSettle();

    final spellHeader = tester.getTopLeft(find.text('法术编号'));
    expect(spellHeader.dx, greaterThan(tester.getTopLeft(find.text('编号')).dx));
    expect(spellHeader.dx, lessThan(tester.getTopLeft(find.text('法术')).dx));
    expect(find.text('12345'), findsOneWidget);

    final idInput = find.widgetWithText(ShadInput, '编号（ID）');
    final spellIdInput = find.widgetWithText(ShadInput, '法术编号（SpellID）');
    await tester.enterText(idInput, '7');
    await tester.enterText(spellIdInput, '12345');
    queries.clear();
    await tester.tap(find.text('查询'));
    await tester.pumpAndSettle();

    final spellCondition = RegExp(r'`?gp`?\.`?SpellID`? = \?');
    expect(queries, hasLength(2));
    for (final query in queries) {
      expect(query.sql, contains(spellCondition));
      expect(query.bindings.take(2), ['7', 12345]);
    }

    queries.clear();
    await tester.tap(find.text('重置'));
    await tester.pumpAndSettle();

    expect(spellIdInput, findsOneWidget);
    expect(queries, hasLength(2));
    for (final query in queries) {
      expect(query.sql, isNot(contains(spellCondition)));
    }
  });
}

class _GlyphPropertyRepository extends GlyphPropertyRepository {
  @override
  final Laconic laconic;

  _GlyphPropertyRepository(this.laconic);
}

class _ReadDriver implements DatabaseDriver {
  @override
  final SqlGrammar grammar = MysqlGrammar();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async => [
    LaconicResult.fromMap(
      sql.contains('COUNT(*) as aggregate')
          ? {'aggregate': 1}
          : {'ID': 7, 'SpellID': 12345, 'spellName': '测试法术'},
    ),
  ];
}
