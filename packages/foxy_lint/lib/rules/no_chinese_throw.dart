import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// Covers CJK Unified Ideographs (U+3400-9FFF, incl. Extension A) and
/// full-width punctuation (U+FF00-FFEF).
final _cjk = RegExp(r'[㐀-鿿＀-￯]');

/// String literals inside throw expressions must not contain Chinese
/// characters.
///
/// Exceptions carry only a type plus English diagnostic info (for logs);
/// user-facing Chinese copy is always mapped by type through
/// `foxyErrorMessage`, so exception messages never scatter again.
class NoChineseThrow extends AnalysisRule {
  static const LintCode code = LintCode(
    'no_chinese_throw',
    'Throw expressions must not contain Chinese string literals.',
    correctionMessage:
        'Use an English diagnostic message; user-facing Chinese copy is '
            'mapped by type through foxyErrorMessage.',
    severity: DiagnosticSeverity.WARNING,
  );

  NoChineseThrow()
      : super(
          name: 'no_chinese_throw',
          description:
              'Throw expressions must not contain Chinese string literals.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _Visitor(this, context);
    registry
      ..addSimpleStringLiteral(this, visitor)
      ..addStringInterpolation(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final NoChineseThrow rule;

  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    _check(node, node.value);
  }

  @override
  void visitStringInterpolation(StringInterpolation node) {
    // Interpolated strings (e.g. a throw with Chinese text after an `$id`
    // segment) are a frequent miss-report shape and must be covered.
    _check(
      node,
      node.elements
          .whereType<InterpolationString>()
          .map((element) => element.value)
          .join(),
    );
  }

  void _check(AstNode node, String text) {
    if (!_cjk.hasMatch(text)) return;
    for (var parent = node.parent; parent != null; parent = parent.parent) {
      if (parent is ThrowExpression) {
        rule.reportAtNode(node);
        return;
      }
    }
  }
}
