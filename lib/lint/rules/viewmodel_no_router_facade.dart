import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'file_scopes.dart';

const _code = LintCode(
  name: 'viewmodel_no_router_facade',
  problemMessage: 'ViewModel 禁止导入 RouterFacade',
);

class ViewModelNoRouterFacade extends DartLintRule {
  const ViewModelNoRouterFacade() : super(code: _code);

  @override
  void run(CustomLintResolver resolver, DiagnosticReporter reporter, CustomLintContext context) {
    if (!isViewModelFile(resolver.path)) return;

    context.registry.addImportDirective((node) {
      final uri = node.uri.stringValue ?? '';
      if (uri.contains('router_facade.dart')) {
        reporter.atNode(node, _code);
      }
    });
  }
}
