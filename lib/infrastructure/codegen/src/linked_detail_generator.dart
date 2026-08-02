// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../form_annotations.dart';
import 'linked_detail_emitter.dart';
import 'linked_detail_reader.dart';

final class FoxyLinkedDetailViewModelGenerator
    extends GeneratorForAnnotation<FoxyLinkedDetailViewModel> {
  final LinkedDetailEmitter emitter;
  final LinkedDetailReader reader;

  const FoxyLinkedDetailViewModelGenerator({
    this.emitter = const LinkedDetailEmitter(),
    this.reader = const LinkedDetailReader(),
  }) : super(inPackage: 'foxy');

  @override
  TypeChecker get typeChecker => const TypeChecker.fromUrl(
    'package:foxy/infrastructure/codegen/form_annotations.dart#'
    'FoxyLinkedDetailViewModel',
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
