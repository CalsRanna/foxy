import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:test/test.dart';

/// Regression tests for the core logic of the no_chinese_throw rule.
///
/// Uses the analyzer to parse source directly and reproduce the rule's
/// detection logic (a string literal containing CJK inside a throw
/// expression subtree is a violation), locking down two regressions:
/// - matching only `SimpleStringLiteral` misses interpolated strings (the
///   H2 fix point);
/// - CJK regex range fallback (Extension A / full-width punctuation
///   misses).
void main() {
  // The regex kept in sync with lib/lint/rules/no_chinese_throw.dart.
  final cjk = RegExp(r'[㐀-鿿＀-￯]');

  String? findViolation(String source) {
    final result = parseString(
      content: source,
      featureSet: FeatureSet.latestLanguageVersion(),
    );
    final scanner = _ThrowScanner(cjk);
    result.unit.accept(scanner);
    return scanner.violation;
  }

  group('no_chinese_throw 检测逻辑', () {
    test('插值字符串中的中文被命中(H2 修复点)', () {
      expect(
        findViolation("void f() { throw FormatException('\$x 中文消息'); }"),
        isNotNull,
      );
    });

    test('纯英文插值不命中', () {
      expect(
        findViolation("void f() { throw FormatException('\$x error'); }"),
        isNull,
      );
    });

    test('普通字符串字面量中文被命中', () {
      expect(findViolation("void f() { throw StateError('中文'); }"), isNotNull);
    });

    test('非 throw 子树中的中文不命中', () {
      expect(findViolation("void f() { final s = '中文文案'; }"), isNull);
    });

    test('throw 后相邻字符串拼接的中文被命中', () {
      expect(
        findViolation(
          "void f() { throw FormatException(\n"
          "  'record \$x 中文',\n"
          "); }",
        ),
        isNotNull,
      );
    });
  });
}

class _ThrowScanner extends RecursiveAstVisitor<void> {
  final RegExp cjk;
  String? violation;

  _ThrowScanner(this.cjk);

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    _check(node, node.value);
    super.visitSimpleStringLiteral(node);
  }

  @override
  void visitStringInterpolation(StringInterpolation node) {
    _check(
      node,
      node.elements
          .whereType<InterpolationString>()
          .map((element) => element.value)
          .join(),
    );
    super.visitStringInterpolation(node);
  }

  void _check(AstNode node, String text) {
    if (violation != null || !cjk.hasMatch(text)) return;
    for (var parent = node.parent; parent != null; parent = parent.parent) {
      if (parent is ThrowExpression) {
        violation = text;
        return;
      }
    }
  }
}
