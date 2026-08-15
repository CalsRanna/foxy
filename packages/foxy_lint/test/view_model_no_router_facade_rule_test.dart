// ignore_for_file: non_constant_identifier_names

import 'package:analyzer/error/error.dart' show DiagnosticCode, diagnosticCodeValues;
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:foxy_lint/rules/view_model_no_router_facade.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

/// The blocked URI does not resolve in the harness's test package, so the
/// positive case also expects the `uri_does_not_exist` compile error.
DiagnosticCode _uriDoesNotExist() => diagnosticCodeValues.firstWhere(
      (code) => code.lowerCaseUniqueName == 'uri_does_not_exist',
    );

/// Tests the real ViewModelNoRouterFacade rule through the official
/// analyzer_testing harness. Scope comes from the probed file name
/// (`sample_list_view_model.dart`). The blocked URI does not resolve in the
/// harness's test package, so the positive case also carries the
/// `uriDoesNotExist` compile error.
@reflectiveTest
class ViewModelNoRouterFacadeRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = ViewModelNoRouterFacade();
    super.setUp();
  }

  @override
  String get testFileName => 'sample_list_view_model.dart';

  void test_routerFacadeImport_reports() async {
    await assertDiagnostics(
      r'''
import 'package:foxy/router/router_facade.dart';
''',
      [
        lint(0, 48),
        error(_uriDoesNotExist(), 7, 40),
      ],
    );
  }

  void test_routerImport_doesNotReport() async {
    await assertNoDiagnostics(r'''
import 'dart:async';

Future<void> f() async {}
''');
  }
}

/// The same import in a view file is out of scope: only the unresolved-URI
/// compile error remains.
@reflectiveTest
class ViewModelNoRouterFacadeScopeTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = ViewModelNoRouterFacade();
    super.setUp();
  }

  @override
  String get testFileName => 'sample_view.dart';

  void test_routerFacadeImport_outsideViewModelFile_doesNotReport() async {
    await assertDiagnostics(
      r'''
import 'package:foxy/router/router_facade.dart';
''',
      [error(_uriDoesNotExist(), 7, 40)],
    );
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ViewModelNoRouterFacadeRuleTest);
    defineReflectiveTests(ViewModelNoRouterFacadeScopeTest);
  });
}
