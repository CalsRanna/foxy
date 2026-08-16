import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

/// Table columns must declare a fixed width of at least 120; narrower
/// columns truncate labels and content in the FoxyDataTable layout.
class MinTableColumnWidth extends AnalysisRule {
  static const LintCode code = LintCode(
    'min_table_column_width',
    'Table columns must have a width of at least 120.',
    correctionMessage: 'Set the column width to at least 120.',
    severity: DiagnosticSeverity.WARNING,
  );

  MinTableColumnWidth()
      : super(
          name: 'min_table_column_width',
          description: 'Table columns must have a width of at least 120.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addInstanceCreationExpression(
      this,
      _ColumnWidthVisitor(this, context),
    );
  }
}

class _ColumnWidthVisitor extends SimpleAstVisitor<void> {
  final MinTableColumnWidth rule;

  final RuleContext context;

  _ColumnWidthVisitor(this.rule, this.context);

  static const _minWidth = 120;

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    final constructor = node.constructorName;
    final typeName = constructor.type.name.lexeme;
    final constructorName = constructor.name?.name;
    final isFixedTableColumn =
        typeName == 'FoxyTableColumn' && constructorName == 'fixed';
    final isPickerColumn =
        typeName == 'FoxyEntityPickerColumn' && constructorName == null;
    if (!isFixedTableColumn && !isPickerColumn) return;

    for (final argument in node.argumentList.arguments) {
      if (argument is! NamedExpression) continue;
      if (argument.name.label.name != 'width') continue;
      final value = argument.expression;
      if (value is! IntegerLiteral) continue;
      final width = value.value;
      if (width == null || width < _minWidth) {
        rule.reportAtNode(argument);
      }
    }
  }
}
