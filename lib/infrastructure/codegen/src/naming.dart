/// 把 Dart 类名转换成约定的 snake_case 源文件名主干。
///
/// `AchievementEntity` → `achievement_entity`；
/// 连续大写按缩写切分：`NPCVendorRepository` → `npc_vendor_repository`。
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

/// 列表方法的复数后缀：`GemProperty` → `GemProperties`。
///
/// 与手写仓库的 `getBrief*/count*` 命名一致：辅音 + y 结尾按
/// y → ies（`GemPropertys` 是错误拼写），其余直接加 s。
String pluralize(String name) {
  if (name.length >= 2 &&
      name.endsWith('y') &&
      !_isVowel(name[name.length - 2])) {
    return '${name.substring(0, name.length - 1)}ies';
  }
  return '${name}s';
}

bool _isVowel(String char) => 'aeiou'.contains(char.toLowerCase());
