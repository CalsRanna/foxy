// ignore_for_file: non_constant_identifier_names

import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:foxy_lint/rules/no_k_prefixed_static_member.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

/// Tests the NoKPrefixedStaticMember rule through the official
/// analyzer_testing harness.
@reflectiveTest
class NoKPrefixedStaticMemberRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = NoKPrefixedStaticMember();
    super.setUp();
  }

  void testStaticConstKPrefixReports() async {
    await assertDiagnostics(
      r'''
abstract final class QuestFlags {
  static const kFlagOptions = 1;
}
''',
      [
        lint(49, 16),
      ],
    );
  }

  void testStaticFieldKPrefixReports() async {
    await assertDiagnostics(
      r'''
class Foo {
  static final kBar = 1;
}
''',
      [
        lint(27, 8),
      ],
    );
  }

  void testStaticConstNoKDoesNotReport() async {
    await assertNoDiagnostics(r'''
abstract final class QuestFlags {
  static const flagOptions = 1;
}
''');
  }

  void testInstanceFieldKPrefixDoesNotReport() async {
    await assertNoDiagnostics(r'''
class Foo {
  final kBar = 1;
}
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(NoKPrefixedStaticMemberRuleTest);
  });
}
