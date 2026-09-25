import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

import 'package:foxy_lint/rules/file_scopes.dart';

/// Entity files must not import UI-layer packages.
class EntityNoFlutterImport extends AnalysisRule {
  static const LintCode code = LintCode(
    'entity_no_flutter_import',
    'Entity files must not import UI-layer packages.',
    correctionMessage: 'Remove the import from the Entity file.',
    severity: DiagnosticSeverity.WARNING,
  );

  EntityNoFlutterImport()
    : super(
        name: 'entity_no_flutter_import',
        description: 'Entity files must not import UI-layer packages.',
      );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addImportDirective(this, _Visitor(this, context));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final EntityNoFlutterImport rule;

  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitImportDirective(ImportDirective node) {
    if (!isEntityFile(context.definingUnit.file.path)) return;
    final uri = node.uri.stringValue ?? '';
    // The whole Flutter framework surface is UI-adjacent: an entity only
    // needs `package:meta` for annotations. `flutter/foundation` and
    // `flutter/services` were previously missing from the blocklist.
    if (uri.startsWith('package:flutter/') ||
        uri == 'dart:ui' ||
        uri.startsWith('package:foxy/page/') ||
        uri.startsWith('package:foxy/widget/') ||
        uri == 'package:signals_flutter/signals_flutter.dart') {
      rule.reportAtNode(node);
    }
  }
}
