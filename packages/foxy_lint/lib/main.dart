import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';

import 'package:foxy_lint/rules/annotation_file_mismatch.dart';
import 'package:foxy_lint/rules/entity_no_flutter_import.dart';
import 'package:foxy_lint/rules/entity_scalar_only.dart';
import 'package:foxy_lint/rules/no_chinese_throw.dart';
import 'package:foxy_lint/rules/no_collection_loops.dart';
import 'package:foxy_lint/rules/no_flex_readonly_in_view.dart';
import 'package:foxy_lint/rules/repository_no_save.dart';
import 'package:foxy_lint/rules/view_model_no_router_facade.dart';

/// The plugin entrypoint. The analysis server looks for this top-level
/// `plugin` variable when loading the plugin (Dart 3.10+ analyzer plugin
/// system).
final plugin = _FoxyLintPlugin();

class _FoxyLintPlugin extends Plugin {
  @override
  String get name => 'Foxy lint';

  @override
  void register(PluginRegistry registry) {
    registry
      ..registerWarningRule(AnnotationFileMismatch())
      ..registerWarningRule(EntityScalarOnly())
      ..registerWarningRule(NoCollectionLoops())
      ..registerWarningRule(EntityNoFlutterImport())
      ..registerWarningRule(ViewModelNoRouterFacade())
      ..registerWarningRule(RepositoryNoSave())
      ..registerWarningRule(NoFlexInView())
      ..registerWarningRule(NoReadOnlyInView())
      ..registerWarningRule(NoChineseThrow());
  }
}
