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

    context.registry.addForStatement((node) {
      reporter.atNode(node, _code);
    });
  }
}
