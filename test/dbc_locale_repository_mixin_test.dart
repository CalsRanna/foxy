import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/util/dbc_locale_field_codec.dart';

void main() {
  group('DbcLocaleRepositoryMixin 表名校验', () {
    test('SpellRepository 拒绝 AreaTable 字段定义', () async {
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

    test('SpellRepository 拒绝错误表字段的保存', () async {
      final repo = SpellRepository();
      await expectLater(
        repo.saveSpellLocales(
          1,
          DbcLocaleFields.factionName,
          DbcLocaleFieldCodec.empty(),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('AreaTableRepository 接受本表字段定义（失败应来自 DB 而非表名）', () async {
      final repo = AreaTableRepository();
      // 未连接数据库时会在存在性检查或查询处失败，但不应是表名 ArgumentError
      try {
        await repo.getAreaTableLocales(1, DbcLocaleFields.areaTableAreaName);
        fail('expected database error');
      } on ArgumentError catch (e) {
        fail('不应因表名校验失败: $e');
      } catch (_) {
        // 预期：Database/StateError 等
      }
    });
  });
}
