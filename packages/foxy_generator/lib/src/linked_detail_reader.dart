// ignore_for_file: depend_on_referenced_packages, experimental_member_use

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:foxy_generator/src/form_reader.dart';
import 'package:foxy_generator/src/linked_detail_model.dart';

const _repositoryChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/repository_annotations.dart#FoxyRepository',
);

final class LinkedDetailReader {
  const LinkedDetailReader();

  Future<LinkedDetailGenerationModel> read(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    // Controller boilerplate is fully isomorphic with FoxyDetailViewModel:
    // reuse FormReader.
    final form = await const FormReader().read(element, annotation, buildStep);
    if (form.repositoryClassName.isEmpty) {
      _fail(
        '${form.className} 的 @FoxyLinkedDetailViewModel 缺少 repository 参数。',
        element,
        '传入具体的 Repository 类型。',
      );
    }
    final repositoryType = annotation.read('repository').typeValue;
    if (repositoryType is! InterfaceType) {
      _fail(
        '${form.className} 的 @FoxyLinkedDetailViewModel repository '
            '参数不是 Repository class。',
        element,
        '传入具体的 Repository 类型。',
      );
    }
    final repositoryElement = repositoryType.element;
    final repositoryClassName = repositoryElement.name!;
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
    final singleKeyFieldName = form.singleKeyFieldName;
    if (singleKeyFieldName == null) {
      _fail(
        '${form.entityClassName} 是复合键实体，不能生成 Linked Detail 骨架。',
        element,
        '复合键的一对一表单保持手写。',
      );
    }

    // Handshake with the bound Repository: the get-or-create skeleton calls
    // `getXxx(linkKey)` (by primary key) and `createXxx(linkKey)`. When the
    // repository declares linkKey it must be exactly the entity's single key
    // field — otherwise the generated code would query by the wrong column
    // and silently mismatch. When it declares *no* linkKey, the repository
    // supplies its own hand-written create (a compile-time contract), which
    // is the safe fallback.
    final repositoryAnnotation = ConstantReader(repositoryAnnotations.single);
    final declaredLinkKeys = <String>[];
    final linkKeyReader = repositoryAnnotation.peek('linkKey');
    if (linkKeyReader != null && !linkKeyReader.isNull) {
      // `isList` guards the type before `listValue` (which throws a raw
      // StateError on a non-List like `linkKey: 'entry'`). An unset
      // optional list field surfaces as an *empty* list.
      final list = linkKeyReader.isList ? linkKeyReader.listValue : null;
      if (list == null || list.any((value) => value.toStringValue() == null)) {
        _fail(
          '$repositoryClassName 的 @FoxyRepository linkKey 必须是 '
              'String 列表。',
          repositoryElement,
          'linkKey 使用字符串字面量列表，例如 linkKey: [\'entry\']。',
        );
      }
      declaredLinkKeys.addAll(list.map((value) => value.toStringValue()!));
    }
    if (declaredLinkKeys.length > 1) {
      _fail(
        '$repositoryClassName 声明了多个 linkKey（$declaredLinkKeys），'
            'Linked Detail 只支持单一 linkKey。',
        repositoryElement,
        'Linked Detail 绑定单主键实体，linkKey 只声明一个。',
      );
    }
    if (declaredLinkKeys.length == 1 &&
        declaredLinkKeys.single != singleKeyFieldName) {
      _fail(
        '$repositoryClassName 的 linkKey（${declaredLinkKeys.single}）'
            '必须等于实体主键 $singleKeyFieldName。',
        repositoryElement,
        '给 @FoxyRepository 声明 linkKey: [\'$singleKeyFieldName\']，'
            '或移除 linkKey 并手写 create 方法。',
      );
    }

    return LinkedDetailGenerationModel(
      className: form.className,
      entityClassName: form.entityClassName,
      mixinName: form.mixinName,
      fields: form.fields,
      repositoryClassName: repositoryClassName,
      keyType: form.keyType,
      singleKeyFieldName: singleKeyFieldName,
    );
  }

  Never _fail(String message, Element element, String correction) {
    throw InvalidGenerationSourceError(
      '$message\n修复方式：$correction',
      element: element,
    );
  }
}
