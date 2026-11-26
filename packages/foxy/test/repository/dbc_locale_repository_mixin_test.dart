import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/infrastructure/dbc/dbc_locale_field_codec.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/repository/spell_repository.dart';

void main() {
  group('DbcLocaleRepositoryMixin table name validation', () {
    test('SpellRepository rejects an AreaTable field definition', () async {
      final repo = SpellRepository();
      await expectLater(
        repo.getSpellLocales(1, DbcLocaleFields.areaTableAreaName),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            allOf(contains('AreaName_lang'), contains('dbc_area_table')),
          ),
        ),
      );
    });

    test(
      'SpellRepository rejects saving fields from the wrong table',
      () async {
        final repo = SpellRepository();
        await expectLater(
          repo.saveSpellLocales(
            1,
            DbcLocaleFields.factionName,
            DbcLocaleFieldCodec.empty(),
          ),
          throwsA(isA<ArgumentError>()),
        );
      },
    );

    test('AreaTableRepository accepts its own field definition and reaches the database', () async {
      final repo = AreaTableRepository();
      // Without a DB connection, failures happen at the existence check or
      // query — never a table-name ArgumentError
      try {
        await repo.getAreaTableLocales(1, DbcLocaleFields.areaTableAreaName);
        fail('expected database error');
      } on ArgumentError catch (e) {
        fail('不应因表名校验失败: $e');
      } catch (_) {
        // Expected: Database/StateError etc.
      }
    });
  });
}
