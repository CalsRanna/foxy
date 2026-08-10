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

  void test_topLevelConst_reports() async {
    await assertDiagnostics(
      r'''
const kFoo = 1;
''',
      [
        lint(0, 15),
      ],
    );
  }

  void test_topLevelFunction_reports() async {
    await assertDiagnostics(
      r'''
String formatFoo(int x) => '$x';
''',
      [
        lint(0, 32),
      ],
    );
  }

  void test_main_doesNotReport() async {
    await assertNoDiagnostics(r'''
void main() {
  print('hello');
}
''');
  }

  void test_workerEntry_doesNotReport() async {
    await assertNoDiagnostics(r'''
Future<void> runDbcImportWorker(dynamic args) async {}
''');
  }

  void test_classMember_doesNotReport() async {
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
