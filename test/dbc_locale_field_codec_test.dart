import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/dbc/dbc_locale_field_codec.dart';

void main() {
  group('DbcLocale', () {
    test('固定 16 个语言槽位且顺序与编号一致', () {
      expect(DbcLocale.values, hasLength(16));
      for (var i = 0; i < DbcLocale.values.length; i++) {
        expect(DbcLocale.values[i].index, i);
      }
      expect(DbcLocale.values[0].code, 'enUS');
      expect(DbcLocale.values[4].code, 'zhCN');
      expect(DbcLocale.values[15].code, 'unk3');
    });
  });

  group('DbcLocaleFieldCodec', () {
    final field = DbcLocaleFields.spellName;

    test('16 个语言列能够按固定编号正确解码', () {
      final row = <String, dynamic>{
        for (final locale in DbcLocale.values)
          field.columnFor(locale): 'value_${locale.code}',
        'Name_lang_Flags': 42,
        'Category': 7,
      };

      final values = DbcLocaleFieldCodec.decode(field, row);

      expect(values, hasLength(16));
      for (var i = 0; i < 16; i++) {
        expect(values[i].locale, DbcLocale.values[i]);
        expect(values[i].value, 'value_${DbcLocale.values[i].code}');
      }
    });

    test('解码后重新编码得到完全相同的 16 个字符串列', () {
      final row = <String, dynamic>{
        for (final locale in DbcLocale.values)
          field.columnFor(locale): 'v_${locale.code}',
      };
      final values = DbcLocaleFieldCodec.decode(field, row);
      final encoded = DbcLocaleFieldCodec.encode(field, values);

      expect(encoded, hasLength(16));
      for (final locale in DbcLocale.values) {
        expect(encoded[field.columnFor(locale)], 'v_${locale.code}');
      }
    });

    test('更新一个语言不会改变其他语言', () {
      final values = DbcLocaleFieldCodec.empty();
      final updated = [
        for (final item in values)
          item.locale.code == 'zhCN' ? item.copyWith(value: '火焰冲击') : item,
      ];
      final encoded = DbcLocaleFieldCodec.encode(field, updated);

      expect(encoded['Name_lang_zhCN'], '火焰冲击');
      expect(encoded['Name_lang_enUS'], '');
      expect(encoded['Name_lang_koKR'], '');
    });

    test('一个字段的 Codec 不会包含另一个本地化字段的列', () {
      final description = DbcLocaleFields.spellDescription;
      final values = [
        for (final locale in DbcLocale.values)
          DbcLocaleFieldValue(locale: locale, value: 'd_${locale.code}'),
      ];
      final encoded = DbcLocaleFieldCodec.encode(description, values);

      expect(
        encoded.keys.every((k) => k.startsWith('Description_lang_')),
        isTrue,
      );
      expect(encoded.containsKey('Name_lang_enUS'), isFalse);
      expect(encoded.containsKey('AuraDescription_lang_zhCN'), isFalse);
      expect(encoded.containsKey('Description_lang_Flags'), isFalse);
    });

    test('Flags 和普通字段不会出现在更新 Map 中', () {
      final values = DbcLocaleFieldCodec.empty();
      final encoded = DbcLocaleFieldCodec.encode(field, values);

      expect(encoded.containsKey('Name_lang_Flags'), isFalse);
      expect(encoded.containsKey('ID'), isFalse);
      expect(encoded.containsKey('Category'), isFalse);
      expect(encoded.keys, hasLength(16));
    });

    test('清空一种语言能够写入空字符串', () {
      final values = [
        for (final locale in DbcLocale.values)
          DbcLocaleFieldValue(
            locale: locale,
            value: locale.code == 'enUS' ? '' : 'x',
          ),
      ];
      final encoded = DbcLocaleFieldCodec.encode(field, values);
      expect(encoded['Name_lang_enUS'], '');
      expect(encoded['Name_lang_zhCN'], 'x');
    });

    test('拒绝长度不对的语言数据', () {
      expect(
        () => DbcLocaleFieldCodec.encode(field, [
          const DbcLocaleFieldValue(locale: DbcLocale.enUS, value: 'a'),
        ]),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('拒绝顺序非法的语言数据', () {
      final values = [
        const DbcLocaleFieldValue(locale: DbcLocale.zhCN, value: 'a'),
        for (var i = 1; i < 16; i++)
          DbcLocaleFieldValue(locale: DbcLocale.values[i], value: ''),
      ];
      expect(
        () => DbcLocaleFieldCodec.encode(field, values),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Schema 缺少语言列时字段定义创建失败', () {
      expect(
        () => DbcLocaleFieldDefinition(
          tableName: 'dbc_spell',
          columnPrefix: 'NotExist_lang',
          label: '不存在',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('未知 DBC 表时字段定义创建失败', () {
      expect(
        () => DbcLocaleFieldDefinition(
          tableName: 'dbc_not_exist',
          columnPrefix: 'Name_lang',
          label: '名称',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('withPrimaryDraft 用主输入框草稿覆盖 zhCN', () {
      final values = [
        for (final locale in DbcLocale.values)
          DbcLocaleFieldValue(
            locale: locale,
            value: locale.code == 'zhCN' ? '库中旧值' : 'other_${locale.code}',
          ),
      ];
      final merged = values.withPrimaryDraft('主框新值');

      expect(merged.zhCN, '主框新值');
      expect(merged.valueOf('enUS'), 'other_enUS');
      expect(merged.valueOf('koKR'), 'other_koKR');
      // 原列表不被修改
      expect(values.zhCN, '库中旧值');
    });
  });

  group('DbcLocaleFields coverage', () {
    test('所有 Schema 本地化字段都已注册编辑器', () {
      for (final definition in dbcDefinitions) {
        final prefixes = discoverDbcLocaleColumnPrefixes(definition.schema);
        for (final prefix in prefixes) {
          final registered = DbcLocaleFields.all.any(
            (field) =>
                field.tableName == definition.tableName &&
                field.columnPrefix == prefix,
          );
          expect(
            registered,
            isTrue,
            reason: 'Schema 含本地化前缀 ${definition.tableName}.$prefix 但未注册编辑器',
          );
        }
      }
    });

    test('已注册字段数量与清单一致', () {
      expect(DbcLocaleFields.all, hasLength(23));
    });

    test('已注册字段表名与前缀唯一', () {
      final keys = DbcLocaleFields.all
          .map((f) => '${f.tableName}.${f.columnPrefix}')
          .toSet();
      expect(keys, hasLength(DbcLocaleFields.all.length));
    });
  });
}
