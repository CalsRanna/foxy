/// 列表筛选字段(全部来自 repository 的 `@FoxyFilter.text`)。
final class ListFilterFieldModel {
  final String name;

  const ListFilterFieldModel({required this.name});

  /// controller 标识:`class_` → `class`(保留字转义,与 FormEmitter 一致)。
  String get controllerName =>
      name.endsWith('_') ? name.substring(0, name.length - 1) : name;
}

final class ListGenerationModel {
  /// 手写 List ViewModel 类名,如 `CreatureTemplateListViewModel`。
  final String className;

  /// 列表对应的 Full Entity 类名,如 `CreatureTemplateEntity`。
  final String entityClassName;

  /// 列表页展示的 Brief Entity 类名,如 `BriefCreatureTemplateEntity`。
  final String briefEntityClassName;

  /// 提供列表方法的 Repository 类名。
  final String repositoryClassName;

  /// 生成的 part mixin 名,如 `_CreatureTemplateListViewModelMixin`。
  final String mixinName;

  /// 按 repository `@FoxyFilter` 声明顺序排列的 text 筛选字段。
  final List<ListFilterFieldModel> fields;

  /// repository 中返回 Brief 列表的实例方法名(命名约定,见 ListReader)。
  final String getBriefMethodName;

  /// repository 中统计总数的实例方法名。
  final String countMethodName;

  /// repository 中复制记录的方法名(查询层全量生成,恒存在)。
  final String copyMethodName;

  /// 物理 Key 类型:`int` 或复合 `XxxKey`(来自 entity key 字段)。
  final String keyType;

  const ListGenerationModel({
    required this.className,
    required this.entityClassName,
    required this.briefEntityClassName,
    required this.repositoryClassName,
    required this.mixinName,
    required this.fields,
    required this.getBriefMethodName,
    required this.countMethodName,
    required this.copyMethodName,
    required this.keyType,
  });

  /// `CreatureTemplateEntity` → `creatureTemplate`(与 Repository 的实体参数
  /// 命名一致,用作 log 相关与提示文案的实体名)。
  String get entityCamelName {
    final base = entityClassName.substring(
      0,
      entityClassName.length - 'Entity'.length,
    );
    return '${base[0].toLowerCase()}${base.substring(1)}';
  }

  /// Filter 类名:`CreatureTemplateRepository` → `CreatureTemplateFilter`。
  String get filterClassName =>
      '${repositoryClassName.substring(0, repositoryClassName.length - 'Repository'.length)}Filter';

  /// 空实现钩子的参数类型:key 是 int 时 `int key`,否则 `XxxKey key`。
  String get keyParameter => keyType == 'int' ? 'int key' : '$keyType key';
}
