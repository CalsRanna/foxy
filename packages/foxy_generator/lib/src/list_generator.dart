// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:foxy_annotation/list_annotations.dart';
import 'list_emitter.dart';
import 'list_reader.dart';

final class FoxyListViewModelGenerator
    extends GeneratorForAnnotation<FoxyListViewModel> {
  final ListEmitter emitter;
  final ListReader reader;

  const FoxyListViewModelGenerator({
    this.emitter = const ListEmitter(),
    this.reader = const ListReader(),
  }) : super(inPackage: 'foxy_annotation');

  @override
  TypeChecker get typeChecker => const TypeChecker.fromUrl(
    'package:foxy_annotation/list_annotations.dart#'
    'FoxyListViewModel',
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
