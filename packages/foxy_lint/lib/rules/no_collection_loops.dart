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
    // List.generate is caught through the ArgumentList dispatch (walking
    // up to the invocation): the plugin's MethodInvocation/SimpleIdentifier
    // dispatch does not fire under analyzer 10.x.
    registry.addArgumentList(this, _ArgumentListVisitor(this, context));
    registry.addForStatement(this, _ForStatementVisitor(this, context));
  }
}

class _ArgumentListVisitor extends SimpleAstVisitor<void> {
  final NoCollectionLoops rule;

  final RuleContext context;

  _ArgumentListVisitor(this.rule, this.context);

  @override
  void visitArgumentList(ArgumentList node) {
    final scope = collectionLoopScope(context.definingUnit.file.path);
    if (scope == null) return;
    // The plugin runs on the *unresolved* parse tree, where
    // `List.generate(...)` is an InstanceCreationExpression (constructor
    // invocation with a named constructor `generate`); it only becomes a
    // MethodInvocation after resolution. Both shapes are detected, and the
    // reported node spans the whole call.
    final parent = node.parent;
    if (parent is MethodInvocation &&
        parent.methodName.name == 'generate' &&
        parent.target is Identifier &&
        (parent.target as Identifier).name == 'List') {
      rule.reportAtNode(parent, arguments: [scope, 'List.generate']);
      return;
    }
    if (parent is InstanceCreationExpression) {
      final constructorName = parent.constructorName;
      if (constructorName.name?.token.lexeme == 'generate' &&
          constructorName.type.name.lexeme == 'List') {
        rule.reportAtNode(parent, arguments: [scope, 'List.generate']);
      }
    }
  }
}

class _ForStatementVisitor extends SimpleAstVisitor<void> {
  final NoCollectionLoops rule;

  final RuleContext context;

  _ForStatementVisitor(this.rule, this.context);

  @override
  void visitForStatement(ForStatement node) {
    final scope = collectionLoopScope(context.definingUnit.file.path);
    if (scope == null) return;
    // Only `for-in` over a collection is the target: a C-style indexed
    // `for (var i = 0; i < n; i++)` is not a collection loop and must not
    // be reported. Analyzer merged ForEachStatement into ForStatement;
    // `forLoopParts is ForEachParts` distinguishes the two forms.
    if (node.forLoopParts is ForEachParts) {
      rule.reportAtNode(node, arguments: [scope, 'for-in']);
    }
  }
}
