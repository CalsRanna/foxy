// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../entity_annotations.dart';
import 'entity_emitter.dart';
import 'entity_reader.dart';

final class FoxyEntityGenerator extends GeneratorForAnnotation<FoxyFullEntity> {
  final EntityReader reader;
  final EntityEmitter emitter;

  const FoxyEntityGenerator({
    this.reader = const EntityReader(),
    this.emitter = const EntityEmitter(),
  }) : super(inPackage: 'foxy');

  @override
  TypeChecker get typeChecker => const TypeChecker.fromUrl(
    'package:foxy/infrastructure/codegen/entity_annotations.dart#'
    'FoxyFullEntity',
  );

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final model = await reader.read(element, annotation, buildStep);
    return emitter.emitEntityPart(model);
  }
}
