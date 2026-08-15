// ignore_for_file: non_constant_identifier_names

import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:foxy_lint/rules/no_collection_loops.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

/// Tests the real NoCollectionLoops rule through the official
/// analyzer_testing harness. Scope comes from the probed file name
/// (`sample_entity.dart`); the rule targets `List.generate` and `for-in`
/// over collections, leaving C-style `for` and collection methods alone.
@reflectiveTest
class NoCollectionLoopsRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = NoCollectionLoops();
    super.setUp();
  }

  @override
  String get testFileName => 'sample_entity.dart';

  void test_listGenerate_reports() async {
    await assertDiagnostics(
      r'''
class SampleEntity {
  final x = List.generate(3, (i) => i);
}
''',
      [lint(33, 26)],
    );
  }

  void test_forIn_reports() async {
    await assertDiagnostics(
      r'''
class SampleEntity {
  int sum(List<int> xs) {
    var t = 0;
    for (final x in xs) { t += x; }
    return t;
  }
}
''',
      [lint(66, 31)],
    );
  }

  void test_cStyleFor_doesNotReport() async {
    await assertNoDiagnostics(r'''
class SampleEntity {
  int count() {
    var t = 0;
    for (var i = 0; i < 3; i++) { t++; }
    return t;
  }
}
''');
  }

  void test_collectionMethods_doNotReport() async {
    await assertNoDiagnostics(r'''
class SampleEntity {
  List<int> bump(List<int> xs) => xs.map((e) => e + 1).toList();
}
''');
  }
}

/// The same constructs in a non-entity/vm/view file are out of scope.
@reflectiveTest
class NoCollectionLoopsScopeTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = NoCollectionLoops();
    super.setUp();
  }

  @override
  String get testFileName => 'sample_util.dart';

  void test_collectionLoops_outsideScopedFile_doNotReport() async {
    await assertNoDiagnostics(r'''
class SampleEntity {
  final x = List.generate(3, (i) => i);

  int sum(List<int> xs) {
    var t = 0;
    for (final x in xs) { t += x; }
    return t;
  }
}
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(NoCollectionLoopsRuleTest);
    defineReflectiveTests(NoCollectionLoopsScopeTest);
  });
}
