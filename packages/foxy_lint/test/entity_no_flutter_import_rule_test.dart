// ignore_for_file: non_constant_identifier_names

import 'package:analyzer/error/error.dart' show DiagnosticCode, diagnosticCodeValues;
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:foxy_lint/rules/entity_no_flutter_import.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

/// The blocked package URIs do not resolve in the harness's test package,
/// so positive cases also expect the `uri_does_not_exist` compile error
/// (resolved from the public [diagnosticCodeValues] list).
DiagnosticCode _uriDoesNotExist() => diagnosticCodeValues.firstWhere(
      (code) => code.lowerCaseUniqueName == 'uri_does_not_exist',
    );

/// Tests the real EntityNoFlutterImport rule through the official
/// analyzer_testing harness. Scope comes from the probed file name
/// (`sample_entity.dart`). Blocked package URIs do not resolve in the
/// harness's test package, so each positive case also carries the
/// corresponding `uriDoesNotExist` compile error.
@reflectiveTest
class EntityNoFlutterImportRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = EntityNoFlutterImport();
    super.setUp();
  }

  @override
  String get testFileName => 'sample_entity.dart';

  void test_flutterMaterialImport_reports() async {
    await assertDiagnostics(
      r'''
import 'package:flutter/material.dart';
''',
      [
        lint(0, 39),
        error(_uriDoesNotExist(), 7, 31),
      ],
    );
  }

  void test_dartUiImport_reports() async {
    await assertDiagnostics(
      r'''
import 'dart:ui';
''',
      [
        lint(0, 17),
        error(_uriDoesNotExist(), 7, 9),
      ],
    );
  }

  void test_signalsFlutterImport_reports() async {
    await assertDiagnostics(
      r'''
import 'package:signals_flutter/signals_flutter.dart';
''',
      [
        lint(0, 54),
        error(_uriDoesNotExist(), 7, 46),
      ],
    );
  }

  void test_widgetImport_reports() async {
    await assertDiagnostics(
      r'''
import 'package:foxy/widget/foxy_tab.dart';
''',
      [
        lint(0, 43),
        error(_uriDoesNotExist(), 7, 35),
      ],
    );
  }

  void test_nonUiImport_doesNotReport() async {
    await assertNoDiagnostics(r'''
import 'dart:async';

Future<void> f() async {}
''');
  }
}

/// The same blocked import in a non-entity file is out of scope: only the
/// unresolved-URI compile error remains.
@reflectiveTest
class EntityNoFlutterImportScopeTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = EntityNoFlutterImport();
    super.setUp();
  }

  @override
  String get testFileName => 'sample_util.dart';

  void test_flutterImport_outsideEntityFile_doesNotReport() async {
    await assertDiagnostics(
      r'''
import 'package:flutter/material.dart';
''',
      [error(_uriDoesNotExist(), 7, 31)],
    );
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(EntityNoFlutterImportRuleTest);
    defineReflectiveTests(EntityNoFlutterImportScopeTest);
  });
}
