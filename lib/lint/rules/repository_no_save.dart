import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'file_scopes.dart';

const _code = LintCode(
  name: 'repository_no_save',
  problemMessage: 'Repository 禁止手写 save*/insertAndGetId，使用 store*/update*/destroy*',
);

class RepositoryNoSave extends DartLintRule {
  const RepositoryNoSave() : super(code: _code);

  @override
  void run(CustomLintResolver resolver, DiagnosticReporter reporter, CustomLintContext context) {
    if (!isRepositoryFile(resolver.path)) return;

    context.registry.addMethodDeclaration((node) {
      final parent = node.parent;
      if (parent is! ClassDeclaration) return;
      if (!parent.name.lexeme.endsWith('Repository')) return;

      final name = node.name.lexeme;
      if ((name.startsWith('save') || name == 'insertAndGetId') &&
          !name.endsWith('Locales') &&
          !name.endsWith('Locale')) {
        reporter.atNode(node, _code);
      }
    });
  }
}
