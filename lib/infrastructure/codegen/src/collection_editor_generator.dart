// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../form_annotations.dart';
import 'collection_editor_emitter.dart';
import 'collection_editor_reader.dart';

final class FoxyCollectionEditorViewModelGenerator
    extends GeneratorForAnnotation<FoxyCollectionEditorViewModel> {
  final CollectionEditorEmitter emitter;
  final CollectionEditorReader reader;

  const FoxyCollectionEditorViewModelGenerator({
    this.emitter = const CollectionEditorEmitter(),
    this.reader = const CollectionEditorReader(),
  }) : super(inPackage: 'foxy');

  @override
  TypeChecker get typeChecker => const TypeChecker.fromUrl(
    'package:foxy/infrastructure/codegen/form_annotations.dart#'
    'FoxyCollectionEditorViewModel',
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
