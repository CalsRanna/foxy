// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'repository_filter_emitter.dart';
import 'repository_filter_model.dart';
import 'repository_filter_reader.dart';

const _filterChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/repository_annotations.dart#FoxyFilter',
);

final class FoxyFilterGenerator extends Generator {
  final RepositoryFilterEmitter emitter;
  final RepositoryFilterReader reader;

  const FoxyFilterGenerator({
    this.emitter = const RepositoryFilterEmitter(),
    this.reader = const RepositoryFilterReader(),
  });

  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    final models = <RepositoryFilterGenerationModel>[];
    for (final element in library.element.classes) {
      final annotations = _filterChecker.annotationsOf(element).toList();
      if (annotations.isEmpty) continue;
      models.add(await reader.read(element, annotations, buildStep));
    }
    if (models.isEmpty) return null;
    // Multiple Filters are top-level public classes, sorted by name (the
    // "Sort Members" rule).
    models.sort(
      (a, b) => a.className.toLowerCase().compareTo(b.className.toLowerCase()),
    );
    return models.map(emitter.emit).join('\n\n');
  }
}
