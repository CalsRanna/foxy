// ignore_for_file: depend_on_referenced_packages, experimental_member_use

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:foxy_generator/src/form_reader.dart';
import 'package:foxy_generator/src/linked_list_model.dart';

const _fullFieldChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyFullField',
);
const _repositoryChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/repository_annotations.dart#FoxyRepository',
);

final class LinkedListReader {
  const LinkedListReader();

  Future<LinkedListGenerationModel> read(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    // Controller boilerplate is fully isomorphic with FoxyDetailViewModel:
    // reuse FormReader.
    final form = await const FormReader().read(element, annotation, buildStep);

    final repositoryType = annotation.read('repository').typeValue;
    if (repositoryType is! InterfaceType) {
      _fail(
        '${form.className} 的 @FoxyLinkedListViewModel repository '
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
    final linkKeyValues = ConstantReader(
      repositoryAnnotations.single,
    ).read('linkKey').listValue;
    if (linkKeyValues.length != 1) {
      _fail(
        '$repositoryClassName 的 @FoxyRepository 必须声明且只能声明一个 '
            'linkKey(当前 ${linkKeyValues.length} 个),'
            '才能生成 Linked List 骨架。',
        element,
        '单关联键子表使用本注解;复合关联键子表(如 player_create_info 系列)'
            '保持手写 Linked List。',
      );
    }
    final linkFieldName = linkKeyValues.single.toStringValue()!;

    final entityType = annotation.read('entity').typeValue;
    if (entityType is! InterfaceType) {
      _fail(
        '${form.className} 的 @FoxyLinkedListViewModel entity '
            '参数不是 Entity class。',
        element,
        '传入具体的 Full Entity 类型。',
      );
    }
    final entityElement = entityType.element;

    // Validate that the linkKey field actually exists on the entity and is
    // an int, and infer the full key type.
    final keyFieldTypes = <String>[];
    final keyFieldNames = <String>[];
    String? linkFieldType;
    for (final field in entityElement.fields.where(
      (field) => !field.isStatic && !field.isSynthetic,
    )) {
      final annotations = _fullFieldChecker.annotationsOf(field).toList();
      if (annotations.length != 1) continue;
      if (!(ConstantReader(annotations.single).peek('key')?.boolValue ??
          false)) {
        continue;
      }
      final keyFieldName = field.name;
      if (keyFieldName == null) continue;
      keyFieldTypes.add(field.type.getDisplayString());
      keyFieldNames.add(keyFieldName);
      if (keyFieldName == linkFieldName) {
        linkFieldType = field.type.getDisplayString();
      }
    }
    if (linkFieldType == null || linkFieldType != 'int') {
      _fail(
        '$repositoryClassName 的 linkKey: \'$linkFieldName\' 不是 '
            '${form.entityClassName} 的 int key 字段。',
        element,
        'linkKey 必须指向实体的 int 类型 key 字段。',
      );
    }
    if (keyFieldTypes.isEmpty) {
      _fail(
        '${form.entityClassName} 没有可用于编辑器操作的物理 Key。',
        element,
        '在至少一个 @FoxyFullField 上设置 key: true。',
      );
    }

    return LinkedListGenerationModel(
      className: form.className,
      entityClassName: form.entityClassName,
      mixinName: form.mixinName,
      fields: form.fields,
      repositoryClassName: repositoryClassName,
      keyType: keyFieldTypes.length == 1
          ? keyFieldTypes.single
          : '${form.baseName}Key',
      singleKeyFieldName:
          keyFieldTypes.length == 1 ? keyFieldNames.single : null,
      linkFieldName: linkFieldName,
      linkKeyType: linkFieldType,
      table: form.table,
    );
  }

  Never _fail(String message, Element element, String correction) {
    throw InvalidGenerationSourceError(
      '$message\n修复方式：$correction',
      element: element,
    );
  }
}
