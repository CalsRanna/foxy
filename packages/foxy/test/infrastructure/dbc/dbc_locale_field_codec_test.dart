import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/infrastructure/dbc/dbc_locale_field_codec.dart';
import 'package:foxy/model/dbc/dbc_locale.dart';

void main() {
  group('DbcLocale', () {
    test('The 16 locale slots are ordered by their fixed indices', () {
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

    test('All 16 language columns decode by their fixed indices', () {
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

    test('Decoding and encoding preserve all 16 string columns exactly', () {
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

    test('Updating one locale preserves the others', () {
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

    test(
      'A field codec excludes columns belonging to other localized fields',
      () {
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
      },
    );

    test('The update map excludes flags and regular fields', () {
      final values = DbcLocaleFieldCodec.empty();
      final encoded = DbcLocaleFieldCodec.encode(field, values);

      expect(encoded.containsKey('Name_lang_Flags'), isFalse);
      expect(encoded.containsKey('ID'), isFalse);
      expect(encoded.containsKey('Category'), isFalse);
      expect(encoded.keys, hasLength(16));
    });

    test('Clearing a locale writes an empty string', () {
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

    test('Locale data with the wrong length is rejected', () {
      expect(
        () => DbcLocaleFieldCodec.encode(field, [
          const DbcLocaleFieldValue(locale: DbcLocale.enUS, value: 'a'),
        ]),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Locale data in an invalid order is rejected', () {
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

    test('Field definition creation fails when the schema is missing language columns', () {
      expect(
        () => DbcLocaleFieldDefinition(
          tableName: 'dbc_spell',
          columnPrefix: 'NotExist_lang',
          label: '不存在',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Field definition creation fails for an unknown DBC table', () {
      expect(
        () => DbcLocaleFieldDefinition(
          tableName: 'dbc_not_exist',
          columnPrefix: 'Name_lang',
          label: '名称',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('withPrimaryDraft replaces zhCN with the primary input draft', () {
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
      // The original list is not modified
      expect(values.zhCN, '库中旧值');
    });
  });

  group('DbcLocaleFields coverage', () {
    test('Every localized field in the schemas has a registered editor', () {
      for (final definition in DbcDefinitions.all) {
        final prefixes = DbcDefinitions.discoverColumnPrefixes(
          definition.schema,
        );
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

    test('The number of registered fields matches the inventory', () {
      expect(DbcLocaleFields.all, hasLength(39));
    });

    test('Registered field table and prefix pairs are unique', () {
      final keys = DbcLocaleFields.all
          .map((f) => '${f.tableName}.${f.columnPrefix}')
          .toSet();
      expect(keys, hasLength(DbcLocaleFields.all.length));
    });
  });
}
