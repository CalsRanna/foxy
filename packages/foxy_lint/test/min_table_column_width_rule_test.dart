// ignore_for_file: non_constant_identifier_names

import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:foxy_lint/rules/min_table_column_width.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

/// Tests the real MinTableColumnWidth rule through the official
/// analyzer_testing harness. Stub column constructors stand in for the real
/// widgets (the harness does not resolve package imports).
@reflectiveTest
class MinTableColumnWidthRuleTest extends AnalysisRuleTest {
  @override
  void setUp() {
    rule = MinTableColumnWidth();
    super.setUp();
  }

  @override
  String get testFileName => 'sample_view.dart';

  void test_narrowFixedColumn_reports() async {
    await assertDiagnostics(
      r'''
class FoxyTableColumn {
  const FoxyTableColumn.fixed({int width = 120});
}

FoxyTableColumn build() => FoxyTableColumn.fixed(width: 80);
''',
      [lint(126, 9)],
    );
  }

  void test_narrowPickerColumn_reports() async {
    await assertDiagnostics(
      r'''
class FoxyEntityPickerColumn {
  const FoxyEntityPickerColumn({int width = 120});
}

FoxyEntityPickerColumn build() => FoxyEntityPickerColumn(width: 100);
''',
      [lint(142, 10)],
    );
  }

  void test_widthAtLeast120_doesNotReport() async {
    await assertNoDiagnostics(r'''
class FoxyTableColumn {
  const FoxyTableColumn.fixed({int width = 120});
}

FoxyTableColumn build() => FoxyTableColumn.fixed(width: 120);

FoxyTableColumn wide() => FoxyTableColumn.fixed(width: 240);
''');
  }

  void test_otherConstructors_doNotReport() async {
    await assertNoDiagnostics(r'''
class FoxyTableColumn {
  const FoxyTableColumn.fixed({int width = 120});
  const FoxyTableColumn.flex({int width = 80});
}

FoxyTableColumn build() => FoxyTableColumn.flex(width: 80);
''');
  }
}

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(MinTableColumnWidthRuleTest);
  });
}
