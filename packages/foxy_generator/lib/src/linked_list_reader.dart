// ignore_for_file: depend_on_referenced_packages, deprecated_member_use, experimental_member_use

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:foxy_generator/src/convention.dart';
import 'package:foxy_generator/src/entity_resolver.dart';
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

    final entityElement = (await resolveFullEntity(
      buildStep,
      element,
      form.entityClassName,
      "${form.className}'s @FoxyLinkedListViewModel",
    )).entityElement;

    // Bound repository: explicit `repository:` wins; otherwise derived from
    // the class name.
    final declaredRepository = annotation.peek('repository');
    String repositoryClassName;
    if (declaredRepository != null && !declaredRepository.isNull) {
      final repositoryType = declaredRepository.typeValue;
      if (repositoryType is! InterfaceType) {
        _fail(
          "The repository parameter of ${form.className}'s "
              '@FoxyLinkedListViewModel is not a Repository class.',
          element,
          'Pass a concrete Repository type.',
        );
      }
      repositoryClassName = repositoryType.element.name!;
      if (!repositoryClassName.endsWith('Repository')) {
        _fail(
          'The Repository bound by ${form.className} must end in '
              'Repository.',
          element,
          'Pass a concrete Repository type.',
        );
      }
    } else {
      repositoryClassName = repositoryClassNameOfViewModel(form.className) ??
          _fail(
            '${form.className} cannot derive a repository class name.',
            element,
            'Use a class name ending in LinkedListViewModel.',
          );
    }
    final repositoryElement = await resolveClass(
      buildStep,
      element,
      repositoryClassName,
      'repository',
      "${form.className}'s @FoxyLinkedListViewModel",
    );
    final repositoryAnnotations = _repositoryChecker
        .annotationsOf(repositoryElement)
        .toList();
    if (repositoryAnnotations.length != 1) {
      _fail(
        '$repositoryClassName must declare exactly one @FoxyRepository.',
        repositoryElement,
        'Bind to a generated Repository.',
      );
    }
    final linkKeyValues = ConstantReader(
      repositoryAnnotations.single,
    ).read('linkKey').listValue;
    if (linkKeyValues.length != 1) {
      _fail(
        "$repositoryClassName's @FoxyRepository must declare exactly one "
            'linkKey (currently ${linkKeyValues.length}) to generate the '
            'Linked List skeleton.',
        element,
        'Use this annotation for single-link-key subtables; keep Linked '
            'List hand-written for composite-link-key subtables '
            '(e.g. the player_create_info series).',
      );
    }
    final linkFieldName = linkKeyValues.single.toStringValue()!;

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
        "The linkKey: '$linkFieldName' of $repositoryClassName is not an "
            'int key field of ${form.entityClassName}.',
        element,
        'linkKey must point to an int-typed key field of the entity.',
      );
    }
    if (keyFieldTypes.isEmpty) {
      _fail(
        '${form.entityClassName} has no physical key usable for editor '
            'operations.',
        element,
        'Set key: true on at least one @FoxyFullField.',
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
      logNameFields: List.unmodifiable(logNameFieldsOf(entityElement)),
    );
  }

  Never _fail(String message, Element element, String correction) {
    throw InvalidGenerationSourceError(
      '$message\nFix: $correction',
      element: element,
    );
  }
}
