import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _code = LintCode(
  name: 'no_chinese_throw',
  problemMessage: 'throw 表达式禁止中文字符串字面量；用户文案统一经 foxyErrorMessage 按类型映射',
);

final _cjk = RegExp(r'[一-鿿]');

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
      if (node is! SimpleStringLiteral) return;
      if (!_cjk.hasMatch(node.value)) return;
      for (var parent = node.parent; parent != null; parent = parent.parent) {
        if (parent is ThrowExpression) {
          reporter.atNode(node, _code);
          return;
        }
      }
    });
  }
}
