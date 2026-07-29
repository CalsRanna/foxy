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
