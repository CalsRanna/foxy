import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _code = LintCode(
  name: 'no_chinese_throw',
  problemMessage: 'throw 表达式禁止中文字符串字面量；用户文案统一经 foxyErrorMessage 按类型映射',
);

/// 覆盖 CJK 统一表意文字(U+3400-9FFF,含扩展 A)与全角标点(U+FF00-FFEF)。
final _cjk = RegExp(r'[㐀-鿿＀-￯]');

/// throw 表达式中的字符串字面量禁止包含中文字符。
///
/// 异常只承载类型 + 英文诊断信息（供日志），面向用户的中文文案一律经
/// `lib/infrastructure/errors/foxy_exceptions.dart` 的 `foxyErrorMessage`
/// 按类型映射，防止异常消息再次散落各处。
class NoChineseThrow extends DartLintRule {
  const NoChineseThrow() : super(code: _code);

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addStringLiteral((node) {
      // addStringLiteral 同时派发 SimpleStringLiteral 与 StringInterpolation；
      // 插值字符串(throw '...$id 中文')是漏报高发形态,必须覆盖。
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
