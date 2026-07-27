import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'file_scopes.dart';

const _flexCode = LintCode(
  name: 'no_flex_in_view',
  problemMessage: 'View 文件禁止使用 flex: 参数，应使用 Expanded 等宽布局',
);

const _readOnlyCode = LintCode(
  name: 'no_readonly_in_view',
  problemMessage: 'View 文件禁止使用 readOnly: true，所有字段应可编辑',
);

class NoFlexInView extends DartLintRule {
  const NoFlexInView() : super(code: _flexCode);

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    if (!isViewFile(resolver.path)) return;

    context.registry.addNamedExpression((node) {
      if (node.name.label.name == 'flex') {
        reporter.atNode(node, _flexCode);
      }
    });
  }
}

class NoReadOnlyInView extends DartLintRule {
  const NoReadOnlyInView() : super(code: _readOnlyCode);

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    if (!isViewFile(resolver.path)) return;

    context.registry.addNamedExpression((node) {
      if (node.name.label.name != 'readOnly') return;
      final expression = node.expression;
      if (expression is BooleanLiteral && expression.value) {
        reporter.atNode(node, _readOnlyCode);
      }
    });
  }
}
