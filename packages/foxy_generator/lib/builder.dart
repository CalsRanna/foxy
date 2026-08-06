// ignore_for_file: depend_on_referenced_packages

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/entity_generator.dart';
import 'src/form_generator.dart';
import 'src/linked_detail_generator.dart';
import 'src/linked_list_generator.dart';
import 'src/list_generator.dart';
import 'src/repository_filter_generator.dart';
import 'src/repository_generator.dart';

Builder foxyEntityBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [const FoxyEntityGenerator()],
    'foxy_entity',
    writeDescriptions: false,
  );
}

// Part top level follows the "Sort Members" rule: public classes (Filter) come
// before the private mixin (Repository), so the Filter generator goes first.
Builder foxyRepositoryBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [const FoxyFilterGenerator(), const FoxyRepositoryGenerator()],
    'foxy_repository',
    writeDescriptions: false,
  );
}

// Generators are ordered by name (FoxyLinkedDetailViewModelGenerator <
// FoxyLinkedListViewModelGenerator < FoxyListViewModelGenerator <
// FoxyViewModelGenerator)。
Builder foxyViewModelBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [
      const FoxyLinkedDetailViewModelGenerator(),
      const FoxyLinkedListViewModelGenerator(),
      const FoxyListViewModelGenerator(),
      const FoxyViewModelGenerator(),
    ],
    'foxy_view_model',
    writeDescriptions: false,
  );
}
