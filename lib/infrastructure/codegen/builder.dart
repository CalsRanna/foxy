// ignore_for_file: depend_on_referenced_packages

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/entity_generator.dart';
import 'src/filter_entity_generator.dart';

Builder foxyEntityBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [const FoxyEntityGenerator()],
    'foxy_entity',
    writeDescriptions: false,
  );
}

Builder foxyFilterEntityBuilder(BuilderOptions options) {
  return LibraryBuilder(
    const FoxyFilterEntityGenerator(),
    generatedExtension: '.filter.g.dart',
    writeDescriptions: false,
  );
}
