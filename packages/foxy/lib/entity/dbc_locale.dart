import 'package:foxy/constant/dbc_definitions.dart';
import 'package:warcrafty/warcrafty.dart';

/// DBC fixed language slots (matching warcrafty's `localeNames` order).
class DbcLocale {
  /// Discovers all locale-field prefixes (e.g. `Name_lang`) from
  /// [DbcSchema].
  ///
  /// Inferred by matching `*_lang_enUS` string columns; used by the
  /// coverage-completeness tests.
  static Set<String> discoverColumnPrefixes(DbcSchema schema) {
    final prefixes = <String>{};
    for (final field in schema.fields) {
      if (!field.type.isString) continue;
      const suffix = '_enUS';
      if (!field.name.endsWith(suffix)) continue;
      // Name_lang_enUS → Name_lang
      final withoutLocale = field.name.substring(
        0,
        field.name.length - suffix.length,
      );
      if (!withoutLocale.endsWith('_lang')) continue;
      prefixes.add(withoutLocale);
    }
    return prefixes;
  }

  static const enUS = DbcLocale(index: 0, code: 'enUS', label: '美式英语');
  static const koKR = DbcLocale(index: 1, code: 'koKR', label: '韩语');
  static const frFR = DbcLocale(index: 2, code: 'frFR', label: '法语');

  static const deDE = DbcLocale(index: 3, code: 'deDE', label: '德语');

  static const zhCN = DbcLocale(index: 4, code: 'zhCN', label: '简体中文');
  static const zhTW = DbcLocale(index: 5, code: 'zhTW', label: '繁体中文');
  static const esES = DbcLocale(index: 6, code: 'esES', label: '西班牙语');
  static const esMX = DbcLocale(index: 7, code: 'esMX', label: '墨西哥西班牙语');
  static const ruRU = DbcLocale(index: 8, code: 'ruRU', label: '俄语');
  static const jaJP = DbcLocale(index: 9, code: 'jaJP', label: '日语');
  static const ptPT = DbcLocale(index: 10, code: 'ptPT', label: '葡萄牙语');
  static const ptBR = DbcLocale(index: 11, code: 'ptBR', label: '巴西葡萄牙语');
  static const itIT = DbcLocale(index: 12, code: 'itIT', label: '意大利语');
  static const unk1 = DbcLocale(index: 13, code: 'unk1', label: '未知语言 1');
  static const unk2 = DbcLocale(index: 14, code: 'unk2', label: '未知语言 2');
  static const unk3 = DbcLocale(index: 15, code: 'unk3', label: '未知语言 3');

  /// Fixed 16 language slots; the order is immutable.
  static const List<DbcLocale> values = [
    enUS,
    koKR,
    frFR,
    deDE,
    zhCN,
    zhTW,
    esES,
    esMX,
    ruRU,
    jaJP,
    ptPT,
    ptBR,
    itIT,
    unk1,
    unk2,
    unk3,
  ];
  final int index;
  final String code;
  final String label;

  const DbcLocale({
    required this.index,
    required this.code,
    required this.label,
  });

  @override
  String toString() => 'DbcLocale($index, $code)';
}

/// Definition of a single localizable field group (the 16 language
/// columns of the wide table).
class DbcLocaleFieldDefinition {
  /// DBC mirror table name, e.g. `dbc_spell` (without the `foxy.`
  /// prefix).
  final String tableName;

  /// Column-name prefix, e.g. `Name_lang`, used to produce `Name_lang_enUS`
  /// etc.
  final String columnPrefix;

  /// Business display name, used as the dialog's second-column header.
  final String label;

  /// Creates and validates the field definition: ensures all 16 string
  /// language columns exist in the Schema.
  factory DbcLocaleFieldDefinition({
    required String tableName,
    required String columnPrefix,
    required String label,
    bool multiline = false,
  }) {
    final definition = DbcDefinitions.byTable[tableName];
    if (definition == null) {
      throw ArgumentError('unknown DBC table: $tableName');
    }
    final schema = definition.schema;
    for (final locale in DbcLocale.values) {
      final column = '${columnPrefix}_${locale.code}';
      final field = schema.getFieldByName(column);
      if (field == null) {
        throw ArgumentError(
          'Schema ${schema.name} is missing locale column $column (prefix $columnPrefix)',
        );
      }
      if (!field.type.isString) {
        throw ArgumentError(
          'Schema ${schema.name} column $column has type ${field.type}, expected string',
        );
      }
    }
    return DbcLocaleFieldDefinition._(
      tableName: tableName,
      columnPrefix: columnPrefix,
      label: label,
    );
  }

  DbcLocaleFieldDefinition._({
    required this.tableName,
    required this.columnPrefix,
    required this.label,
  });

  /// Physical column names of the 16 language columns (without Flags).
  List<String> get columnNames => [
    for (final locale in DbcLocale.values) columnFor(locale),
  ];

  /// Flags column name (this editor neither reads nor writes it; reference
  /// only).
  String get flagsColumn => '${columnPrefix}_Flags';

  String columnFor(DbcLocale locale) => '${columnPrefix}_${locale.code}';

  @override
  String toString() =>
      'DbcLocaleFieldDefinition($tableName.$columnPrefix, $label)';
}

/// Value of a single field in one language.
class DbcLocaleFieldValue {
  final DbcLocale locale;
  final String value;

  const DbcLocaleFieldValue({required this.locale, required this.value});

  @override
  int get hashCode => Object.hash(locale.index, value);

  @override
  bool operator ==(Object other) {
    return other is DbcLocaleFieldValue &&
        other.locale.index == locale.index &&
        other.value == value;
  }

  DbcLocaleFieldValue copyWith({DbcLocale? locale, String? value}) {
    return DbcLocaleFieldValue(
      locale: locale ?? this.locale,
      value: value ?? this.value,
    );
  }

  @override
  String toString() => 'DbcLocaleFieldValue(${locale.code}: $value)';
}

/// Looks up a value from the 16 rows by language code.
extension DbcLocaleFieldValueListX on List<DbcLocaleFieldValue> {
  String get zhCN => valueOf('zhCN');

  String valueOf(String code) {
    for (final item in this) {
      if (item.locale.code == code) return item.value;
    }
    return '';
  }

  /// Overrides the matching slot with the main-language draft (default
  /// [zhCN]).
  ///
  /// When the DBC dialog opens, the main input may already hold unsaved
  /// edits; using the database-loaded result directly would wipe that
  /// draft on save.
  List<DbcLocaleFieldValue> withPrimaryDraft(
    String draft, {
    String primaryCode = 'zhCN',
  }) {
    return [
      for (final item in this)
        item.locale.code == primaryCode ? item.copyWith(value: draft) : item,
    ];
  }
}
