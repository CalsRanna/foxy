// ignore_for_file: depend_on_referenced_packages

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/collection_editor_generator.dart';
import 'src/entity_generator.dart';
import 'src/form_generator.dart';
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

// part 顶层遵循 "Sort Members" 规则:公开 class(Filter)在前,
// 私有 mixin(Repository)在后,所以 Filter 生成器排在前面。
Builder foxyRepositoryBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [const FoxyFilterGenerator(), const FoxyRepositoryGenerator()],
    'foxy_repository',
    writeDescriptions: false,
  );
}

// 生成器按名排序(FoxyCollectionEditorViewModelGenerator <
// FoxyListViewModelGenerator < FoxyViewModelGenerator)。
Builder foxyViewModelBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [
      const FoxyCollectionEditorViewModelGenerator(),
      const FoxyListViewModelGenerator(),
      const FoxyViewModelGenerator(),
    ],
    'foxy_view_model',
    writeDescriptions: false,
  );
}
