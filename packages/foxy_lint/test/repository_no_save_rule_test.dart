// ignore_for_file: non_constant_identifier_names

import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:foxy_lint/rules/repository_no_save.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

/// Tests the real RepositoryNoSave rule through the official
/// analyzer_testing harness. Scope comes from the probed file name
/// (`sample_repository.dart`); only `*Repository` classes are checked.
@reflectiveTest
class RepositoryNoSaveRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = RepositoryNoSave();
    super.setUp();
  }

  @override
  String get testFileName => 'sample_repository.dart';

  void test_saveMethod_reports() async {
    await assertDiagnostics(
      r'''
class SampleRepository {
  void saveAll() {}
}
''',
      [lint(27, 17)],
    );
  }

  void test_insertAndGetId_reports() async {
    await assertDiagnostics(
      r'''
class SampleRepository {
  int insertAndGetId() => 0;
}
''',
      [lint(27, 26)],
    );
  }

  void test_generatedStoreUpdateDestroy_doNotReport() async {
    await assertNoDiagnostics(r'''
class SampleRepository {
  Future<int> storeSample() async => 0;
  Future<void> updateSample() async {}
  Future<void> destroySample() async {}
}
''');
  }

  void test_saveLocales_isAllowed() async {
    await assertNoDiagnostics(r'''
class SampleRepository {
  Future<void> saveSampleLocales() async {}
  Future<void> saveSampleLocale() async {}
}
''');
  }
}

/// The same `save*` method outside a repository file is out of scope.
@reflectiveTest
class RepositoryNoSaveScopeTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = RepositoryNoSave();
    super.setUp();
  }

  @override
  String get testFileName => 'sample_service.dart';

  void test_saveMethod_outsideRepositoryFile_doesNotReport() async {
    await assertNoDiagnostics(r'''
class SampleRepository {
  void saveAll() {}
}
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(RepositoryNoSaveRuleTest);
    defineReflectiveTests(RepositoryNoSaveScopeTest);
  });
}
