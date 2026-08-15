import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// Bans `k`-prefixed names on class members (e.g. `static const kFoo`).
///
/// The project's naming convention (after the top-level-symbol migration)
/// is: `k` prefixes only ever appeared on top-level constants; once a
/// constant lives inside a class, the class name already provides the
/// namespace, so the member name drops the `k` (e.g. `QuestFlags.flagOptions`,
/// not `QuestFlags.kFlagOptions`).
class NoKPrefixedStaticMember extends AnalysisRule {
  static const LintCode code = LintCode(
    'no_k_prefixed_static_member',
    'Class members must not use the `k` prefix (the class name already '
        'namespaces them).',
    correctionMessage:
        'Drop the `k` prefix: `static const kFoo` → `static const foo`.',
    severity: DiagnosticSeverity.WARNING,
  );

  NoKPrefixedStaticMember()
      : super(
          name: 'no_k_prefixed_static_member',
          description:
              'Class members must not use the `k` prefix; the class name '
                  'already provides the namespace.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addFieldDeclaration(this, _Visitor(this, context));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final NoKPrefixedStaticMember rule;

  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    if (!node.isStatic) return;
    for (final variable in node.fields.variables) {
      final name = variable.name.lexeme;
      // Only the `kFoo` convention is banned; plain words starting with
      // `k` (e.g. `keepReleases`) are regular lowerCamelCase names.
      if (RegExp(r'^k[A-Z]').hasMatch(name)) {
        rule.reportAtNode(variable);
      }
    }
  }
}
