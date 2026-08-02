import 'form_model.dart';

final class LinkedDetailGenerationModel {
  /// 手写 Linked Detail ViewModel 类名,如
  /// `CreatureTemplateAddonLinkedDetailViewModel`。
  final String className;

  /// 表单对应的 Full Entity 类名,如 `CreatureTemplateAddonEntity`。
  final String entityClassName;

  /// 生成的 part mixin 名,如
  /// `_CreatureTemplateAddonLinkedDetailViewModelMixin`。
  final String mixinName;

  /// 按 entity 构造参数顺序排列、已排除 exclude 的字段。
  final List<FormFieldModel> fields;

  /// 提供 get/store/update/destroy/create 的 Repository 类名。
  final String repositoryClassName;

  /// 物理 Key 类型(单关联键形态恒为 int)。
  final String keyType;

  /// 单 key 字段的 dart 名;persist 用它写回 editingKey,`_refresh` 的
  /// get-or-create 以关联键(即主键)加载。
  final String singleKeyFieldName;

  const LinkedDetailGenerationModel({
    required this.className,
    required this.entityClassName,
    required this.mixinName,
    required this.fields,
    required this.repositoryClassName,
    required this.keyType,
    required this.singleKeyFieldName,
  });

  String get baseName =>
      entityClassName.substring(0, entityClassName.length - 'Entity'.length);
}
