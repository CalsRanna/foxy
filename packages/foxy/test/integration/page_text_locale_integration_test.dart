@Tags(['integration'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/database/database.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/infrastructure/preferences/locale_query_settings.dart';
import 'package:foxy/repository/page_text_locale_repository.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:get_it/get_it.dart';

import 'integration_mysql.dart';

/// `page_text` is the smallest world table whose list layer joins a locale
/// table, and its hand-written queries exercise the paths the CRUD suite cannot
/// reach: the `localeEnabled` JOIN, the multi-column `whereAny` filter, `like`
/// escaping, joined pagination and the `NextPageID` chain validation.
///
/// The DDL is copied from AzerothCore's `data/sql/base/db_world/page_text.sql`
/// and `.../page_text_locale.sql` (`Text` is nullable in the locale table,
/// `VerifiedBuild` in both).
///
/// Run with `flutter test --tags integration --run-skipped`.
void main() {
  const localeTableDdl = '''
create table `page_text_locale` (
  `ID` int unsigned not null default 0,
  `locale` varchar(4) character set utf8mb4 collate utf8mb4_unicode_ci not null,
  `Text` text character set utf8mb4 collate utf8mb4_unicode_ci,
  `VerifiedBuild` int default null,
  primary key (`ID`, `locale`)
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_unicode_ci
''';

  final pageText = PageTextRepository();
  final locale = PageTextLocaleRepository();
  final localeSettings = LocaleQuerySettings();

  setUpAll(() async {
    if (!GetIt.instance.isRegistered<LocaleQuerySettings>()) {
      GetIt.instance.registerSingleton(localeSettings);
    }
    await connectIntegrationWorldDatabase([
      'drop table if exists `page_text_locale`',
      'drop table if exists `page_text`',
      '''
create table `page_text` (
  `ID` int unsigned not null default 0,
  `Text` longtext character set utf8mb4 collate utf8mb4_unicode_ci not null,
  `NextPageID` int unsigned not null default 0,
  `VerifiedBuild` int default null,
  primary key (`ID`)
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_unicode_ci
''',
      localeTableDdl,
    ]);
  });

  tearDownAll(() => Database.instance.close());

  setUp(() async {
    localeSettings.reset();
    await Database.instance.laconic.statement('delete from `page_text_locale`');
    await Database.instance.laconic.statement('delete from `page_text`');
  });

  group('locale JOIN 读取', () {
    test('brief 取 zhCN 文本、忽略其他语言、无本地化时回落空串', () async {
      await pageText.storePageText(const PageTextEntity(id: 1, text: '原始一'));
      await pageText.storePageText(const PageTextEntity(id: 2, text: '原始二'));
      await locale.storePageTextLocale(
        const PageTextLocaleEntity(id: 1, locale: 'zhCN', text: '中文一'),
      );
      await locale.storePageTextLocale(
        const PageTextLocaleEntity(id: 1, locale: 'enUS', text: 'english one'),
      );

      final briefs = await pageText.getBriefPageTexts();

      expect(briefs.map((row) => row.id).toList(), [1, 2]);
      expect(briefs.first.localeText, '中文一');
      expect(briefs.first.text, '原始一');
      expect(briefs.last.localeText, isEmpty, reason: 'enUS 行不应被 zhCN 条件选中');
      expect(briefs.last.text, '原始二');
    });

    test('文本过滤同时搜父表与 zhCN 文本,% 与 _ 按字面量处理', () async {
      await pageText.storePageText(
        const PageTextEntity(id: 1, text: '进度 100% 完成'),
      );
      await pageText.storePageText(
        const PageTextEntity(id: 2, text: 'abc_def'),
      );
      await pageText.storePageText(const PageTextEntity(id: 3, text: '无关文本'));
      await pageText.storePageText(
        const PageTextEntity(id: 4, text: 'abcxdef'),
      );
      await locale.storePageTextLocale(
        const PageTextLocaleEntity(id: 3, locale: 'zhCN', text: '中文含 100% 号'),
      );

      // `%` is escaped: it matches the two rows that literally contain it
      // (id 3 only through its locale text), not every row.
      final percent = await pageText.getBriefPageTexts(
        filter: const PageTextFilter(text: '%'),
      );
      expect(percent.map((row) => row.id).toList(), [1, 3]);

      // `_` likewise: an unescaped wildcard would also match id 4.
      final underscore = await pageText.getBriefPageTexts(
        filter: const PageTextFilter(text: 'abc_def'),
      );
      expect(underscore.map((row) => row.id).toList(), [2]);
    });

    test('id 与 text 同时过滤时 OR 条件不越界', () async {
      await pageText.storePageText(const PageTextEntity(id: 1, text: '原始一'));

      final miss = await pageText.getBriefPageTexts(
        filter: const PageTextFilter(id: '1', text: '不存在的文本'),
      );
      expect(miss, isEmpty, reason: 'whereAny 的 OR 必须被括号包住');

      final hit = await pageText.getBriefPageTexts(
        filter: const PageTextFilter(id: '1', text: '原始'),
      );
      expect(hit.map((row) => row.id).toList(), [1]);
    });

    test('count 与 brief 过滤结果一致,id 过滤走无联表分支', () async {
      await pageText.storePageText(const PageTextEntity(id: 1, text: '原始一'));
      await pageText.storePageText(const PageTextEntity(id: 2, text: '原始二'));
      await pageText.storePageText(const PageTextEntity(id: 3, text: '别的'));
      await locale.storePageTextLocale(
        const PageTextLocaleEntity(id: 3, locale: 'zhCN', text: '原始三'),
      );

      const byText = PageTextFilter(text: '原始');
      expect(
        await pageText.countPageTexts(filter: byText),
        (await pageText.getBriefPageTexts(filter: byText)).length,
        reason: 'count 与 brief 必须用同一套过滤条件',
      );
      expect(await pageText.countPageTexts(), 3);
      expect(
        await pageText.countPageTexts(filter: const PageTextFilter(id: '2')),
        1,
      );
    });

    test('联表分页按 ID 升序', () async {
      final pageSize = pageText.kPageSize;
      await Future.wait([
        for (var id = 1; id <= pageSize + 1; id++)
          pageText.storePageText(PageTextEntity(id: id, text: 'p$id')),
      ]);

      final first = await pageText.getBriefPageTexts();
      expect(first, hasLength(pageSize));
      expect(first.first.id, 1);
      expect(first.last.id, pageSize);

      final second = await pageText.getBriefPageTexts(page: 2);
      expect(second, hasLength(1));
      expect(second.single.id, pageSize + 1);
    });

    test('localeEnabled=false 时不联 locale 表(表不存在也能查)', () async {
      await pageText.storePageText(const PageTextEntity(id: 1, text: '原始一'));
      await Database.instance.laconic.statement(
        'drop table `page_text_locale`',
      );
      addTearDown(() => Database.instance.laconic.statement(localeTableDdl));

      localeSettings.update(localeEnabled: false);

      final briefs = await pageText.getBriefPageTexts();
      expect(briefs.single.localeText, isEmpty);
      expect(briefs.single.text, '原始一');
      expect(
        await pageText.countPageTexts(filter: const PageTextFilter(text: '原始')),
        1,
      );
    });
  });

  group('locale 写路径与事务', () {
    test('复合主键的写入、更新、排序读取与删除', () async {
      await pageText.storePageText(const PageTextEntity(id: 7, text: 'p7'));
      await locale.storePageTextLocale(
        const PageTextLocaleEntity(id: 7, locale: 'zhCN', text: '中'),
      );
      await locale.storePageTextLocale(
        const PageTextLocaleEntity(id: 7, locale: 'deDE', text: 'de'),
      );
      expect(await locale.countPageTextLocales(7), 2);

      expect(
        (await locale.getBriefPageTextLocales(
          id: 7,
        )).map((row) => row.locale).toList(),
        ['deDE', 'zhCN'],
        reason: '按 locale 排序',
      );

      await locale.updatePageTextLocale(
        const PageTextLocaleKey(id: 7, locale: 'zhCN'),
        const PageTextLocaleEntity(id: 7, locale: 'zhCN', text: '改过'),
      );
      final updated = await locale.getBriefPageTextLocales(id: 7);
      expect(updated.firstWhere((row) => row.locale == 'zhCN').text, '改过');

      await locale.destroyPageTextLocale(
        const PageTextLocaleKey(id: 7, locale: 'deDE'),
      );
      expect(await locale.countPageTextLocales(7), 1);
      await expectLater(
        locale.destroyPageTextLocale(
          const PageTextLocaleKey(id: 7, locale: 'deDE'),
        ),
        throwsA(isA<RecordNotFoundException>()),
      );
    });

    test('applyPageTextLocaleChanges 在同一事务内增删改,失败时回滚', () async {
      await pageText.storePageText(const PageTextEntity(id: 5, text: 'p5'));
      await locale.storePageTextLocale(
        const PageTextLocaleEntity(id: 5, locale: 'zhCN', text: '原'),
      );
      await locale.storePageTextLocale(
        const PageTextLocaleEntity(id: 5, locale: 'enUS', text: 'orig'),
      );

      await locale.applyPageTextLocaleChanges(
        creations: const [
          PageTextLocaleEntity(id: 5, locale: 'frFR', text: 'fr'),
        ],
        deletions: const [PageTextLocaleKey(id: 5, locale: 'enUS')],
        updates: {
          const PageTextLocaleKey(id: 5, locale: 'zhCN'):
              const PageTextLocaleEntity(id: 5, locale: 'zhCN', text: '新'),
        },
      );
      final applied = await locale.getBriefPageTextLocales(id: 5);
      expect(applied.map((row) => row.locale).toList(), ['frFR', 'zhCN']);
      expect(applied.last.text, '新');

      // The update targets a missing key, so the whole batch must roll back —
      // including the deletion that ran before it.
      await expectLater(
        locale.applyPageTextLocaleChanges(
          creations: const [],
          deletions: const [PageTextLocaleKey(id: 5, locale: 'frFR')],
          updates: {
            const PageTextLocaleKey(
              id: 999,
              locale: 'zhCN',
            ): const PageTextLocaleEntity(
              id: 999,
              locale: 'zhCN',
              text: 'ghost',
            ),
          },
        ),
        throwsA(isA<RecordNotFoundException>()),
      );
      expect(
        (await locale.getBriefPageTextLocales(
          id: 5,
        )).map((row) => row.locale).toList(),
        ['frFR', 'zhCN'],
        reason: '事务回滚后先前删除的 locale 行应仍在',
      );
    });
  });

  group('page_text 业务规则', () {
    test('NextPageID 指向缺失页被拒', () async {
      await expectLater(
        pageText.storePageText(
          const PageTextEntity(id: 1, text: 'a', nextPageId: 42),
        ),
        throwsA(isA<RecordNotFoundException>()),
      );
    });

    test('NextPageID 成环被拒,合法链可写', () async {
      await pageText.storePageText(const PageTextEntity(id: 1, text: 'a'));
      await pageText.storePageText(
        const PageTextEntity(id: 2, text: 'b', nextPageId: 1),
      );

      await expectLater(
        pageText.updatePageText(
          1,
          const PageTextEntity(id: 1, text: 'a', nextPageId: 2),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('copy 取新 ID 并保留内容', () async {
      // The referenced page must exist first: storing validates the chain.
      await pageText.storePageText(const PageTextEntity(id: 2, text: 'b'));
      await pageText.storePageText(
        const PageTextEntity(id: 1, text: 'a', nextPageId: 2),
      );

      expect(await pageText.copyPageText(1), 3);
      final copy = await pageText.getPageText(3);
      expect(copy, isNotNull);
      expect(copy!.text, 'a');
      expect(copy.nextPageId, 2);

      await expectLater(
        pageText.copyPageText(404),
        throwsA(isA<RecordNotFoundException>()),
      );
    });
  });
}
