import 'form_model.dart';

final class LinkedListGenerationModel {
  /// 手写 Linked List ViewModel 类名,如
  /// `CreatureQuestItemLinkedListViewModel`。
  final String className;

  /// 表单对应的 Full Entity 类名,如 `CreatureQuestItemEntity`。
  final String entityClassName;

  /// 生成的 part mixin 名,如
  /// `_CreatureQuestItemLinkedListViewModelMixin`。
  final String mixinName;

  /// 按 entity 构造参数顺序排列、已排除 exclude 的字段。
  final List<FormFieldModel> fields;

  /// 提供 getBrief/count/create/copy/store/update 的 Repository 类名。
  final String repositoryClassName;

  /// 物理 Key 类型:`int` 或复合 `XxxKey`。
  final String keyType;

  /// 单 key 字段的 dart 名(复合 key 为 null);活动日志用它从候选实体取 key。
  final String? singleKeyFieldName;

  /// 关联字段的 dart 名(Repository 的 `linkKey:` 声明;单关联键形态)。
  final String linkFieldName;

  /// 关联键参数类型(单关联键恒为 int)。
  final String linkKeyType;

  const LinkedListGenerationModel({
    required this.className,
    required this.entityClassName,
    required this.mixinName,
    required this.fields,
    required this.repositoryClassName,
    required this.keyType,
    required this.singleKeyFieldName,
    required this.linkFieldName,
    required this.linkKeyType,
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
