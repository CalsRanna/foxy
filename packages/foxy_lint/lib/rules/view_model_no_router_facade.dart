import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import 'package:foxy_lint/rules/file_scopes.dart';

/// ViewModels must not import RouterFacade (navigation stays in the view
/// layer).
class ViewModelNoRouterFacade extends AnalysisRule {
  static const LintCode code = LintCode(
    'view_model_no_router_facade',
    'ViewModels must not import RouterFacade.',
    correctionMessage: 'Move navigation to the view layer.',
    severity: DiagnosticSeverity.WARNING,
  );

  ViewModelNoRouterFacade()
      : super(
          name: 'view_model_no_router_facade',
          description: 'ViewModels must not import RouterFacade.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addImportDirective(this, _Visitor(this, context));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final ViewModelNoRouterFacade rule;

  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitImportDirective(ImportDirective node) {
    if (!isViewModelFile(context.definingUnit.file.path)) return;
    final uri = node.uri.stringValue ?? '';
    if (uri.contains('router_facade.dart')) {
      rule.reportAtNode(node);
    }
  }
}
