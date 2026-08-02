import 'form_model.dart';

final class CollectionEditorGenerationModel {
  /// 手写 Collection Editor ViewModel 类名,如
  /// `CreatureQuestItemCollectionEditorViewModel`。
  final String className;

  /// 表单对应的 Full Entity 类名,如 `CreatureQuestItemEntity`。
  final String entityClassName;

  /// 生成的 part mixin 名,如
  /// `_CreatureQuestItemCollectionEditorViewModelMixin`。
  final String mixinName;

  /// 按 entity 构造参数顺序排列、已排除 exclude 的字段。
  final List<FormFieldModel> fields;

  /// 提供 getBrief/count/create/copy/store/update 的 Repository 类名。
  final String repositoryClassName;

  /// 物理 Key 类型:`int` 或复合 `XxxKey`。
  final String keyType;

  /// 父键字段的 dart 名(Repository 的 `parentKey:` 声明;单父键形态)。
  final String parentFieldName;

  /// 父键参数类型(单父键恒为 int)。
  final String parentKeyType;

  const CollectionEditorGenerationModel({
    required this.className,
    required this.entityClassName,
    required this.mixinName,
    required this.fields,
    required this.repositoryClassName,
    required this.keyType,
    required this.parentFieldName,
    required this.parentKeyType,
  });

  String get baseName =>
      entityClassName.substring(0, entityClassName.length - 'Entity'.length);

  String get briefEntityClassName => 'Brief${baseName}Entity';

  /// `CreatureQuestItemEntity` → `creatureQuestItem`。
  String get entityCamelName {
    final base = baseName;
    return '${base[0].toLowerCase()}${base.substring(1)}';
  }
}
