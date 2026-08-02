// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../form_annotations.dart';
import 'linked_list_emitter.dart';
import 'linked_list_reader.dart';

final class FoxyLinkedListViewModelGenerator
    extends GeneratorForAnnotation<FoxyLinkedListViewModel> {
  final LinkedListEmitter emitter;
  final LinkedListReader reader;

  const FoxyLinkedListViewModelGenerator({
    this.emitter = const LinkedListEmitter(),
    this.reader = const LinkedListReader(),
  }) : super(inPackage: 'foxy');

  @override
  TypeChecker get typeChecker => const TypeChecker.fromUrl(
    'package:foxy/infrastructure/codegen/form_annotations.dart#'
    'FoxyLinkedListViewModel',
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
