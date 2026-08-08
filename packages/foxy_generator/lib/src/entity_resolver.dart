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
    throw InvalidGenerationSourceError(
      '$context 推导出文件 $fileName，但文件不存在。\n'
      '修复方式：创建 lib/$directory/$fileName 并声明 $className，'
      '或在注解中显式声明。',
      element: errorElement,
    );
  }

  final LibraryElement library;
  try {
    library = await buildStep.resolver.libraryFor(assetId);
  } on Object catch (error) {
    throw InvalidGenerationSourceError(
      '$context 无法解析库 $fileName：$error',
      element: errorElement,
    );
  }
  final candidates = library.classes
      .where((candidate) => candidate.name == className)
      .toList();
  if (candidates.isEmpty) {
    throw InvalidGenerationSourceError(
      '$context 在 $fileName 中找不到 class $className。\n'
      '修复方式：在 lib/$directory/$fileName 中声明 $className。',
      element: errorElement,
    );
  }
  return candidates.single;
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
/// (e.g. `CreatureTemplateListViewModel 的 entity`).
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
    throw InvalidGenerationSourceError(
      '$entityClassName 必须且只能声明一个 @FoxyFullEntity。\n'
      '修复方式：只绑定已迁移的生成型 Full Entity。',
      element: entityElement,
    );
  }
  final table =
      ConstantReader(annotations.single).peek('table')?.stringValue ??
      tableNameOf(entityClassName);
  if (table.isEmpty) {
    throw InvalidGenerationSourceError(
      '$entityClassName 未声明 @FoxyFullEntity(table:) 且类名无法推导表名'
          '（类名恰为 "Entity"）。\n'
          '修复方式：给 @FoxyFullEntity 显式传 table: \'物理表名\'。',
      element: entityElement,
    );
  }
  return ResolvedEntityInfo(entityElement: entityElement, table: table);
}
