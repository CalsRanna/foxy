import 'dart:io';

final class _Field {
  final String name;
  final String type;
  final String defaultSource;
  final String column;

  const _Field({
    required this.name,
    required this.type,
    required this.defaultSource,
    required this.column,
  });
}

final class _Companion {
  final List<String> fields;
  final Map<String, String> defaults;
  final Map<String, String> types;

  const _Companion({
    required this.fields,
    required this.defaults,
    required this.types,
  });
}

final class _Migration {
  final File fullFile;
  final String className;
  final String table;
  final List<_Field> fields;
  final Set<String> keyFields;
  final Set<String> briefFields;
  final Map<String, _Field> filterFields;
  final File? briefFile;
  final File? filterFile;
  final File? keyFile;
  final List<String> customGetters;
  final String sourcePrefix;

  const _Migration({
    required this.fullFile,
    required this.className,
    required this.table,
    required this.fields,
    required this.keyFields,
    required this.briefFields,
    required this.filterFields,
    required this.briefFile,
    required this.filterFile,
    required this.keyFile,
    required this.customGetters,
    required this.sourcePrefix,
  });
}

final class _FilterPromotion {
  final File fullFile;
  final File filterFile;
  final Map<String, _Field> fields;

  const _FilterPromotion({
    required this.fullFile,
    required this.filterFile,
    required this.fields,
  });
}

void main(List<String> arguments) {
  final write = arguments.contains('--write');
  if (write) _splitMultiEntityFiles();
  final entityDirectory = Directory('lib/entity');
  final files =
      entityDirectory
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('_entity.dart'))
          .where((file) => !file.path.contains('.g.dart'))
          .where((file) => !file.uri.pathSegments.last.startsWith('brief_'))
          .where(
            (file) =>
                !file.uri.pathSegments.last.endsWith('_filter_entity.dart'),
          )
          .toList()
        ..sort((left, right) => left.path.compareTo(right.path));

  final migrations = <_Migration>[];
  final filterPromotions = <_FilterPromotion>[];
  final skipped = <String, String>{};
  for (final file in files) {
    final name = file.uri.pathSegments.last;
    if (_explicitExclusions.contains(name)) {
      skipped[name] = 'explicit special entity';
      continue;
    }
    if (file.readAsStringSync().contains('@FoxyFullEntity')) {
      final promotion = _inspectAnnotatedFilter(file);
      if (promotion != null) filterPromotions.add(promotion);
      skipped[name] = 'already migrated';
      continue;
    }
    try {
      final migration = _inspect(file);
      migrations.add(migration);
    } on FormatException catch (error) {
      skipped[name] = error.message;
    }
  }

  stdout.writeln(
    'eligible=${migrations.length} '
    'brief=${migrations.where((item) => item.briefFile != null).length} '
    'filter=${migrations.where((item) => item.filterFile != null).length} '
    'compositeKey=${migrations.where((item) => item.keyFile != null).length} '
    'filterPromotion=${filterPromotions.length} '
    'skipped=${skipped.length}',
  );
  for (final entry in skipped.entries) {
    stdout.writeln('SKIP ${entry.key}: ${entry.value}');
  }
  if (!write) {
    stdout.writeln('Dry run only; pass --write to migrate eligible entities.');
    return;
  }

  for (final migration in migrations) {
    migration.fullFile.writeAsStringSync(_emitFull(migration));
    if (migration.briefFile case final file?) {
      file.writeAsStringSync(
        "export '${_generatedName(migration.fullFile, 'brief')}';\n",
      );
    }
    if (migration.filterFile case final file?) {
      file.writeAsStringSync(
        "export '${_generatedName(migration.fullFile, 'filter')}';\n",
      );
    }
    if (migration.keyFile case final file?) {
      file.writeAsStringSync(
        "export '${_generatedName(migration.fullFile, 'key')}';\n",
      );
    }
  }
  for (final promotion in filterPromotions) {
    _applyFilterPromotion(promotion);
  }
}

const _explicitExclusions = {
  'activity_log_entity.dart',
  'feature_entity.dart',
  'item_bag_family_entity.dart',
};

void _splitMultiEntityFiles() {
  const plans = {
    'lib/entity/player_create_info_entity.dart': {
      'PlayerCreateInfoActionEntity':
          'lib/entity/player_create_info_action_entity.dart',
      'PlayerCreateInfoCastSpellEntity':
          'lib/entity/player_create_info_cast_spell_entity.dart',
      'PlayerCreateInfoEntity': 'lib/entity/player_create_info_entity.dart',
      'PlayerCreateInfoItemEntity':
          'lib/entity/player_create_info_item_entity.dart',
      'PlayerCreateInfoSkillEntity':
          'lib/entity/player_create_info_skill_entity.dart',
      'PlayerCreateInfoSpellCustomEntity':
          'lib/entity/player_create_info_spell_custom_entity.dart',
    },
    'lib/entity/quest_offer_reward_entity.dart': {
      'QuestOfferRewardEntity': 'lib/entity/quest_offer_reward_entity.dart',
      'QuestOfferRewardLocaleEntity':
          'lib/entity/quest_offer_reward_locale_entity.dart',
    },
    'lib/entity/quest_request_items_entity.dart': {
      'QuestRequestItemsEntity': 'lib/entity/quest_request_items_entity.dart',
      'QuestRequestItemsLocaleEntity':
          'lib/entity/quest_request_items_locale_entity.dart',
    },
  };
  for (final entry in plans.entries) {
    final input = File(entry.key);
    final source = input.readAsStringSync();
    final classes = RegExp(r'\bclass\s+(\w+)\s*\{').allMatches(source).toList();
    if (classes.length <= 1) continue;
    final declarations = <String, String>{};
    for (final match in classes) {
      final name = match.group(1)!;
      final open = source.indexOf('{', match.start);
      final close = _matching(source, open, '{', '}');
      declarations[name] = source.substring(match.start, close + 1).trim();
    }
    if (!entry.value.keys.every(declarations.containsKey)) {
      throw FormatException('${entry.key} does not match the split plan');
    }
    final primaryPath = entry.key;
    final primaryClass = entry.value.entries
        .firstWhere((item) => item.value == primaryPath)
        .key;
    final firstClassStart = classes.first.start;
    final prefix = source.substring(0, firstClassStart).trim();
    final exports = entry.value.values
        .where((path) => path != primaryPath)
        .map((path) => "export '${File(path).uri.pathSegments.last}';")
        .join('\n');
    input.writeAsStringSync(
      '$exports\n\n'
      '${prefix.isEmpty ? '' : '$prefix\n\n'}'
      '${declarations[primaryClass]}\n',
    );
    for (final output in entry.value.entries.where(
      (item) => item.value != primaryPath,
    )) {
      File(output.value).writeAsStringSync('${declarations[output.key]}\n');
    }
  }
}

_Migration _inspect(File file) {
  final source = file.readAsStringSync();
  final fileName = file.uri.pathSegments.last;
  final className = _pascal(fileName.substring(0, fileName.length - 5));
  final classMatches = RegExp(r'\bclass\s+(\w+)').allMatches(source).toList();
  if (classMatches.length != 1 || classMatches.single.group(1) != className) {
    throw const FormatException('not exactly one matching Full Entity class');
  }
  if (RegExp(r'^import ', multiLine: true).hasMatch(source)) {
    throw const FormatException(
      'Full Entity has imports or custom value types',
    );
  }

  final classMatch = RegExp('\\bclass\\s+$className\\s*\\{').firstMatch(source);
  if (classMatch == null) {
    throw const FormatException('non-standard class declaration');
  }
  final classOpen = source.indexOf('{', classMatch.start);
  final classClose = _matching(source, classOpen, '{', '}');
  if (source.substring(classClose + 1).trim().isNotEmpty) {
    throw const FormatException('declarations follow Full Entity class');
  }
  final body = source.substring(classOpen + 1, classClose);
  final customGetters = _customGetters(body);
  final constructorStart = body.indexOf('const $className(');
  if (constructorStart < 0) {
    throw const FormatException('missing const unnamed constructor');
  }
  final fieldSection = body.substring(0, constructorStart);
  if (fieldSection.contains('static ') ||
      fieldSection.contains('List<') ||
      fieldSection.contains('Map<') &&
          !fieldSection.contains('Map<String, dynamic>')) {
    throw const FormatException('contains static, collection, or custom state');
  }

  final rawFields = <String, String>{};
  final fieldPattern = RegExp(
    r'^\s*final\s+(int|double|String|bool)(\?)?\s+(\w+);\s*$',
    multiLine: true,
  );
  for (final match in fieldPattern.allMatches(fieldSection)) {
    rawFields[match.group(3)!] = '${match.group(1)}${match.group(2) ?? ''}';
  }
  final finalCount = RegExp(
    r'^\s*final\s+',
    multiLine: true,
  ).allMatches(fieldSection).length;
  if (rawFields.isEmpty || rawFields.length != finalCount) {
    throw const FormatException(
      'contains unsupported or multi-variable fields',
    );
  }

  final defaults = _constructorDefaults(source, className, rawFields.keys);
  final fromJson = _fromJsonArguments(source, className);
  final toJson = _toJsonEntries(source);
  if (fromJson.keys.toSet().length != rawFields.length ||
      toJson.keys.toSet().length != rawFields.length ||
      !rawFields.keys.every(fromJson.containsKey) ||
      !rawFields.keys.every(toJson.containsKey)) {
    throw const FormatException(
      'fromJson/toJson is not a complete row mapping',
    );
  }

  final fields = <_Field>[];
  for (final entry in rawFields.entries) {
    final fromExpression = fromJson[entry.key]!;
    final jsonKeys = RegExp(
      r'''json\s*\[\s*['"]([^'"]+)['"]\s*\]''',
    ).allMatches(fromExpression).map((match) => match.group(1)!).toSet();
    if (jsonKeys.length != 1) {
      throw FormatException('${entry.key} has aliases or a custom converter');
    }
    final toEntry = toJson[entry.key]!;
    final column = toEntry.$1;
    if (jsonKeys.single != column ||
        !RegExp('\\b${RegExp.escape(entry.key)}\\b').hasMatch(toEntry.$2)) {
      throw FormatException('${entry.key} is not a symmetric physical column');
    }
    fields.add(
      _Field(
        name: entry.key,
        type: entry.value,
        defaultSource: defaults[entry.key]!,
        column: column,
      ),
    );
  }

  final base = fileName.substring(0, fileName.length - '_entity.dart'.length);
  final repository = File('lib/repository/${base}_repository.dart');
  if (!repository.existsSync()) {
    throw const FormatException('repository table is unavailable');
  }
  final tableMatch = RegExp(
    r"""static const _table = ['"]([^'"]+)['"];""",
  ).firstMatch(repository.readAsStringSync());
  if (tableMatch == null) {
    throw const FormatException('repository table constant is unavailable');
  }

  final keyFile = File('lib/entity/${base}_key.dart');
  final compositeKeyFields = keyFile.existsSync()
      ? _keyFields(keyFile, className)
      : const <String>[];
  final briefFile = File('lib/entity/brief_${base}_entity.dart');
  final scalarKey = compositeKeyFields.isEmpty && briefFile.existsSync()
      ? _scalarBriefKey(briefFile)
      : null;
  final repositoryKey = compositeKeyFields.isEmpty && scalarKey == null
      ? _repositoryKey(repository, fields)
      : null;
  final keyFields = {
    ...compositeKeyFields,
    if (scalarKey != null) scalarKey,
    if (repositoryKey != null) repositoryKey,
  };
  if (keyFields.isEmpty || !keyFields.every(rawFields.containsKey)) {
    throw const FormatException('persisted identity cannot be proven');
  }

  final brief = briefFile.existsSync()
      ? _inspectBrief(briefFile, className, fields, keyFields)
      : null;
  final filterFile = File('lib/entity/${base}_filter_entity.dart');
  final filter = filterFile.existsSync()
      ? _inspectFilter(filterFile, className, fields)
      : null;

  return _Migration(
    fullFile: file,
    className: className,
    table: tableMatch.group(1)!,
    fields: fields,
    keyFields: keyFields,
    briefFields: brief?.fields.toSet() ?? const {},
    filterFields: {
      if (filter != null)
        for (final name in filter.fields)
          name: _Field(
            name: name,
            type: filter.types[name]!,
            defaultSource: filter.defaults[name]!,
            column: '',
          ),
    },
    briefFile: brief == null ? null : briefFile,
    filterFile: filter == null ? null : filterFile,
    keyFile: compositeKeyFields.length > 1 ? keyFile : null,
    customGetters: customGetters,
    sourcePrefix: source.substring(0, classMatch.start).trim(),
  );
}

_FilterPromotion? _inspectAnnotatedFilter(File fullFile) {
  final source = fullFile.readAsStringSync();
  if (source.contains('@FoxyFilterEntity')) return null;
  final fileName = fullFile.uri.pathSegments.last;
  final base = fileName.substring(0, fileName.length - '_entity.dart'.length);
  final filterFile = File('lib/entity/${base}_filter_entity.dart');
  if (!filterFile.existsSync() ||
      filterFile.readAsStringSync().contains('.filter.g.dart')) {
    return null;
  }
  final className = _pascal(fileName.substring(0, fileName.length - 5));
  final fullFields = <_Field>[];
  final pattern = RegExp(
    r"""@FoxyFullField\('([^']+)'(?:,\s*key:\s*true)?\)\s+"""
    r'final\s+(int|double|String|bool)(\?)?\s+(\w+);',
  );
  final defaults = _constructorDefaults(
    source,
    className,
    pattern.allMatches(source).map((match) => match.group(4)!),
  );
  for (final match in pattern.allMatches(source)) {
    final name = match.group(4)!;
    fullFields.add(
      _Field(
        name: name,
        type: '${match.group(2)}${match.group(3) ?? ''}',
        defaultSource: defaults[name]!,
        column: match.group(1)!,
      ),
    );
  }
  if (fullFields.isEmpty) return null;
  final filter = _inspectFilter(filterFile, className, fullFields);
  if (filter == null) return null;
  return _FilterPromotion(
    fullFile: fullFile,
    filterFile: filterFile,
    fields: {
      for (final name in filter.fields)
        name: _Field(
          name: name,
          type: filter.types[name]!,
          defaultSource: filter.defaults[name]!,
          column: '',
        ),
    },
  );
}

void _applyFilterPromotion(_FilterPromotion promotion) {
  var source = promotion.fullFile.readAsStringSync();
  source = source.replaceFirst(
    '@FoxyFullEntity',
    '@FoxyFilterEntity()\n@FoxyFullEntity',
  );
  for (final field in promotion.fields.values) {
    final declaration = RegExp(
      r'  @FoxyFullField\([^\n]+\)\n'
      '  final [^\\n]+ ${RegExp.escape(field.name)};',
    );
    final match = declaration.firstMatch(source);
    if (match == null) {
      throw FormatException(
        '${promotion.fullFile.path}:${field.name} annotation insertion failed',
      );
    }
    final annotation =
        '  @FoxyFilterField('
        'defaultValue: ${field.defaultSource}, '
        'type: FoxyFilterFieldType.${_filterType(field.type)})\n';
    source = source.replaceRange(
      match.start,
      match.end,
      '$annotation${match.group(0)}',
    );
  }
  promotion.fullFile.writeAsStringSync(source);
  promotion.filterFile.writeAsStringSync(
    "export '${_generatedName(promotion.fullFile, 'filter')}';\n",
  );
}

List<String> _customGetters(String body) {
  final getters = <String>[];
  final pattern = RegExp(
    r'(?:String|int|double|bool)\??\s+get\s+\w+\s*(?:=>|\{)',
  );
  for (final match in pattern.allMatches(body)) {
    final marker = body.substring(match.start, match.end).trimRight();
    if (marker.endsWith('=>')) {
      final end = body.indexOf(';', match.end);
      if (end < 0) {
        throw const FormatException('unterminated custom getter');
      }
      getters.add(body.substring(match.start, end + 1).trim());
    } else {
      final open = body.lastIndexOf('{', match.end);
      final close = _matching(body, open, '{', '}');
      getters.add(body.substring(match.start, close + 1).trim());
    }
  }
  if (getters.length != RegExp(r'\bget\s+\w+').allMatches(body).length) {
    throw const FormatException('contains an unsupported custom getter');
  }
  return getters;
}

Map<String, String> _constructorDefaults(
  String source,
  String className,
  Iterable<String> fields,
) {
  final match = RegExp('const\\s+$className\\s*\\(').firstMatch(source);
  if (match == null) {
    throw const FormatException('missing const unnamed constructor');
  }
  final open = source.indexOf('(', match.start);
  final close = _matching(source, open, '(', ')');
  final parameters = source.substring(open + 1, close).trim();
  if (!parameters.startsWith('{') || !parameters.endsWith('}')) {
    throw const FormatException('constructor is not named-parameter-only');
  }
  final defaults = <String, String>{};
  for (final parameter in _splitTopLevel(
    parameters.substring(1, parameters.length - 1),
  )) {
    final parsed = RegExp(
      r'^\s*this\.(\w+)(?:\s*=\s*(.+))?\s*$',
      dotAll: true,
    ).firstMatch(parameter);
    if (parsed == null) {
      throw const FormatException('constructor parameter is not initializing');
    }
    final name = parsed.group(1)!;
    final value = parsed.group(2);
    if (value == null &&
        !source.contains(RegExp('final\\s+\\w+\\?\\s+$name;'))) {
      throw FormatException('$name has no constant default');
    }
    defaults[name] = value?.trim() ?? 'null';
  }
  if (!fields.every(defaults.containsKey)) {
    throw const FormatException('constructor does not initialize every field');
  }
  return defaults;
}

Map<String, String> _fromJsonArguments(String source, String className) {
  final start = source.indexOf('factory $className.fromJson');
  if (start < 0) {
    throw const FormatException('missing fromJson factory');
  }
  final call = source.indexOf('$className(', start + 'factory '.length);
  if (call < 0) {
    throw const FormatException('fromJson does not construct entity');
  }
  final open = source.indexOf('(', call);
  final close = _matching(source, open, '(', ')');
  return _namedEntries(source.substring(open + 1, close));
}

Map<String, (String, String)> _toJsonEntries(String source) {
  final start = source.indexOf('toJson()');
  if (start < 0) throw const FormatException('missing toJson');
  final arrow = source.indexOf('=>', start);
  final returnMap = source.indexOf(RegExp(r'return\s*\{'), start);
  final assignedMap = source.indexOf(
    RegExp(r'final\s+\w+\s*=\s*<String,\s*dynamic>\s*\{'),
    start,
  );
  final open = arrow >= 0 && (returnMap < 0 || arrow < returnMap)
      ? source.indexOf('{', arrow)
      : returnMap < 0
      ? assignedMap < 0
            ? -1
            : source.indexOf('{', assignedMap)
      : source.indexOf('{', returnMap);
  if (open < 0) {
    throw const FormatException('toJson does not directly return a map');
  }
  final close = _matching(source, open, '{', '}');
  final result = <String, (String, String)>{};
  for (final entry in _splitTopLevel(source.substring(open + 1, close))) {
    final match = RegExp(
      r'''^\s*['"]([^'"]+)['"]\s*:\s*(.+)\s*$''',
      dotAll: true,
    ).firstMatch(entry);
    if (match == null) {
      throw const FormatException('toJson contains a non-literal map entry');
    }
    final expression = match.group(2)!.trim();
    final referenced = RegExp(
      r'\b[a-zA-Z_]\w*\b',
    ).allMatches(expression).map((item) => item.group(0)!).toSet();
    result[referenced.firstWhere(
      (name) => !const {'true', 'false', 'null'}.contains(name),
      orElse: () => '',
    )] = (
      match.group(1)!,
      expression,
    );
  }
  if (result.containsKey('')) {
    throw const FormatException('toJson value does not reference a field');
  }
  return result;
}

Map<String, String> _namedEntries(String source) {
  final result = <String, String>{};
  for (final entry in _splitTopLevel(source)) {
    final match = RegExp(
      r'^\s*(\w+)\s*:\s*(.+)\s*$',
      dotAll: true,
    ).firstMatch(entry);
    if (match == null) {
      throw const FormatException('constructor call contains positional args');
    }
    result[match.group(1)!] = match.group(2)!.trim();
  }
  return result;
}

List<String> _keyFields(File file, String entityClassName) {
  final keyClassName = entityClassName.replaceFirst(RegExp(r'Entity$'), 'Key');
  final source = file.readAsStringSync();
  final match = RegExp(
    '\\b(?:final\\s+)?class\\s+$keyClassName\\s*\\{',
  ).firstMatch(source);
  if (match == null) {
    throw const FormatException('key file lacks the canonical key class');
  }
  final open = source.indexOf('{', match.start);
  final close = _matching(source, open, '{', '}');
  return RegExp(
        r'^\s*final\s+(?:int|double|String|bool)\??\s+(\w+);\s*$',
        multiLine: true,
      )
      .allMatches(source.substring(open + 1, close))
      .map((item) => item.group(1)!)
      .toList();
}

String? _scalarBriefKey(File file) {
  final source = file.readAsStringSync();
  return RegExp(r'\bget\s+key\s*=>\s*(\w+)\s*;').firstMatch(source)?.group(1);
}

String? _repositoryKey(File repository, List<_Field> fields) {
  final source = repository.readAsStringSync();
  final keyColumn = RegExp(
    r"""\.where\(\s*['"]([^'"]+)['"]\s*,\s*(?:originalKey|key)\s*\)""",
  ).firstMatch(source)?.group(1);
  if (keyColumn == null) return null;
  return fields
      .where((field) => field.column == keyColumn)
      .map((field) => field.name)
      .firstOrNull;
}

_Companion? _inspectBrief(
  File file,
  String fullClassName,
  List<_Field> fullFields,
  Set<String> keyFields,
) {
  try {
    final source = file.readAsStringSync();
    final className = 'Brief$fullClassName';
    if (RegExp(r'\bclass\s+').allMatches(source).length != 1 ||
        !source.contains(RegExp('\\bclass\\s+$className\\s*\\{'))) {
      return null;
    }
    final customGetters = RegExp(r'\bget\s+(\w+)')
        .allMatches(source)
        .map((match) => match.group(1)!)
        .where((name) => name != 'key');
    if (customGetters.isNotEmpty) return null;
    final fields = _simpleFields(source);
    final byName = {for (final field in fullFields) field.name: field};
    if (fields.isEmpty ||
        !fields.keys.every(byName.containsKey) ||
        !keyFields.every(fields.containsKey) ||
        fields.entries.any((entry) => byName[entry.key]!.type != entry.value)) {
      return null;
    }
    final defaults = _constructorDefaults(source, className, fields.keys);
    final fromJson = _fromJsonArguments(source, className);
    for (final name in fields.keys) {
      final keys = RegExp(
        r'''json\s*\[\s*['"]([^'"]+)['"]\s*\]''',
      ).allMatches(fromJson[name] ?? '').map((item) => item.group(1)!).toSet();
      if (keys.length != 1 || keys.single != byName[name]!.column) return null;
      if (!_equivalentDefault(defaults[name]!, byName[name]!.defaultSource)) {
        return null;
      }
    }
    return _Companion(
      fields: fields.keys.toList(),
      defaults: defaults,
      types: fields,
    );
  } on FormatException {
    return null;
  }
}

_Companion? _inspectFilter(
  File file,
  String fullClassName,
  List<_Field> fullFields,
) {
  try {
    final source = file.readAsStringSync();
    final className = fullClassName.replaceFirst(
      RegExp(r'Entity$'),
      'FilterEntity',
    );
    if (RegExp(r'\bclass\s+').allMatches(source).length != 1 ||
        !source.contains(RegExp('\\bclass\\s+$className\\s*\\{'))) {
      return null;
    }
    final fields = _simpleFields(source);
    final fullNames = fullFields.map((field) => field.name).toSet();
    if (fields.isEmpty || !fields.keys.every(fullNames.contains)) return null;
    final defaults = _constructorDefaults(source, className, fields.keys);
    if (source.contains('factory $className.fromJson')) {
      final fromJson = _fromJsonArguments(source, className);
      for (final name in fields.keys) {
        final keys = RegExp(r'''json\s*\[\s*['"]([^'"]+)['"]\s*\]''')
            .allMatches(fromJson[name] ?? '')
            .map((item) => item.group(1)!)
            .toSet();
        if (keys.length != 1 || keys.single != name) return null;
      }
    }
    if (source.contains('toJson()')) {
      final toJson = _toJsonEntries(source);
      for (final name in fields.keys) {
        if (toJson[name]?.$1 != name) return null;
      }
    }
    return _Companion(
      fields: fields.keys.toList(),
      defaults: defaults,
      types: fields,
    );
  } on FormatException {
    return null;
  }
}

Map<String, String> _simpleFields(String source) {
  return {
    for (final match in RegExp(
      r'^\s*final\s+(int|double|String|bool)(\?)?\s+(\w+);\s*$',
      multiLine: true,
    ).allMatches(source))
      match.group(3)!: '${match.group(1)}${match.group(2) ?? ''}',
  };
}

bool _equivalentDefault(String left, String right) {
  String normalize(String value) =>
      value.trim().replaceFirst(RegExp(r'^(-?\d+)\.0$'), r'$1');
  return normalize(left) == normalize(right);
}

String _emitFull(_Migration migration) {
  final prefixLines = migration.sourcePrefix.split('\n');
  final exports = prefixLines
      .where((line) => line.trimLeft().startsWith('export '))
      .join('\n');
  final declarationPrefix = prefixLines
      .where((line) => !line.trimLeft().startsWith('export '))
      .join('\n')
      .trim();
  final buffer = StringBuffer()
    ..writeln(
      "import 'package:foxy/infrastructure/codegen/entity_annotations.dart';",
    )
    ..writeln();
  if (exports.isNotEmpty) {
    buffer
      ..writeln(exports)
      ..writeln();
  }
  buffer
    ..writeln("part '${_generatedName(migration.fullFile, 'full')}';")
    ..writeln();
  if (declarationPrefix.isNotEmpty) {
    buffer
      ..writeln(declarationPrefix)
      ..writeln();
  }
  if (migration.briefFile != null) buffer.writeln('@FoxyBriefEntity()');
  if (migration.filterFile != null) buffer.writeln('@FoxyFilterEntity()');
  buffer
    ..writeln("@FoxyFullEntity(table: '${migration.table}')")
    ..writeln(
      'class ${migration.className} with _${migration.className}Mixin {',
    );
  for (final field in migration.fields) {
    if (migration.briefFields.contains(field.name)) {
      buffer.writeln('  @FoxyBriefField()');
    }
    if (migration.filterFields[field.name] case final filter?) {
      buffer.writeln(
        '  @FoxyFilterField('
        'defaultValue: ${filter.defaultSource}, '
        'type: FoxyFilterFieldType.${_filterType(filter.type)})',
      );
    }
    buffer
      ..writeln(
        "  @FoxyFullField('${_escape(field.column)}'"
        '${migration.keyFields.contains(field.name) ? ', key: true' : ''})',
      )
      ..writeln('  final ${field.type} ${field.name};')
      ..writeln();
  }
  buffer.writeln('  const ${migration.className}({');
  for (final field in migration.fields) {
    buffer.writeln(
      field.defaultSource == 'null'
          ? '    this.${field.name},'
          : '    this.${field.name} = ${field.defaultSource},',
    );
  }
  buffer
    ..writeln('  });')
    ..writeln()
    ..writeln(
      '  factory ${migration.className}.fromJson(Map<String, dynamic> json) =>',
    )
    ..writeln('      _${migration.className}Mixin.fromJson(json);');
  for (final getter in migration.customGetters) {
    buffer
      ..writeln()
      ..writeln(getter.split('\n').map((line) => '  $line').join('\n'));
  }
  buffer.writeln('}');
  return buffer.toString();
}

String _generatedName(File file, String kind) {
  final name = file.uri.pathSegments.last;
  return switch (kind) {
    'full' => name.replaceFirst('.dart', '.g.dart'),
    _ => name.replaceFirst('.dart', '.$kind.g.dart'),
  };
}

String _filterType(String type) => switch (type.replaceAll('?', '')) {
  'bool' => 'boolean',
  'double' => 'decimal',
  'int' => 'integer',
  _ => 'text',
};

String _escape(String value) =>
    value.replaceAll(r'\', r'\\').replaceAll("'", r"\'");

String _pascal(String snake) => snake
    .split('_')
    .where((part) => part.isNotEmpty)
    .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
    .join();

int _matching(String source, int open, String left, String right) {
  var depth = 0;
  String? quote;
  var escaped = false;
  for (var index = open; index < source.length; index++) {
    final character = source[index];
    if (quote != null) {
      if (escaped) {
        escaped = false;
      } else if (character == r'\') {
        escaped = true;
      } else if (character == quote) {
        quote = null;
      }
      continue;
    }
    if (character == "'" || character == '"') {
      quote = character;
    } else if (character == left) {
      depth++;
    } else if (character == right && --depth == 0) {
      return index;
    }
  }
  throw const FormatException('unbalanced source');
}

List<String> _splitTopLevel(String source) {
  final result = <String>[];
  var start = 0;
  var round = 0;
  var square = 0;
  var curly = 0;
  String? quote;
  var escaped = false;
  for (var index = 0; index < source.length; index++) {
    final character = source[index];
    if (quote != null) {
      if (escaped) {
        escaped = false;
      } else if (character == r'\') {
        escaped = true;
      } else if (character == quote) {
        quote = null;
      }
      continue;
    }
    if (character == "'" || character == '"') {
      quote = character;
      continue;
    }
    switch (character) {
      case '(':
        round++;
      case ')':
        round--;
      case '[':
        square++;
      case ']':
        square--;
      case '{':
        curly++;
      case '}':
        curly--;
      case ',' when round == 0 && square == 0 && curly == 0:
        result.add(source.substring(start, index));
        start = index + 1;
    }
  }
  final tail = source.substring(start).trim();
  if (tail.isNotEmpty) result.add(tail);
  return result;
}
