// ignore_for_file: non_constant_identifier_names

import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:foxy_lint/rules/avoid_top_level_declarations.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

/// Tests the AvoidTopLevelDeclarations rule through the official
/// analyzer_testing harness.
@reflectiveTest
class AvoidTopLevelDeclarationsRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = AvoidTopLevelDeclarations();
    super.setUp();
  }

  void testTopLevelConstReports() async {
    await assertDiagnostics(
      r'''
const kFoo = 1;
''',
      [
        lint(0, 15),
      ],
    );
  }

  void testTopLevelFunctionReports() async {
    await assertDiagnostics(
      r'''
String formatFoo(int x) => '$x';
''',
      [
        lint(0, 32),
      ],
    );
  }

  void testMainDoesNotReport() async {
    await assertNoDiagnostics(r'''
void main() {
  print('hello');
}
''');
  }

  void testWorkerEntryDoesNotReport() async {
    await assertNoDiagnostics(r'''
Future<void> runDbcImportWorker(dynamic args) async {}
''');
  }

  void testClassMemberDoesNotReport() async {
    await assertNoDiagnostics(r'''
abstract final class QuestFlags {
  static const flagOptions = 1;
  static String format(int x) => '$x';
}
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AvoidTopLevelDeclarationsRuleTest);
  });
}
