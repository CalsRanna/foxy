// ignore_for_file: depend_on_referenced_packages, deprecated_member_use, experimental_member_use

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:foxy_generator/src/convention.dart';
import 'package:foxy_generator/src/entity_resolver.dart';
import 'package:foxy_generator/src/naming.dart';
import 'package:foxy_generator/src/repository_filter_model.dart';
import 'package:foxy_generator/src/repository_filter_reader.dart';
import 'package:foxy_generator/src/repository_model.dart';

const _briefEntityChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyBriefEntity',
);
const _briefFieldChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyBriefField',
);
const _filterChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/repository_annotations.dart#FoxyFilter',
);
const _fullFieldChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyFullField',
);

final class RepositoryReader {
  const RepositoryReader();

  Future<RepositoryGenerationModel> read(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      _fail(
        '@FoxyRepository can only annotate a Repository class.',
        element,
        'Move the annotation to a concrete Repository class.',
      );
    }
    final repositoryClassName = element.name;
    if (repositoryClassName == null ||
        !repositoryClassName.endsWith('Repository')) {
      _fail(
        '@FoxyRepository can only annotate a class ending in Repository.',
        element,
        'Use a concrete Repository class.',
      );
    }

    final inputFileName = buildStep.inputId.pathSegments.last;
    final expectedFileName = '${toSnakeCase(repositoryClassName)}.dart';
    if (inputFileName != expectedFileName) {
      _fail(
        '$repositoryClassName must be in $expectedFileName; current file '
            'is $inputFileName.',
        element,
        'Keep the Repository class name consistent with the file name.',
      );
    }

    // Bound entity: explicit `@FoxyRepository(XxxEntity)` wins; otherwise
    // derived from the class name (`XxxRepository` → `XxxEntity`).
    final declaredEntity = annotation.peek('entity');
    String entityClassName;
    if (declaredEntity != null && !declaredEntity.isNull) {
      final entityType = declaredEntity.typeValue;
      if (entityType is! InterfaceType) {
        _fail(
          "$repositoryClassName's @FoxyRepository entity parameter is not "
              'an Entity class.',
          element,
          'Pass a concrete Full Entity type.',
        );
      }
      entityClassName = entityType.element.name!;
      if (!entityClassName.endsWith('Entity')) {
        _fail(
          "The type bound by $repositoryClassName must end in Entity.",
          element,
          'Pass a concrete Full Entity type.',
        );
      }
      final expectedRepositoryClassName =
          '${stripSuffix(entityClassName, 'Entity')}Repository';
      if (repositoryClassName != expectedRepositoryClassName) {
        _fail(
          '$repositoryClassName and $entityClassName do not follow the '
              'one-to-one naming convention.',
          element,
          'Use the same base name for the Repository and the Entity.',
        );
      }
    } else {
      entityClassName = entityClassNameOfRepository(repositoryClassName);
      if (entityClassName == 'Entity') {
        _fail(
          '$repositoryClassName cannot derive an entity name (the class '
              'name is exactly "Repository").',
          element,
          'Use a Repository class name with a meaningful prefix.',
        );
      }
    }

    final resolved = await resolveFullEntity(
      buildStep,
      element,
      entityClassName,
      "$repositoryClassName's @FoxyRepository",
    );
    final entityElement = resolved.entityElement;
    final table = resolved.table;

    final baseName = stripSuffix(entityClassName, 'Entity');
    if (baseName.isEmpty) {
      _fail(
        "$entityClassName's base name is empty (the class name is exactly "
            '"Entity").',
        element,
        'Use an Entity class name with a meaningful prefix.',
      );
    }
    final entityParameter = entityParameterName(entityClassName);

    // The query layer (create/copy/getBrief/count/_applyFilter) is generated
    // for two kinds of repositories: main-table ones with a list page, and
    // child-table ones declaring linkKey (detail-page tabs).
    //
    // Presence is a *shape* check, not just file existence: a stale or
    // placeholder list-VM file (e.g. one whose annotation was removed)
    // must not silently enable/disable the generated query layer.
    final listViewModelAssetId = AssetId(
      buildStep.inputId.package,
      'lib/view_model/${toSnakeCase(baseName)}_list_view_model.dart',
    );
    final listViewModelPresent = await buildStep.canRead(
      listViewModelAssetId,
    ) &&
        (await buildStep.readAsString(listViewModelAssetId)).contains(
          '@FoxyListViewModel',
        );
    final declaredLinkKeys = <String>[];
    final linkKeyReader = annotation.peek('linkKey');
    if (linkKeyReader != null && !linkKeyReader.isNull) {
      // `isList` guards the type before `listValue` (which throws a raw
      // StateError on a non-List like `linkKey: 'race'`). An unset optional
      // list field surfaces as an *empty* list, so only element types are
      // validated; an empty list means "no link key".
      final list = linkKeyReader.isList ? linkKeyReader.listValue : null;
      if (list == null || list.any((value) => value.toStringValue() == null)) {
        _fail(
          "$repositoryClassName's @FoxyRepository linkKey must be a "
              'List<String>.',
          element,
          'linkKey: [\'fieldName\'].',
        );
      }
      declaredLinkKeys.addAll(list.map((value) => value.toStringValue()!));
    }
    final queryLayerEnabled =
        listViewModelPresent || declaredLinkKeys.isNotEmpty;

    final keyFields = <RepositoryKeyFieldModel>[];
    final briefProjectionColumns = <String>[];
    // Filter name → physical column name of the entity field with the same
    // name.
    final fieldColumnByName = <String, String>{};
    for (final field in entityElement.fields.where(
      (field) => !field.isStatic && !field.isSynthetic,
    )) {
      final annotations = _fullFieldChecker.annotationsOf(field).toList();
      if (annotations.length != 1) continue;
      final fieldAnnotation = ConstantReader(annotations.single);
      final columnName = fieldAnnotation.read('name').stringValue;
      fieldColumnByName[field.name!] = columnName;
      final isKey = fieldAnnotation.peek('key')?.boolValue ?? false;
      if (isKey) {
        final dartType = field.type.getDisplayString();
        if (dartType.endsWith('?')) {
          _fail(
            '$entityClassName.${field.name} is nullable and cannot serve '
                'as the physical Key for generated CRUD.',
            field,
            'In SQL, `column = NULL` never holds; the generated _whereKey '
                'would silently match 0 rows and falsely report "original '
                'record not found". Make the column non-nullable, or keep '
                'this Repository hand-written and use `<=>` for NULL-safe '
                'comparison.',
          );
        }
        keyFields.add(
          RepositoryKeyFieldModel(
            columnName: columnName,
            dartName: field.name!,
            dartType: dartType,
          ),
        );
      }
      if (_isPhysicalBriefField(field)) {
        briefProjectionColumns.add(columnName);
      }
    }
    if (keyFields.isEmpty) {
      _fail(
        '$entityClassName has no physical Key usable by the Repository.',
        entityElement,
        'Set key: true on at least one @FoxyFullField.',
      );
    }
    final linkKeyFields = <RepositoryKeyFieldModel>[];
    for (final declared in declaredLinkKeys) {
      RepositoryKeyFieldModel? matched;
      for (final field in keyFields) {
        if (field.dartName == declared) {
          matched = field;
          break;
        }
      }
      if (matched == null) {
        _fail(
          "$repositoryClassName's linkKey: '$declared' is not a key field "
              'of $entityClassName.',
          element,
          'linkKey must be the name of a field annotated '
              '@FoxyFullField(key: true) on the entity.',
        );
      }
      linkKeyFields.add(matched);
    }
    if (queryLayerEnabled) {
      final briefAnnotations = _briefEntityChecker
          .annotationsOf(entityElement)
          .toList();
      if (briefAnnotations.length != 1) {
        _fail(
          '$entityClassName must declare @FoxyBriefEntity: the query layer '
              'generates getBrief${pluralize(baseName)}/'
              'count${pluralize(baseName)} returning a Brief$baseName '
              'table-row projection; without a Brief declaration the '
              'generated code cannot compile.',
          entityElement,
          'Add @FoxyBriefEntity() to the Entity, or keep handwritten query '
              'methods in the repository and remove the query-layer '
              'triggers (linkKey / List ViewModel).',
        );
      }
      if (briefProjectionColumns.isEmpty) {
        _fail(
          '$entityClassName has no projection columns marked with '
              '@FoxyBriefField.',
          entityElement,
          'Mark at least one physical field with @FoxyBriefField() so the '
              'Brief list query can select display columns.',
        );
      }
    }
    // _emitCreate assigns `await nextMaxPlusOne(...)` (an int) to every
    // non-link key field; a String key would produce uncompilable code with
    // zero diagnostics at generation time.
    if (queryLayerEnabled) {
      for (final field in keyFields) {
        final isLink = linkKeyFields.any((p) => p.dartName == field.dartName);
        if (!isLink && field.dartType != 'int') {
          _fail(
            '$entityClassName.${field.dartName} is a ${field.dartType} '
                'primary key, so the create query layer cannot be '
                'generated (the MAX+1 sequence only supports int).',
            entityElement,
            'Change the primary key to int, or keep a handwritten create '
                'method in the repository and disable the query layer.',
          );
        }
      }
    }

    final filterFields = _readFilterFields(
      element,
      baseName,
      fieldColumnByName,
      // Child-table repositories (declaring linkKey) do not generate
      // _applyFilter; their filter fields may be non-inferable (the Filter
      // class is still generated, as a query-input object only).
      listViewModelPresent,
    );

    final source = await buildStep.readAsString(buildStep.inputId);
    final repositoryTable = RegExp(
      r'''static\s+const\s+_table\s*=\s*['"]([^'"]+)['"]\s*;''',
    ).firstMatch(source)?.group(1);
    if (repositoryTable != table) {
      _fail(
        "$repositoryClassName._table does not match $entityClassName's "
            'physical table: ${repositoryTable ?? 'undeclared'} != $table.',
        element,
        'Make Repository._table exactly match @FoxyFullEntity.table.',
      );
    }
    final partName = inputFileName.replaceFirst(RegExp(r'\.dart$'), '.g.dart');
    if (!source.contains("part '$partName';") &&
        !source.contains('part "$partName";')) {
      _fail(
        '$repositoryClassName is missing part \'$partName\';.',
        element,
        'Declare the generated part after the Repository imports.',
      );
    }
    // Locale-helper delegates need DbcLocaleRepositoryMixin's
    // loadDbcLocaleField/storeDbcLocaleField and dbcLocaleTableName.
    final localeHelpersEnabled =
        RegExp(r'\bDbcLocaleRepositoryMixin\b').hasMatch(source) &&
        RegExp(r'\bdbcLocaleTableName\b').hasMatch(source);
    final mixinName = '_${repositoryClassName}Mixin';
    if (!RegExp(
      'class\\s+$repositoryClassName\\s+with\\s+[^\\{;]*\\b$mixinName\\b',
    ).hasMatch(source)) {
      _fail(
        '$repositoryClassName must mix in $mixinName.',
        element,
        "Append $mixinName to the end of the Repository's with list.",
      );
    }

    // autoIncrementKey: composite-key tables declare "the sequence column
    // that duplicate-key retries reallocate"; it must be an int key field,
    // and the scope must be key fields (dart names).
    final autoIncrementKey = annotation.peek('autoIncrementKey')?.stringValue;
    String? resolvedAutoIncrementKey;
    if (autoIncrementKey != null && autoIncrementKey.isNotEmpty) {
      final matched = keyFields.where((field) => field.dartName == autoIncrementKey);
      if (matched.isEmpty) {
        _fail(
          "$repositoryClassName's autoIncrementKey: '$autoIncrementKey' "
              'is not a key field of $entityClassName.',
          element,
          'autoIncrementKey must be the name of a field annotated '
              '@FoxyFullField(key: true) on the entity.',
        );
      }
      if (matched.single.dartType != 'int') {
        _fail(
          "$repositoryClassName's autoIncrementKey: '$autoIncrementKey' has "
              'type ${matched.single.dartType}; it must be int.',
          element,
          'Only int primary-key columns support MAX+1 automatic '
              'reallocation.',
        );
      }
      resolvedAutoIncrementKey = autoIncrementKey;
    }
    final declaredAutoIncrementScope = <String>[];
    final scopeReader = annotation.peek('autoIncrementScope');
    if (scopeReader != null && !scopeReader.isNull) {
      // `isList` guards the type before `listValue` (which throws a raw
      // StateError on a non-List). An unset optional list field surfaces as
      // an *empty* list, so only element types are validated.
      final list = scopeReader.isList ? scopeReader.listValue : null;
      if (list == null || list.any((value) => value.toStringValue() == null)) {
        _fail(
          "$repositoryClassName's @FoxyRepository autoIncrementScope must "
              'be a List<String>.',
          element,
          'autoIncrementScope: [\'fieldName\'].',
        );
      }
      declaredAutoIncrementScope.addAll(
        list.map((value) => value.toStringValue()!),
      );
    }
    for (final declared in declaredAutoIncrementScope) {
      final matched =
          keyFields.where((field) => field.dartName == declared).toList();
      if (matched.isEmpty) {
        _fail(
          "$repositoryClassName's autoIncrementScope: '$declared' is not a "
              'key field of $entityClassName.',
          element,
          'autoIncrementScope must be the name of a field annotated '
              '@FoxyFullField(key: true) on the entity.',
        );
      }
    }

    return RepositoryGenerationModel(
      entityClassName: entityClassName,
      entityParameterName: entityParameter,
      filterFields: List.unmodifiable(filterFields),
      keyFields: List.unmodifiable(keyFields),
      listViewModelPresent: listViewModelPresent,
      localeHelpersEnabled: localeHelpersEnabled,
      mixinName: mixinName,
      briefProjectionColumns: List.unmodifiable(briefProjectionColumns),
      linkKeyFields: List.unmodifiable(linkKeyFields),
      autoIncrementKey: resolvedAutoIncrementKey,
      autoIncrementScope: List.unmodifiable(declaredAutoIncrementScope),
      queryLayerEnabled: queryLayerEnabled,
      repositoryClassName: repositoryClassName,
      table: table,
    );
  }

  /// Whether the field carries the physical-projection marker
  /// `@FoxyBriefField()` (the default constructor without name/type;
  /// class-level `@FoxyBriefField.text/integer/...` are projection aliases
  /// provided by the query, not physical columns).
  bool _isPhysicalBriefField(FieldElement field) {
    final annotations = _briefFieldChecker.annotationsOf(field).toList();
    if (annotations.length > 1) {
      _fail(
        '${field.enclosingElement.name}.${field.name} uses '
            '@FoxyBriefField more than once.',
        field,
        'Keep only one @FoxyBriefField.',
      );
    }
    if (annotations.isEmpty) return false;
    return ConstantReader(annotations.single).peek('name')?.stringValue == null;
  }

  List<RepositoryFilterFieldModel> _readFilterFields(
    ClassElement element,
    String baseName,
    Map<String, String> fieldColumnByName,
    bool requireColumnInference,
  ) {
    final filterClassName = '${baseName}Filter';
    final fields = <RepositoryFilterFieldModel>[];
    final names = <String>{};
    for (final object in _filterChecker.annotationsOf(element)) {
      final field = readFilterField(object, filterClassName, element);
      if (!names.add(field.name)) {
        _fail(
          '$filterClassName declares field ${field.name} more than once.',
          element,
          'Ensure each @FoxyFilter field name is unique.',
        );
      }
      if (field.column.isNotEmpty) {
        fields.add(field);
        continue;
      }
      final inferred = fieldColumnByName[field.name];
      if (inferred == null) {
        if (requireColumnInference) {
          _fail(
            '$filterClassName.${field.name} cannot infer a physical '
                'column: the Entity has no field named ${field.name}.',
            element,
            'Declare column: \'columnName\' on @FoxyFilter.${field.type.name}'
                "('${field.name}').",
          );
        }
        // Child-table repositories do not generate _applyFilter, so column
        // names are not consumed and may be undeclared.
        fields.add(field);
        continue;
      }
      fields.add(
        RepositoryFilterFieldModel(
          column: inferred,
          defaultValue: field.defaultValue,
          name: field.name,
          type: field.type,
        ),
      );
    }
    return fields;
  }

  Never _fail(String message, Element element, String correction) {
    throw InvalidGenerationSourceError(
      '$message\nFix: $correction',
      element: element,
    );
  }
}
