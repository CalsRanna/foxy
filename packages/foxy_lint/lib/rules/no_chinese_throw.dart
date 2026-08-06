import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _code = LintCode(
  name: 'no_chinese_throw',
  problemMessage: 'throw 表达式禁止中文字符串字面量；用户文案统一经 foxyErrorMessage 按类型映射',
);

/// Covers CJK Unified Ideographs (U+3400-9FFF, incl. Extension A) and
/// full-width punctuation (U+FF00-FFEF).
final _cjk = RegExp(r'[㐀-鿿＀-￯]');

/// String literals inside throw expressions must not contain Chinese
/// characters.
///
/// Exceptions carry only a type plus English diagnostic info (for logs);
/// user-facing Chinese copy is always mapped by type through
/// `foxyErrorMessage` in `lib/infrastructure/errors/foxy_exceptions.dart`,
/// so exception messages never scatter again.
class NoChineseThrow extends DartLintRule {
  const NoChineseThrow() : super(code: _code);

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addStringLiteral((node) {
      // addStringLiteral dispatches both SimpleStringLiteral and
      // StringInterpolation; interpolated strings (e.g. a throw with Chinese
      // text after an `$id` segment) are a frequent miss-report shape and
      // must be covered.
      final text = switch (node) {
        SimpleStringLiteral simple => simple.value,
        StringInterpolation interpolation => interpolation.elements
            .whereType<InterpolationString>()
            .map((element) => element.value)
            .join(),
        _ => null,
      };
      if (text == null || !_cjk.hasMatch(text)) return;
      for (var parent = node.parent; parent != null; parent = parent.parent) {
        if (parent is ThrowExpression) {
          reporter.atNode(node, _code);
          return;
        }
      }
    });
  }
}
