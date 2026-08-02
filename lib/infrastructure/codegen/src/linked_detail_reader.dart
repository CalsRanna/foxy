// ignore_for_file: depend_on_referenced_packages, experimental_member_use

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'form_reader.dart';
import 'linked_detail_model.dart';

const _repositoryChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/repository_annotations.dart#FoxyRepository',
);

final class LinkedDetailReader {
  const LinkedDetailReader();

  Future<LinkedDetailGenerationModel> read(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    // controller 样板与 FoxyDetailViewModel 完全同构:复用 FormReader。
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
