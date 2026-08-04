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
