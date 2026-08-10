import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:path/path.dart' as p;

/// A namespace class (containing only static members — constants or
/// helpers, typically `abstract final class`) must be named after its file
/// (`quest_flags.dart` → `QuestFlags`).
///
/// This keeps the namespace/class mapping predictable: the class name is
/// derivable from the file name, and a class that drifts from its file
/// name is a sign it belongs elsewhere.
class ClassFileNameMatch extends AnalysisRule {
  static const LintCode code = LintCode(
    'class_file_name_match',
    'The class name must match its file name (PascalCase of the file).',
    correctionMessage:
        'Rename the class to the PascalCase of the file name (e.g. '
            '`quest_flags.dart` → `QuestFlags`), or move the class to a '
            'matching file.',
    severity: DiagnosticSeverity.WARNING,
  );

  ClassFileNameMatch()
      : super(
          name: 'class_file_name_match',
          description:
              'Namespace classes must be named after their file name.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addClassDeclaration(this, _Visitor(this, context));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final ClassFileNameMatch rule;

  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    // Only namespace classes (all-static, no instance fields/methods).
    var hasInstanceMember = false;
    for (final member in node.members) {
      if (member is FieldDeclaration && !member.isStatic) {
        hasInstanceMember = true;
        break;
      }
      if (member is MethodDeclaration && !member.isStatic) {
        hasInstanceMember = true;
        break;
      }
      if (member is ConstructorDeclaration) {
        hasInstanceMember = true;
        break;
      }
    }
    if (hasInstanceMember) return;

    final className = node.name.lexeme;
    final fileName = p.basenameWithoutExtension(context.definingUnit.file.path);
    final expected = _pascalCase(fileName);
    if (className != expected) {
      rule.reportAtNode(node);
    }
  }

  static String _pascalCase(String snakeCase) =>
      snakeCase.split('_').map((w) {
        if (w.isEmpty) return w;
        return w[0].toUpperCase() + w.substring(1);
      }).join();
}
