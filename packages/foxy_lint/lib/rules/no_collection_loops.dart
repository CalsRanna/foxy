import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import 'package:foxy_lint/rules/file_scopes.dart';

/// Entity/ViewModel/View files must not use collection loops
/// (`List.generate` or `for-in` over a collection); fields must be
/// explicitly expanded.
class NoCollectionLoops extends AnalysisRule {
  static const LintCode code = LintCode(
    'no_collection_loops',
    '{0} files must not use {1}; expand fields explicitly.',
    correctionMessage:
        'Replace the collection loop with explicit per-field statements.',
    severity: DiagnosticSeverity.WARNING,
  );

  NoCollectionLoops()
      : super(
          name: 'no_collection_loops',
          description:
              'Entity/ViewModel/View files must not use collection loops.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final scope = collectionLoopScope(context.definingUnit.file.path);
    if (scope == null) return;
    registry.addMethodInvocation(
      this,
      _MethodInvocationVisitor(this, context, scope),
    );
    registry.addForStatement(this, _ForStatementVisitor(this, context, scope));
  }
}

class _MethodInvocationVisitor extends SimpleAstVisitor<void> {
  final NoCollectionLoops rule;

  final RuleContext context;

  final String scope;

  _MethodInvocationVisitor(this.rule, this.context, this.scope);

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.methodName.name != 'generate') return;
    final target = node.target;
    if (target is Identifier && target.name == 'List') {
      rule.reportAtNode(node, arguments: [scope, 'List.generate']);
    }
  }
}

class _ForStatementVisitor extends SimpleAstVisitor<void> {
  final NoCollectionLoops rule;

  final RuleContext context;

  final String scope;

  _ForStatementVisitor(this.rule, this.context, this.scope);

  @override
  void visitForStatement(ForStatement node) {
    // Only `for-in` over a collection is the target: a C-style indexed
    // `for (var i = 0; i < n; i++)` is not a collection loop and must not
    // be reported. Analyzer merged ForEachStatement into ForStatement;
    // `forLoopParts is ForEachParts` distinguishes the two forms.
    if (node.forLoopParts is ForEachParts) {
      rule.reportAtNode(node, arguments: [scope, 'for-in']);
    }
  }
}
