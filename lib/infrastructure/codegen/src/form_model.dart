/// 表单字段的 controller 意图。
enum FormFieldKind {
  /// 按字段 Dart 类型推断(Int/Double/String/Bool)。
  plain,

  /// `SelectFieldController`。
  select,

  /// `FlagFieldController`。
  flag,

  /// `IntFieldControllerGroup`(动态字段编辑)。
  group,

  /// `NullableStringFieldController`。
  nullable,
}

final class FormFieldModel {
  /// entity 字段名(collect/apply 的命名参数名;也是 controller 名的来源)。
  final String dartName;

  final String dartType;
  final FormFieldKind kind;

  /// `kind == select` 时的 fallback 值(int 或 String)。
  final Object? selectFallback;

  const FormFieldModel({
    required this.dartName,
    required this.dartType,
    required this.kind,
    this.selectFallback,
  });
}

final class FormGenerationModel {
  /// 手写 Detail ViewModel 类名,如 `TalentDetailViewModel`。
  final String className;

  /// 表单对应的 Full Entity 类名,如 `TalentEntity`。
  final String entityClassName;

  /// 生成的 part mixin 名,如 `_TalentDetailViewModelMixin`。
  final String mixinName;

  /// 按 entity 构造参数顺序排列、已排除 exclude 的字段。
  final List<FormFieldModel> fields;

  const FormGenerationModel({
    required this.className,
    required this.entityClassName,
    required this.mixinName,
    required this.fields,
  });
}
