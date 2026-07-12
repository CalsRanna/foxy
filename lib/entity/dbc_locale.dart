import 'package:foxy/constant/dbc_definitions.dart';
import 'package:warcrafty/warcrafty.dart';

/// DBC 固定语言槽位（与 warcrafty `localeNames` 顺序一致）。
class DbcLocale {
  final int index;
  final String code;
  final String label;

  const DbcLocale({
    required this.index,
    required this.code,
    required this.label,
  });

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

  /// 固定 16 个语言槽位，顺序不可变。
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

  /// 弹窗第一列展示：`0 · enUS`。
  String get displayCode => '$index · $code';

  @override
  String toString() => 'DbcLocale($index, $code)';
}

/// 单个可本地化字段组的定义（对应宽表中的 16 个语言列）。
class DbcLocaleFieldDefinition {
  /// DBC 镜像表名，如 `dbc_spell`（不含 `foxy.` 前缀）。
  final String tableName;

  /// 列名前缀，如 `Name_lang`，用于生成 `Name_lang_enUS` 等。
  final String columnPrefix;

  /// 业务显示名称，用作弹窗第二列表头。
  final String label;

  /// 是否使用多行输入（描述类字段）。
  final bool multiline;

  DbcLocaleFieldDefinition._({
    required this.tableName,
    required this.columnPrefix,
    required this.label,
    required this.multiline,
  });

  /// 创建并校验字段定义：确保 Schema 中存在全部 16 个字符串语言列。
  factory DbcLocaleFieldDefinition({
    required String tableName,
    required String columnPrefix,
    required String label,
    bool multiline = false,
  }) {
    final definition = dbcDefinitionByTable[tableName];
    if (definition == null) {
      throw ArgumentError('未知 DBC 表: $tableName');
    }
    final schema = definition.schema;
    for (final locale in DbcLocale.values) {
      final column = '${columnPrefix}_${locale.code}';
      final field = schema.getFieldByName(column);
      if (field == null) {
        throw ArgumentError(
          'Schema ${schema.name} 缺少本地化列 $column（前缀 $columnPrefix）',
        );
      }
      if (!field.type.isString) {
        throw ArgumentError(
          'Schema ${schema.name} 列 $column 类型为 ${field.type}，期望 string',
        );
      }
    }
    return DbcLocaleFieldDefinition._(
      tableName: tableName,
      columnPrefix: columnPrefix,
      label: label,
      multiline: multiline,
    );
  }

  /// 16 个语言列的物理列名（不含 Flags）。
  List<String> get columnNames => [
    for (final locale in DbcLocale.values) columnFor(locale),
  ];

  String columnFor(DbcLocale locale) => '${columnPrefix}_${locale.code}';

  /// Flags 列名（本编辑器不读写，仅供引用）。
  String get flagsColumn => '${columnPrefix}_Flags';

  @override
  String toString() =>
      'DbcLocaleFieldDefinition($tableName.$columnPrefix, $label)';
}

/// 单个字段在一种语言下的值。
class DbcLocaleFieldValue {
  final DbcLocale locale;
  final String value;

  const DbcLocaleFieldValue({required this.locale, required this.value});

  DbcLocaleFieldValue copyWith({DbcLocale? locale, String? value}) {
    return DbcLocaleFieldValue(
      locale: locale ?? this.locale,
      value: value ?? this.value,
    );
  }

  @override
  String toString() => 'DbcLocaleFieldValue(${locale.code}: $value)';

  @override
  bool operator ==(Object other) {
    return other is DbcLocaleFieldValue &&
        other.locale.index == locale.index &&
        other.value == value;
  }

  @override
  int get hashCode => Object.hash(locale.index, value);
}

/// 从 16 行值中按语言代码取值。
extension DbcLocaleFieldValueListX on List<DbcLocaleFieldValue> {
  String valueOf(String code) {
    for (final item in this) {
      if (item.locale.code == code) return item.value;
    }
    return '';
  }

  String get zhCN => valueOf('zhCN');

  /// 用主语言草稿覆盖对应槽位（默认 [zhCN]）。
  ///
  /// 打开 DBC 弹窗时，主输入框可能已有未落库的编辑内容；
  /// 若直接使用数据库加载结果，保存会把草稿冲掉。
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

/// 从 [DbcSchema] 中发现全部本地化字段前缀（如 `Name_lang`）。
///
/// 通过匹配 `*_lang_enUS` 字符串列推断，用于覆盖完整性测试。
Set<String> discoverDbcLocaleColumnPrefixes(DbcSchema schema) {
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
