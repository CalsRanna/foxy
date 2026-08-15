import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import 'package:foxy_lint/rules/file_scopes.dart';

/// Repositories must not hand-write `save*`/`insertAndGetId`; use the
/// generated `store*`/`update*`/`destroy*` instead.
class RepositoryNoSave extends AnalysisRule {
  static const LintCode code = LintCode(
    'repository_no_save',
    'Repositories must not hand-write save*/insertAndGetId; use '
        'store*/update*/destroy*.',
    correctionMessage:
        'Use the generated store*/update*/destroy* methods.',
    severity: DiagnosticSeverity.WARNING,
  );

  RepositoryNoSave()
      : super(
          name: 'repository_no_save',
          description:
              'Repositories must not hand-write save*/insertAndGetId.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addMethodDeclaration(this, _Visitor(this, context));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final RepositoryNoSave rule;

  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (!isRepositoryFile(context.definingUnit.file.path)) return;
    // Members sit inside a BlockClassBody in the analyzer 10.x AST; older
    // analyzers expose the class directly as the method's parent, so both
    // shapes are tolerated.
    final parent = node.parent;
    ClassDeclaration? enclosingClass;
    if (parent is ClassDeclaration) {
      enclosingClass = parent;
    } else if (parent is BlockClassBody && parent.parent is ClassDeclaration) {
      enclosingClass = parent.parent as ClassDeclaration;
    }
    if (enclosingClass == null) return;
    if (!enclosingClass.namePart.typeName.lexeme.endsWith('Repository')) {
      return;
    }

    final name = node.name.lexeme;
    if ((name.startsWith('save') || name == 'insertAndGetId') &&
        !name.endsWith('Locales') &&
        !name.endsWith('Locale')) {
      rule.reportAtNode(node);
    }
  }
}
