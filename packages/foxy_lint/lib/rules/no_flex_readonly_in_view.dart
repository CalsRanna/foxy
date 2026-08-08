import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import 'package:foxy_lint/rules/file_scopes.dart';

/// View files must not use the `flex:` parameter; use Expanded for even
/// layouts.
class NoFlexInView extends AnalysisRule {
  static const LintCode code = LintCode(
    'no_flex_in_view',
    'View files must not use the flex: parameter; use Expanded for even '
        'layouts.',
    correctionMessage: 'Replace flex: with Expanded.',
    severity: DiagnosticSeverity.WARNING,
  );

  NoFlexInView()
      : super(
          name: 'no_flex_in_view',
          description:
              'View files must not use the flex: parameter.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addNamedExpression(this, _FlexVisitor(this, context));
  }
}

class _FlexVisitor extends SimpleAstVisitor<void> {
  final NoFlexInView rule;

  final RuleContext context;

  _FlexVisitor(this.rule, this.context);

  @override
  void visitNamedExpression(NamedExpression node) {
    if (!isViewFile(context.definingUnit.file.path)) return;
    if (node.name.label.name == 'flex') {
      rule.reportAtNode(node);
    }
  }
}

/// View files must not use `readOnly: true`; all fields must be editable.
class NoReadOnlyInView extends AnalysisRule {
  static const LintCode code = LintCode(
    'no_readonly_in_view',
    'View files must not use readOnly: true; all fields must be editable.',
    correctionMessage: 'Remove readOnly: true.',
    severity: DiagnosticSeverity.WARNING,
  );

  NoReadOnlyInView()
      : super(
          name: 'no_readonly_in_view',
          description:
              'View files must not use readOnly: true.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addNamedExpression(this, _ReadOnlyVisitor(this, context));
  }
}

class _ReadOnlyVisitor extends SimpleAstVisitor<void> {
  final NoReadOnlyInView rule;

  final RuleContext context;

  _ReadOnlyVisitor(this.rule, this.context);

  @override
  void visitNamedExpression(NamedExpression node) {
    if (!isViewFile(context.definingUnit.file.path)) return;
    if (node.name.label.name != 'readOnly') return;
    final expression = node.expression;
    if (expression is BooleanLiteral && expression.value) {
      rule.reportAtNode(node);
    }
  }
}
