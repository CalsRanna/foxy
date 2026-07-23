// ignore_for_file: depend_on_referenced_packages

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/brief_entity_generator.dart';
import 'src/filter_entity_generator.dart';
import 'src/full_entity_generator.dart';
import 'src/key_generator.dart';

Builder foxyBriefEntityBuilder(BuilderOptions options) {
  return LibraryBuilder(
    const FoxyBriefEntityGenerator(),
    generatedExtension: '.brief.g.dart',
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

Builder foxyFullEntityBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [const FoxyFullEntityGenerator()],
    'foxy_full_entity',
    writeDescriptions: false,
  );
}

Builder foxyKeyBuilder(BuilderOptions options) {
  return LibraryBuilder(
    const FoxyKeyGenerator(),
    generatedExtension: '.key.g.dart',
    writeDescriptions: false,
  );
}
