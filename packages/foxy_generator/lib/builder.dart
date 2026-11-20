// ignore_for_file: depend_on_referenced_packages

import 'package:build/build.dart';
import 'package:foxy_generator/src/entity_generator.dart';
import 'package:foxy_generator/src/form_generator.dart';
import 'package:foxy_generator/src/linked_detail_generator.dart';
import 'package:foxy_generator/src/linked_list_generator.dart';
import 'package:foxy_generator/src/list_generator.dart';
import 'package:foxy_generator/src/repository_filter_generator.dart';
import 'package:foxy_generator/src/repository_generator.dart';
import 'package:foxy_generator/src/semantics_generator.dart';
import 'package:source_gen/source_gen.dart';

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

/// Aggregates `@FoxyFieldMeaning` annotations across entity files into the
/// runtime semantics table used by the agent catalog.
Builder foxySemanticsBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [const FoxySemanticsGenerator()],
    'foxy_semantics',
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
