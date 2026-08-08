// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:foxy_generator/src/convention.dart';
import 'package:foxy_generator/src/naming.dart';

const _fullEntityChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyFullEntity',
);

/// Resolves a class by its convention-derived file path
/// (`lib/<directory>/<snake_case(class)>.dart`).
///
/// `context` names the class in error messages; `directory` is the layer
/// (`entity`, `repository`, ...).
Future<ClassElement> resolveClass(
  BuildStep buildStep,
  Element errorElement,
  String className,
  String directory,
  String context,
) async {
  final fileName = '${toSnakeCase(className)}.dart';
  final assetId = AssetId(
    buildStep.inputId.package,
    'lib/$directory/$fileName',
  );
  if (!await buildStep.canRead(assetId)) {
    _fail(
      '$context derives file $fileName, but it does not exist.',
      errorElement,
      'Create lib/$directory/$fileName and declare $className, '
          'or declare it explicitly in the annotation.',
    );
  }

  final LibraryElement library;
  try {
    library = await buildStep.resolver.libraryFor(assetId);
  } on Object catch (error) {
    _fail(
      '$context cannot resolve library $fileName: $error',
      errorElement,
      'Ensure the file parses cleanly (syntax / dependencies).',
    );
  }
  final candidates = library.classes
      .where((candidate) => candidate.name == className)
      .toList();
  if (candidates.isEmpty) {
    _fail(
      '$context cannot find class $className in $fileName.',
      errorElement,
      'Declare $className in lib/$directory/$fileName.',
    );
  }
  return candidates.single;
}

Never _fail(String message, Element element, String correction) {
  throw InvalidGenerationSourceError(
    '$message\nFix: $correction',
    element: element,
  );
}

/// Resolved Full Entity: its class element plus the physical table name
/// (explicit `@FoxyFullEntity(table:)` or the convention-derived name).
final class ResolvedEntityInfo {
  final ClassElement entityElement;

  /// Physical table name; never empty (validated at resolve time).
  final String table;

  const ResolvedEntityInfo({required this.entityElement, required this.table});
}

/// Resolves the Full Entity class by convention-derived file path and reads
/// its physical table name, falling back to the convention derivation when
/// the annotation omits `table:`.
///
/// `context` names the entity in error messages
/// (e.g. `CreatureTemplateListViewModel's entity`).
Future<ResolvedEntityInfo> resolveFullEntity(
  BuildStep buildStep,
  Element errorElement,
  String entityClassName,
  String context,
) async {
  final entityElement = await resolveClass(
    buildStep,
    errorElement,
    entityClassName,
    'entity',
    context,
  );

  final annotations = _fullEntityChecker.annotationsOf(entityElement).toList();
  if (annotations.length != 1) {
    _fail(
      '$entityClassName must declare exactly one @FoxyFullEntity.',
      entityElement,
      'Bind to a migrated generated Full Entity.',
    );
  }
  final table =
      ConstantReader(annotations.single).peek('table')?.stringValue ??
      tableNameOf(entityClassName);
  if (table.isEmpty) {
    _fail(
      '$entityClassName declares no @FoxyFullEntity(table:) and the table '
          'name cannot be derived from the class name (a class named '
          'exactly "Entity").',
      entityElement,
      "Pass the physical table name explicitly: "
          "@FoxyFullEntity(table: 'table_name').",
    );
  }
  return ResolvedEntityInfo(entityElement: entityElement, table: table);
}
