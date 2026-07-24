// ignore_for_file: depend_on_referenced_packages

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/entity_generator.dart';
import 'src/repository_filter_generator.dart';
import 'src/repository_generator.dart';

Builder foxyEntityBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [const FoxyEntityGenerator()],
    'foxy_entity',
    writeDescriptions: false,
  );
}

Builder foxyRepositoryBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [const FoxyRepositoryGenerator(), const FoxyFilterGenerator()],
    'foxy_repository',
    writeDescriptions: false,
  );
}
