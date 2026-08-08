// ignore_for_file: non_constant_identifier_names

import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:foxy_lint/rules/annotation_file_mismatch.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

/// Tests the real AnnotationFileMismatch rule through the official
/// analyzer_testing harness (AnalysisRuleTest).
///
/// The probed file is named `spell_entity.dart` (matching the entity
/// glob): an `@FoxyFullEntity` class must not report, while repository and
/// view-model annotations in that file must.
@reflectiveTest
class AnnotationFileMismatchRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = AnnotationFileMismatch();
    super.setUp();
  }

  @override
  String get testFileName => 'spell_entity.dart';

  void test_entityAnnotation_inEntityFile_doesNotReport() async {
    await assertNoDiagnostics(r'''
class FoxyFullEntity {
  const FoxyFullEntity({this.table});
  final String? table;
}

@FoxyFullEntity(table: 'spell')
class SpellEntity {}
''');
  }

  void test_repositoryAnnotation_inEntityFile_reports() async {
    await assertDiagnostics(
      r'''
class FoxyRepository {
  const FoxyRepository();
}

@FoxyRepository()
class SpellRepository {}
''',
      [
        lint(52, 42),
      ],
    );
  }

  void test_viewModelAnnotation_inEntityFile_reports() async {
    await assertDiagnostics(
      r'''
class FoxyListViewModel {
  const FoxyListViewModel();
}

@FoxyListViewModel()
class SpellListViewModel {}
''',
      [
        lint(58, 48),
      ],
    );
  }

  void test_unannotatedClass_doesNotReport() async {
    await assertNoDiagnostics(r'''
class PlainHelper {}
''');
  }
}

/// The probed file is `test.dart` (matching no generator glob): every
/// `@Foxy*` annotation must report.
@reflectiveTest
class AnnotationFileMismatchMismatchedFileTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = AnnotationFileMismatch();
    super.setUp();
  }

  void test_entityAnnotation_inPlainFile_reports() async {
    await assertDiagnostics(
      r'''
class FoxyFullEntity {
  const FoxyFullEntity({this.table});
  final String? table;
}

@FoxyFullEntity(table: 'spell')
class SpellEntity {}
''',
      [
        lint(87, 52),
      ],
    );
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(AnnotationFileMismatchRuleTest);
    defineReflectiveTests(AnnotationFileMismatchMismatchedFileTest);
  });
}
