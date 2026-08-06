// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy_generator/src/form_emitter.dart';
import 'package:foxy_generator/src/form_reader.dart';

final class FoxyViewModelGenerator
    extends GeneratorForAnnotation<FoxyDetailViewModel> {
  final FormEmitter emitter;
  final FormReader reader;

  const FoxyViewModelGenerator({
    this.emitter = const FormEmitter(),
    this.reader = const FormReader(),
  }) : super(inPackage: 'foxy_annotation');

  @override
  TypeChecker get typeChecker => const TypeChecker.fromUrl(
    'package:foxy_annotation/form_annotations.dart#'
    'FoxyDetailViewModel',
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
