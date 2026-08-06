import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'rules/entity_no_flutter_import.dart';
import 'rules/entity_scalar_only.dart';
import 'rules/no_chinese_throw.dart';
import 'rules/no_collection_loops.dart';
import 'rules/no_flex_readonly_in_view.dart';
import 'rules/repository_no_save.dart';
import 'rules/viewmodel_no_router_facade.dart';

PluginBase createPlugin() => _FoxyLintPlugin();

class _FoxyLintPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
    const EntityScalarOnly(),
    const RepositoryNoSave(),
    const NoChineseThrow(),
    const NoCollectionLoops(),
    const EntityNoFlutterImport(),
    const ViewModelNoRouterFacade(),
    const NoFlexInView(),
    const NoReadOnlyInView(),
  ];
}
