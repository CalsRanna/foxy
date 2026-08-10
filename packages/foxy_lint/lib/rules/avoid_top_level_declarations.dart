import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// Bans top-level variables and functions in `lib/` (the project keeps
/// every symbol inside a class), except `main` and isolate-worker entry
/// points (`run*Worker`), which the Dart language requires to be
/// top-level.
///
/// Top-level declarations pollute the package namespace and make
/// dependencies implicit; every migrated symbol should live in its
/// domain class (see the `doc/dependency_architecture.md` migration).
class AvoidTopLevelDeclarations extends AnalysisRule {
  static const LintCode code = LintCode(
    'avoid_top_level_declarations',
    'Top-level declarations are banned; put the symbol inside a class.',
    correctionMessage:
        'Move the declaration into its domain class (e.g. an '
            '`abstract final class` namespace).',
    severity: DiagnosticSeverity.WARNING,
  );

  AvoidTopLevelDeclarations()
      : super(
          name: 'avoid_top_level_declarations',
          description:
              'Top-level variables/functions are banned; every symbol '
                  'must live in a class.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addCompilationUnit(this, _Visitor(this, context));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final AvoidTopLevelDeclarations rule;

  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitCompilationUnit(CompilationUnit node) {
    for (final declaration in node.declarations) {
      final name = switch (declaration) {
        TopLevelVariableDeclaration() =>
          declaration.variables.variables.first.name.lexeme,
        FunctionDeclaration() => declaration.name.lexeme,
        _ => null,
      };
      if (name == null) continue;
      if (name == 'main') continue; // app entry (language requirement)
      if (name.startsWith('run') && name.endsWith('Worker')) {
        continue; // isolate entry (language requirement)
      }
      rule.reportAtNode(declaration);
    }
  }
}
