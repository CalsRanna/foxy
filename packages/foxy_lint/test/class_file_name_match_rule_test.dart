// ignore_for_file: non_constant_identifier_names

import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:foxy_lint/rules/class_file_name_match.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

/// Tests the ClassFileNameMatch rule through the official analyzer_testing
/// harness. The probed file is named `quest_flags.dart` (set in setUp), so
/// a namespace class named `QuestFlags` must not report.
@reflectiveTest
class ClassFileNameMatchRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = ClassFileNameMatch();
    super.setUp();
  }

  @override
  String get testFileName => 'quest_flags.dart';

  void testNamespaceClassMatchingNameDoesNotReport() async {
    await assertNoDiagnostics(r'''
abstract final class QuestFlags {
  static const flagOptions = 1;
}
''');
  }

  void testNamespaceClassWrongNameReports() async {
    await assertDiagnostics(
      r'''
abstract final class Flags {
  static const flagOptions = 1;
}
''',
      [
        lint(0, 62),
      ],
    );
  }

  void testRegularClassDoesNotReport() async {
    await assertNoDiagnostics(r'''
class FlagItem {
  final int value;
  const FlagItem(this.value);
}
''');
  }

  void testSingletonClassDoesNotReport() async {
    await assertNoDiagnostics(r'''
class QuestFlags {
  static final instance = QuestFlags._();
  QuestFlags._();
  void doThing() {}
}
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ClassFileNameMatchRuleTest);
  });
}
