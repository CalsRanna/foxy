@Tags(['integration'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/database/database.dart';
import 'package:foxy/infrastructure/preferences/locale_query_settings.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:get_it/get_it.dart';

import 'integration_mysql.dart';

/// The app's landing module (`creature_template` list) against a real MySQL:
/// the zhCN locale JOIN, both `whereAny` filters (name and subName), the
/// `localeEnabled` switch and joined pagination.
///
/// The fixture is a **reduced** `creature_template`: only the five columns the
/// brief/count queries touch (`entry`, `name`, `subname`, `minlevel`,
/// `maxlevel`), copied verbatim from AzerothCore's
/// `data/sql/base/db_world/creature_template.sql`; `creature_template_locale`
/// likewise carries only `entry`/`locale`/`Name`/`Title` from the upstream
/// table. Because the table is reduced, fixture rows go in through explicit
/// SQL instead of `storeCreatureTemplate` (which writes all ~150 columns) —
/// the generated write path is covered by the `spell_custom_attr` suite.
/// Generic concerns already pinned by the `page_text` suite (`like` escaping,
/// OR-grouping) are not repeated here.
///
/// Run with `flutter test --tags integration --run-skipped`.
void main() {
  const localeTableDdl = '''
create table `creature_template_locale` (
  `entry` int unsigned not null default 0,
  `locale` varchar(4) character set utf8mb4 collate utf8mb4_unicode_ci not null,
  `Name` text character set utf8mb4 collate utf8mb4_unicode_ci,
  `Title` text character set utf8mb4 collate utf8mb4_unicode_ci,
  primary key (`entry`, `locale`)
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_unicode_ci
''';

  final repository = CreatureTemplateRepository();
  final localeSettings = LocaleQuerySettings();

  Future<void> insertCreature(
    int entry,
    String name,
    String? subName,
    int minLevel,
    int maxLevel,
  ) => Database.instance.laconic.statement(
    'insert into `creature_template` '
    '(`entry`, `name`, `subname`, `minlevel`, `maxlevel`) '
    'values (?, ?, ${subName == null ? 'null' : '?'}, ?, ?)',
    [entry, name, ?subName, minLevel, maxLevel],
  );

  Future<void> insertLocale(
    int entry,
    String locale,
    String name,
    String title,
  ) => Database.instance.laconic.statement(
    'insert into `creature_template_locale` '
    '(`entry`, `locale`, `Name`, `Title`) values (?, ?, ?, ?)',
    [entry, locale, name, title],
  );

  setUpAll(() async {
    if (!GetIt.instance.isRegistered<LocaleQuerySettings>()) {
      GetIt.instance.registerSingleton(localeSettings);
    }
    await connectIntegrationWorldDatabase([
      'drop table if exists `creature_template_locale`',
      'drop table if exists `creature_template`',
      '''
create table `creature_template` (
  `entry` int unsigned not null default 0,
  `name` char(100) character set utf8mb4 collate utf8mb4_unicode_ci not null default '0',
  `subname` char(100) character set utf8mb4 collate utf8mb4_unicode_ci default null,
  `minlevel` tinyint unsigned not null default 1,
  `maxlevel` tinyint unsigned not null default 1,
  primary key (`entry`)
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_unicode_ci
''',
      localeTableDdl,
    ]);
  });

  tearDownAll(() => Database.instance.close());

  setUp(() async {
    localeSettings.reset();
    await Database.instance.laconic.statement(
      'delete from `creature_template_locale`',
    );
    await Database.instance.laconic.statement(
      'delete from `creature_template`',
    );
  });

  test('brief 取 zhCN 名称与称号,忽略其他语言,NULL 称号回落空串', () async {
    await insertCreature(1, 'Kobold Vermin', null, 1, 2);
    await insertCreature(2, 'Wolf', 'Beast', 3, 4);
    await insertLocale(1, 'zhCN', '狗头人苦工', '怪物');
    await insertLocale(1, 'enUS', 'Kobold Vermin', 'Vermin');

    final briefs = await repository.getBriefCreatureTemplates();

    expect(briefs.map((row) => row.entry).toList(), [1, 2]);
    expect(briefs.first.name, 'Kobold Vermin');
    expect(briefs.first.localeName, '狗头人苦工');
    expect(briefs.first.localeSubName, '怪物');
    expect(briefs.first.subName, isEmpty, reason: 'subname 为 NULL 时读成空串');
    expect(briefs.first.minLevel, 1);
    expect(briefs.first.maxLevel, 2);
    expect(briefs.last.localeName, isEmpty, reason: '无 zhCN 行');
    expect(briefs.last.subName, 'Beast');
  });

  test('名称过滤同时搜 ct.name 与 zhCN 名称', () async {
    await insertCreature(1, 'Kobold Vermin', null, 1, 2);
    await insertCreature(2, 'Wolf', 'Beast', 3, 4);
    await insertLocale(1, 'zhCN', '狗头人苦工', '怪物');

    final byLocale = await repository.getBriefCreatureTemplates(
      filter: const CreatureTemplateFilter(name: '狗头人'),
    );
    expect(byLocale.map((row) => row.entry).toList(), [1]);

    final byOriginal = await repository.getBriefCreatureTemplates(
      filter: const CreatureTemplateFilter(name: 'Wolf'),
    );
    expect(byOriginal.map((row) => row.entry).toList(), [2]);

    const filter = CreatureTemplateFilter(name: '头人');
    expect(
      await repository.countCreatureTemplates(filter: filter),
      (await repository.getBriefCreatureTemplates(filter: filter)).length,
      reason: 'count 带名称过滤时必须与 brief 用同一套联表条件',
    );
  });

  test('称号过滤同时搜 ct.subname 与 zhCN 称号', () async {
    await insertCreature(1, 'Kobold Vermin', null, 1, 2);
    await insertCreature(2, 'Wolf', 'Beast', 3, 4);
    await insertLocale(1, 'zhCN', '狗头人苦工', '怪物');

    final byLocale = await repository.getBriefCreatureTemplates(
      filter: const CreatureTemplateFilter(subName: '怪物'),
    );
    expect(byLocale.map((row) => row.entry).toList(), [1]);

    final byOriginal = await repository.getBriefCreatureTemplates(
      filter: const CreatureTemplateFilter(subName: 'Beast'),
    );
    expect(byOriginal.map((row) => row.entry).toList(), [2]);
  });

  test('entry 过滤走无联表分支,entry+name 同时过滤不越界', () async {
    await insertCreature(1, 'Kobold Vermin', null, 1, 2);
    await insertCreature(2, 'Wolf', 'Beast', 3, 4);

    expect(
      await repository.countCreatureTemplates(
        filter: const CreatureTemplateFilter(entry: '2'),
      ),
      1,
    );

    final miss = await repository.getBriefCreatureTemplates(
      filter: const CreatureTemplateFilter(entry: '1', name: '不存在的名字'),
    );
    expect(miss, isEmpty, reason: 'whereAny 的 OR 必须被括号包住');
  });

  test('localeEnabled=false 时不联 locale 表(表不存在也能查)', () async {
    await insertCreature(1, 'Kobold Vermin', null, 1, 2);
    await Database.instance.laconic.statement(
      'drop table `creature_template_locale`',
    );
    addTearDown(() => Database.instance.laconic.statement(localeTableDdl));

    localeSettings.update(localeEnabled: false);

    final briefs = await repository.getBriefCreatureTemplates();
    expect(briefs.single.localeName, isEmpty);
    expect(briefs.single.name, 'Kobold Vermin');
    expect(
      await repository.countCreatureTemplates(
        filter: const CreatureTemplateFilter(name: 'Kobold'),
      ),
      1,
    );
  });

  test('联表分页按 entry 升序', () async {
    final pageSize = repository.kPageSize;
    await Future.wait([
      for (var entry = 1; entry <= pageSize + 1; entry++)
        insertCreature(entry, 'creature $entry', null, 1, 1),
    ]);

    final first = await repository.getBriefCreatureTemplates();
    expect(first, hasLength(pageSize));
    expect(first.first.entry, 1);
    expect(first.last.entry, pageSize);

    final second = await repository.getBriefCreatureTemplates(page: 2);
    expect(second, hasLength(1));
    expect(second.single.entry, pageSize + 1);
    expect(await repository.countCreatureTemplates(), pageSize + 1);
  });

  test('create 预填 entry 为 MAX(entry)+1,且不落库', () async {
    await insertCreature(7, 'Wolf', 'Beast', 3, 4);

    final draft = await repository.createCreatureTemplate();

    expect(draft.entry, 8);
    expect(draft.name, isEmpty);
    expect(await repository.countCreatureTemplates(), 1);
  });
}
