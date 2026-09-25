@Tags(['integration'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/database/database.dart';
import 'package:foxy/entity/spell_custom_attr_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/repository/spell_custom_attr_repository.dart';

import 'integration_mysql.dart';

/// Repository read/write behavior against a real MySQL.
///
/// `spell_custom_attr` is the smallest table whose row repository is almost
/// entirely generated (`@FoxyRepository()` → store/update/destroy/get come from
/// `_SpellCustomAttrRepositoryMixin`) and whose queries touch no other table, so
/// the fixture is two columns. The DDL below is copied from AzerothCore's
/// `data/sql/base/db_world/spell_custom_attr.sql` (column names, types, defaults
/// and key included), so the entity's column mapping is checked against the
/// upstream table rather than against itself.
///
/// Run with `flutter test --tags integration --run-skipped`.
void main() {
  const fixtureTable = 'spell_custom_attr';

  final repository = SpellCustomAttrRepository();
  // `kPageSize` is a RepositoryMixin instance field, so read it off the
  // repository instead of duplicating the value.
  final pageSize = repository.kPageSize;

  setUpAll(() async {
    // The schema is created by the helper and is dedicated to these tests, so
    // dropping the fixture table is safe.
    await connectIntegrationWorldDatabase([
      'drop table if exists `$fixtureTable`',
      '''
create table `$fixtureTable` (
  `spell_id` int unsigned not null default 0,
  `attributes` int unsigned not null default 0,
  primary key (`spell_id`)
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_unicode_ci
''',
    ]);
  });

  tearDownAll(() => Database.instance.close());

  setUp(
    () => Database.instance.laconic.statement('delete from `$fixtureTable`'),
  );

  test('store → get 往返,写入的是实体映射的物理列', () async {
    final key = await repository.storeSpellCustomAttr(
      const SpellCustomAttrEntity(spellId: 100, attributes: 7),
    );
    expect(key, 100);

    final loaded = await repository.getSpellCustomAttr(100);
    expect(loaded, isNotNull);
    expect(loaded!.spellId, 100);
    expect(loaded.attributes, 7);

    final rows = await Database.instance.laconic.table(fixtureTable).select([
      'spell_id',
      'attributes',
    ]).get();
    expect(rows, hasLength(1));
    expect(rows.first.toMap()['spell_id'], 100);
    expect(rows.first.toMap()['attributes'], 7);
  });

  test('主键重复时改号写入:返回 MAX(spell_id)+1,字段随源记录', () async {
    await repository.storeSpellCustomAttr(
      const SpellCustomAttrEntity(spellId: 100, attributes: 7),
    );
    final second = await repository.storeSpellCustomAttr(
      const SpellCustomAttrEntity(spellId: 100, attributes: 9),
    );

    expect(second, 101);
    expect((await repository.getSpellCustomAttr(101))!.attributes, 9);
    expect(await repository.countSpellCustomAttrs(), 2);
  });

  test('主键未赋值时拒绝写入', () async {
    await expectLater(
      repository.storeSpellCustomAttr(
        const SpellCustomAttrEntity(attributes: 1),
      ),
      throwsA(isA<InvalidPrimaryKeyException>()),
    );
    expect(await repository.countSpellCustomAttrs(), 0);
  });

  test('update 改写字段;同值 update 不会误报 not found', () async {
    await repository.storeSpellCustomAttr(
      const SpellCustomAttrEntity(spellId: 5, attributes: 1),
    );

    await repository.updateSpellCustomAttr(
      5,
      const SpellCustomAttrEntity(spellId: 5, attributes: 2),
    );
    expect((await repository.getSpellCustomAttr(5))!.attributes, 2);

    // laconic_mysql negotiates CLIENT_FOUND_ROWS, so MySQL reports *matched*
    // rows: a no-op update must not surface as RecordNotFoundException.
    await repository.updateSpellCustomAttr(
      5,
      const SpellCustomAttrEntity(spellId: 5, attributes: 2),
    );
    expect((await repository.getSpellCustomAttr(5))!.attributes, 2);
  });

  test('update/destroy 目标不存在时抛 RecordNotFoundException', () async {
    await expectLater(
      repository.updateSpellCustomAttr(
        404,
        const SpellCustomAttrEntity(spellId: 404, attributes: 1),
      ),
      throwsA(isA<RecordNotFoundException>()),
    );
    await expectLater(
      repository.destroySpellCustomAttr(404),
      throwsA(isA<RecordNotFoundException>()),
    );
  });

  test('destroy 删除后主键可被重新使用', () async {
    await repository.storeSpellCustomAttr(
      const SpellCustomAttrEntity(spellId: 9, attributes: 3),
    );
    await repository.destroySpellCustomAttr(9);
    expect(await repository.getSpellCustomAttr(9), isNull);

    expect(
      await repository.storeSpellCustomAttr(
        const SpellCustomAttrEntity(spellId: 9, attributes: 4),
      ),
      9,
    );
  });

  test('手写列表方法:排序、count、分页与 create 预填主键', () async {
    await Future.wait([
      for (var id = 1; id <= pageSize + 1; id++)
        repository.storeSpellCustomAttr(
          SpellCustomAttrEntity(spellId: id, attributes: id * 2),
        ),
    ]);

    expect(await repository.countSpellCustomAttrs(), pageSize + 1);
    expect(await repository.getSpellCustomAttrs(), hasLength(pageSize + 1));

    final firstPage = await repository.getBriefSpellCustomAttrs();
    expect(firstPage, hasLength(pageSize));
    expect(firstPage.first.spellId, 1);
    expect(firstPage.last.spellId, pageSize);

    final secondPage = await repository.getBriefSpellCustomAttrs(page: 2);
    expect(secondPage, hasLength(1));
    expect(secondPage.single.spellId, pageSize + 1);
    expect(secondPage.single.attributes, (pageSize + 1) * 2);

    final draft = await repository.createSpellCustomAttr();
    expect(draft.spellId, pageSize + 2, reason: 'create 只预填主键,不落库');
    expect(await repository.countSpellCustomAttrs(), pageSize + 1);

    await expectLater(
      repository.copySpellCustomAttr(1),
      throwsA(isA<CopyNotSupportedException>()),
    );
  });
}
