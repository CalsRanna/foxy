// ignore_for_file: non_constant_identifier_names

import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:foxy_lint/rules/no_chinese_throw.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

/// Tests the real NoChineseThrow rule through the official
/// analyzer_testing harness (AnalysisRuleTest), covering:
/// - simple string literals with CJK inside a throw;
/// - interpolated strings with CJK after an `$id` segment;
/// - English-only messages must not be reported;
/// - CJK outside a throw subtree must not be reported.
@reflectiveTest
class NoChineseThrowRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = NoChineseThrow();
    super.setUp();
  }

  void test_simpleLiteral_insideThrow_reports() async {
    await assertDiagnostics(
      r'''
class Boom implements Exception {
  const Boom(this.message);
  final String message;
}

void f() {
  throw const Boom('中文');
}
''',
      [lint(119, 4)],
    );
  }

  void test_interpolated_insideThrow_reports() async {
    await assertDiagnostics(
      r'''
class Boom implements Exception {
  const Boom(this.message);
  final String message;
}

void f(int id) {
  throw Boom('$id 中文消息');
}
''',
      [lint(119, 10)],
    );
  }

  void test_englishOnly_doesNotReport() async {
    await assertNoDiagnostics(
      r'''
class Boom implements Exception {
  const Boom(this.message);
  final String message;
}

void f() {
  throw const Boom('record not found');
}
''',
    );
  }

  void test_cjkOutsideThrow_doesNotReport() async {
    await assertNoDiagnostics(
      r'''
const label = '中文文案';
void f() {}
''',
    );
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(NoChineseThrowRuleTest);
  });
}
