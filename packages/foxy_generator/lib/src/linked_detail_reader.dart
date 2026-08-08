// ignore_for_file: depend_on_referenced_packages, experimental_member_use

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:foxy_generator/src/convention.dart';
import 'package:foxy_generator/src/entity_resolver.dart';
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

    // Bound repository: explicit `repository:` wins; otherwise derived from
    // the class name.
    final declaredRepository = annotation.peek('repository');
    String repositoryClassName;
    if (declaredRepository != null && !declaredRepository.isNull) {
      final repositoryType = declaredRepository.typeValue;
      if (repositoryType is! InterfaceType) {
        _fail(
          "The repository parameter of ${form.className}'s "
              '@FoxyLinkedDetailViewModel is not a Repository class.',
          element,
          'Pass a concrete Repository type.',
        );
      }
      repositoryClassName = repositoryType.element.name!;
    } else {
      repositoryClassName = repositoryClassNameOfViewModel(form.className) ??
          _fail(
            '${form.className} cannot derive a repository class name.',
            element,
            'Use a class name ending in LinkedDetailViewModel.',
          );
    }
    final repositoryElement = await resolveClass(
      buildStep,
      element,
      repositoryClassName,
      'repository',
      "${form.className}'s @FoxyLinkedDetailViewModel",
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
    final singleKeyFieldName = form.singleKeyFieldName;
    if (singleKeyFieldName == null) {
      _fail(
        '${form.entityClassName} is a composite-key entity; a Linked '
            'Detail skeleton cannot be generated.',
        element,
        'Keep the one-to-one form hand-written for composite-key entities.',
      );
    }

    final entityElement = (await resolveFullEntity(
      buildStep,
      element,
      form.entityClassName,
      "${form.className}'s @FoxyLinkedDetailViewModel",
    )).entityElement;

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
          "The linkKey of $repositoryClassName's @FoxyRepository must be "
              'a list of Strings.',
          repositoryElement,
          'Declare linkKey as a list of string literals, e.g. '
              "linkKey: ['entry'].",
        );
      }
      declaredLinkKeys.addAll(list.map((value) => value.toStringValue()!));
    }
    if (declaredLinkKeys.length > 1) {
      _fail(
        '$repositoryClassName declares multiple linkKeys '
            '($declaredLinkKeys); Linked Detail supports only a single '
            'linkKey.',
        repositoryElement,
        'Bind Linked Detail to a single-primary-key entity and declare '
            'only one linkKey.',
      );
    }
    if (declaredLinkKeys.length == 1 &&
        declaredLinkKeys.single != singleKeyFieldName) {
      _fail(
        "The linkKey (${declaredLinkKeys.single}) of $repositoryClassName "
            'must equal the entity primary key $singleKeyFieldName.',
        repositoryElement,
        "Declare linkKey: ['$singleKeyFieldName'] on @FoxyRepository, "
            'or remove linkKey and hand-write the create method.',
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
