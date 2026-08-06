/// Converts a Dart class name to the conventional snake_case source-file
/// stem.
///
/// `AchievementEntity` → `achievement_entity`；
/// Consecutive capitals split at acronym boundaries:
/// `NPCVendorRepository` → `npc_vendor_repository`.
String toSnakeCase(String value) => value
    .replaceAllMapped(
      RegExp(r'([A-Z]+)([A-Z][a-z])'),
      (match) => '${match[1]}_${match[2]}',
    )
    .replaceAllMapped(
      RegExp(r'([a-z0-9])([A-Z])'),
      (match) => '${match[1]}_${match[2]}',
    )
    .toLowerCase();

/// Derived-entity lowercase parameter name: `TalentEntity` → `talent`.
///
/// A class named exactly `Entity` yields an empty base and must be rejected
/// by callers (it cannot produce a usable identifier).
String entityParameterName(String entityClassName) {
  final base = entityClassName.substring(
    0,
    entityClassName.length - 'Entity'.length,
  );
  if (base.isEmpty) {
    throw ArgumentError.value(
      entityClassName,
      'entityClassName',
      'base name is empty (class named exactly "Entity")',
    );
  }
  final camel = '${base[0].toLowerCase()}${base.substring(1)}';
  // Dart reserved words cannot be parameter names; match the existing
  // `class_` → `class` escape convention used for controller names.
  return _dartKeywords.contains(camel) ? '${camel}_' : camel;
}

/// Dart reserved words that would be invalid parameter identifiers.
const _dartKeywords = <String>{
  'abstract', 'as', 'assert', 'async', 'await', 'break', 'case', 'catch',
  'class', 'const', 'continue', 'covariant', 'default', 'deferred', 'do',
  'dynamic', 'else', 'enum', 'export', 'extends', 'extension', 'external',
  'factory', 'false', 'final', 'finally', 'for', 'function', 'get', 'hide',
  'if', 'implements', 'import', 'in', 'interface', 'is', 'late', 'library',
  'mixin', 'new', 'null', 'on', 'operator', 'part', 'required', 'rethrow',
  'return', 'sealed', 'set', 'show', 'static', 'super', 'switch', 'sync',
  'this', 'throw', 'true', 'try', 'typedef', 'var', 'void', 'while', 'with',
  'yield',
};

/// Plural suffix for list methods: `GemProperty` → `GemProperties`.
///
/// Matches the hand-written repositories' `getBrief*/count*` naming:
/// consonant + y endings change y → ies (`GemPropertys` is a misspelling),
/// everything else just gets an s.
String pluralize(String name) {
  if (name.length >= 2 &&
      name.endsWith('y') &&
      !_isVowel(name[name.length - 2])) {
    return '${name.substring(0, name.length - 1)}ies';
  }
  return '${name}s';
}

bool _isVowel(String char) => 'aeiou'.contains(char.toLowerCase());
