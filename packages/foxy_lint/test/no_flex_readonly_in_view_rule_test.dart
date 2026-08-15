// ignore_for_file: non_constant_identifier_names

import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:foxy_lint/rules/no_flex_readonly_in_view.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

/// Tests the real NoFlexInView rule through the official analyzer_testing
/// harness. Scope comes from the probed file name (`sample_view.dart`).
/// Flutter widgets do not resolve in the harness's test package, so minimal
/// stubs stand in for the real constructors (subclassing `Widget` so the
/// `build` return types stay valid).
@reflectiveTest
class NoFlexInViewRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = NoFlexInView();
    super.setUp();
  }

  @override
  String get testFileName => 'sample_view.dart';

  void test_flexArgument_reports() async {
    await assertDiagnostics(
      r'''
class Expanded extends Widget {
  const Expanded({int flex = 1});
}
class Widget {
  const Widget();
}

Widget build() => Expanded(flex: 2);
''',
      [lint(131, 7)],
    );
  }

  void test_noFlexArgument_doesNotReport() async {
    await assertNoDiagnostics(r'''
class Expanded extends Widget {
  const Expanded({int flex = 1});
}
class Widget {
  const Widget();
}

Widget build() => Expanded();
''');
  }
}

/// Tests the real NoReadOnlyInView rule (same file, second rule).
@reflectiveTest
class NoReadOnlyInViewRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = NoReadOnlyInView();
    super.setUp();
  }

  @override
  String get testFileName => 'sample_view.dart';

  void test_readOnlyTrue_reports() async {
    await assertDiagnostics(
      r'''
class TextField extends Widget {
  const TextField({bool readOnly = false});
}
class Widget {
  const Widget();
}

Widget build() => TextField(readOnly: true);
''',
      [lint(143, 14)],
    );
  }

  void test_readOnlyFalse_doesNotReport() async {
    await assertNoDiagnostics(r'''
class TextField extends Widget {
  const TextField({bool readOnly = false});
}
class Widget {
  const Widget();
}

Widget build() => TextField(readOnly: false);
''');
  }
}

/// The same constructs in a non-view file are out of scope.
@reflectiveTest
class NoFlexReadOnlyScopeTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = NoFlexInView();
    super.setUp();
  }

  @override
  String get testFileName => 'sample_util.dart';

  void test_flexAndReadOnly_outsideViewFile_doNotReport() async {
    await assertNoDiagnostics(r'''
class Expanded extends Widget {
  const Expanded({int flex = 1});
}
class TextField extends Widget {
  const TextField({bool readOnly = false});
}
class Widget {
  const Widget();
}

Widget build() => Expanded(flex: 2);

Widget input() => TextField(readOnly: true);
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(NoFlexInViewRuleTest);
    defineReflectiveTests(NoReadOnlyInViewRuleTest);
    defineReflectiveTests(NoFlexReadOnlyScopeTest);
  });
}
