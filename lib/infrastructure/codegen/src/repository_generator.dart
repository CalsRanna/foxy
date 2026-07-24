// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../repository_annotations.dart';
import 'repository_emitter.dart';
import 'repository_reader.dart';

final class FoxyRepositoryGenerator
    extends GeneratorForAnnotation<FoxyRepository> {
  final RepositoryEmitter emitter;
  final RepositoryReader reader;

  const FoxyRepositoryGenerator({
    this.emitter = const RepositoryEmitter(),
    this.reader = const RepositoryReader(),
  }) : super(inPackage: 'foxy');

  @override
  TypeChecker get typeChecker => const TypeChecker.fromUrl(
    'package:foxy/infrastructure/codegen/repository_annotations.dart#'
    'FoxyRepository',
  );

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final model = await reader.read(element, annotation, buildStep);
    return emitter.emit(model);
  }
}
