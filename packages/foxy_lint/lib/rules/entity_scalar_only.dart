import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import 'package:foxy_lint/rules/file_scopes.dart';

/// Entity fields must be scalar types (int/double/String/bool); collection
/// types must be split into explicit per-column fields.
class EntityScalarOnly extends AnalysisRule {
  static const LintCode code = LintCode(
    'entity_scalar_only',
    'Entity fields must be scalar types (int/double/String/bool); got {0}.',
    correctionMessage: 'Split the collection into explicit per-column fields.',
    severity: DiagnosticSeverity.WARNING,
  );

  EntityScalarOnly()
      : super(
          name: 'entity_scalar_only',
          description:
              'Entity fields must be scalar types; collection types are '
                  'not allowed.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addFieldDeclaration(this, _Visitor(this, context));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final EntityScalarOnly rule;

  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    if (!isEntityFile(context.definingUnit.file.path)) return;
    // Members sit inside a BlockClassBody in the analyzer 10.x AST; older
    // analyzers expose the class directly as the field's parent, so both
    // shapes are tolerated.
    final parent = node.parent;
    ClassDeclaration? enclosingClass;
    if (parent is ClassDeclaration) {
      enclosingClass = parent;
    } else if (parent is BlockClassBody && parent.parent is ClassDeclaration) {
      enclosingClass = parent.parent as ClassDeclaration;
    }
    if (enclosingClass == null) return;
    if (!enclosingClass.namePart.typeName.lexeme.endsWith('Entity')) return;
    final type = node.fields.type;
    if (type is! NamedType) return;
    if (!const {'List', 'Map', 'Set'}.contains(type.name.lexeme)) return;

    rule.reportAtNode(node, arguments: [type.name.lexeme]);
  }
}
