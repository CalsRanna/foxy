import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'package:foxy_lint/rules/file_scopes.dart';

const _code = LintCode(
  name: 'no_collection_loops',
  problemMessage: '{0} 文件禁止使用 {1}，应显式展开字段',
);

class NoCollectionLoops extends DartLintRule {
  const NoCollectionLoops() : super(code: _code);

  @override
  void run(CustomLintResolver resolver, DiagnosticReporter reporter, CustomLintContext context) {
    final scope = collectionLoopScope(resolver.path);
    if (scope == null) return;

    context.registry.addMethodInvocation((node) {
      if (node.methodName.name != 'generate') return;
      final target = node.target;
      if (target is Identifier && target.name == 'List') {
        reporter.atNode(node, _code);
      }
    });

    // Only `for-in` over a collection is the target: a C-style indexed
    // `for (var i = 0; i < n; i++)` is not a collection loop and must not
    // be reported. Analyzer 8.x merged ForEachStatement into ForStatement;
    // `forLoopParts is ForEachParts` distinguishes the two forms.
    context.registry.addForStatement((node) {
      if (node.forLoopParts is ForEachParts) {
        reporter.atNode(node, _code);
      }
    });
  }
}
