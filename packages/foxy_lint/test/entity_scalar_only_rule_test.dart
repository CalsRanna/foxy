// ignore_for_file: non_constant_identifier_names

import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:foxy_lint/rules/entity_scalar_only.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

/// Tests the real EntityScalarOnly rule through the official
/// analyzer_testing harness. Scope comes from the probed file name
/// (`sample_entity.dart`); only fields of `*Entity` classes are checked.
@reflectiveTest
class EntityScalarOnlyRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = EntityScalarOnly();
    super.setUp();
  }

  @override
  String get testFileName => 'sample_entity.dart';

  void test_collectionField_inEntity_reports() async {
    await assertDiagnostics(
      r'''
class SampleEntity {
  final List<int> ids = const [];
}
''',
      [lint(23, 31)],
    );
  }

  void test_scalarField_inEntity_doesNotReport() async {
    await assertNoDiagnostics(r'''
class SampleEntity {
  final int id = 0;
  final String name = '';
  final double speed = 0;
  final bool enabled = false;
}
''');
  }

  void test_collectionField_inNonEntityClass_doesNotReport() async {
    await assertNoDiagnostics(r'''
class Helper {
  final List<int> ids = const [];
}
''');
  }
}

/// The same collection field in a non-entity file is out of scope.
@reflectiveTest
class EntityScalarOnlyScopeTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = EntityScalarOnly();
    super.setUp();
  }

  @override
  String get testFileName => 'sample_util.dart';

  void test_collectionField_outsideEntityFile_doesNotReport() async {
    await assertNoDiagnostics(r'''
class SampleEntity {
  final List<int> ids = const [];
}
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(EntityScalarOnlyRuleTest);
    defineReflectiveTests(EntityScalarOnlyScopeTest);
  });
}
