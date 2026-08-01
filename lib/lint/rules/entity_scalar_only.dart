import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'file_scopes.dart';

const _code = LintCode(
  name: 'entity_scalar_only',
  problemMessage: 'Entity 字段必须是标量类型 (int/double/String/bool)，禁止使用 {0}',
);

class EntityScalarOnly extends DartLintRule {
  const EntityScalarOnly() : super(code: _code);

  @override
  void run(CustomLintResolver resolver, DiagnosticReporter reporter, CustomLintContext context) {
    if (!isEntityFile(resolver.path)) return;

    context.registry.addFieldDeclaration((node) {
      final parent = node.parent;
      if (parent is! ClassDeclaration) return;
      if (!parent.name.lexeme.endsWith('Entity')) return;
      final type = node.fields.type;
      if (type is! NamedType) return;
      if (!const {'List', 'Map', 'Set'}.contains(type.name.lexeme)) return;

      reporter.atNode(node, _code);
    });
  }
}
