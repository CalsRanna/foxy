// ignore_for_file: depend_on_referenced_packages, experimental_member_use

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'collection_editor_model.dart';
import 'form_reader.dart';

const _fullFieldChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/entity_annotations.dart#FoxyFullField',
);
const _repositoryChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/repository_annotations.dart#FoxyRepository',
);

final class CollectionEditorReader {
  const CollectionEditorReader();

  Future<CollectionEditorGenerationModel> read(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    // controller 样板与 FoxyDetailViewModel 完全同构:复用 FormReader。
    final form = await const FormReader().read(element, annotation, buildStep);

    final repositoryType = annotation.read('repository').typeValue;
    if (repositoryType is! InterfaceType) {
      _fail(
        '${form.className} 的 @FoxyCollectionEditorViewModel repository '
            '参数不是 Repository class。',
        element,
        '传入具体的 Repository 类型。',
      );
    }
    final repositoryElement = repositoryType.element;
    final repositoryClassName = repositoryElement.name!;
    if (!repositoryClassName.endsWith('Repository')) {
      _fail(
        '${form.className} 绑定的 Repository 必须以 Repository 结尾。',
        element,
        '传入具体的 Repository 类型。',
      );
    }
    final repositoryAnnotations = _repositoryChecker
        .annotationsOf(repositoryElement)
        .toList();
    if (repositoryAnnotations.length != 1) {
      _fail(
        '$repositoryClassName 必须且只能声明一个 @FoxyRepository。',
        repositoryElement,
        '只绑定生成型 Repository。',
      );
    }
    final parentKeyValues = ConstantReader(
      repositoryAnnotations.single,
    ).read('parentKey').listValue;
    if (parentKeyValues.length != 1) {
      _fail(
        '$repositoryClassName 的 @FoxyRepository 必须声明且只能声明一个 '
            'parentKey(当前 ${parentKeyValues.length} 个),'
            '才能生成 Collection Editor 骨架。',
        element,
        '单父键子表使用本注解;复合父键子表(如 player_create_info 系列)'
            '保持手写 Collection Editor。',
      );
    }
    final parentFieldName = parentKeyValues.single.toStringValue()!;

    final entityType = annotation.read('entity').typeValue;
    if (entityType is! InterfaceType) {
      _fail(
        '${form.className} 的 @FoxyCollectionEditorViewModel entity '
            '参数不是 Entity class。',
        element,
        '传入具体的 Full Entity 类型。',
      );
    }
    final entityElement = entityType.element;

    // 校验 parentKey 字段确实存在于实体且为 int,并推断完整 key 类型。
    final keyFieldTypes = <String>[];
    String? parentFieldType;
    for (final field in entityElement.fields.where(
      (field) => !field.isStatic && !field.isSynthetic,
    )) {
      final annotations = _fullFieldChecker.annotationsOf(field).toList();
      if (annotations.length != 1) continue;
      if (!(ConstantReader(annotations.single).peek('key')?.boolValue ??
          false)) {
        continue;
      }
      keyFieldTypes.add(field.type.getDisplayString());
      if (field.name == parentFieldName) {
        parentFieldType = field.type.getDisplayString();
      }
    }
    if (parentFieldType == null || parentFieldType != 'int') {
      _fail(
        '$repositoryClassName 的 parentKey: \'$parentFieldName\' 不是 '
            '${form.entityClassName} 的 int key 字段。',
        element,
        'parentKey 必须指向实体的 int 类型 key 字段。',
      );
    }
    if (keyFieldTypes.isEmpty) {
      _fail(
        '${form.entityClassName} 没有可用于编辑器操作的物理 Key。',
        element,
        '在至少一个 @FoxyFullField 上设置 key: true。',
      );
    }

    return CollectionEditorGenerationModel(
      className: form.className,
      entityClassName: form.entityClassName,
      mixinName: form.mixinName,
      fields: form.fields,
      repositoryClassName: repositoryClassName,
      keyType: keyFieldTypes.length == 1
          ? keyFieldTypes.single
          : '${form.baseName}Key',
      parentFieldName: parentFieldName,
      parentKeyType: parentFieldType,
    );
  }

  Never _fail(String message, Element element, String correction) {
    throw InvalidGenerationSourceError(
      '$message\n修复方式：$correction',
      element: element,
    );
  }
}
