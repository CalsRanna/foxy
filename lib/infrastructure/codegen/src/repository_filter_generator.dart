// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../repository_annotations.dart';
import 'repository_filter_emitter.dart';
import 'repository_filter_reader.dart';

final class FoxyRepositoryFilterGenerator
    extends GeneratorForAnnotation<FoxyRepositoryFilter> {
  final RepositoryFilterEmitter emitter;
  final RepositoryFilterReader reader;

  const FoxyRepositoryFilterGenerator({
    this.emitter = const RepositoryFilterEmitter(),
    this.reader = const RepositoryFilterReader(),
  }) : super(inPackage: 'foxy');

  @override
  TypeChecker get typeChecker => const TypeChecker.fromUrl(
    'package:foxy/infrastructure/codegen/repository_annotations.dart#'
    'FoxyRepositoryFilter',
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
