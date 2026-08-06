import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'package:foxy_lint/rules/file_scopes.dart';

const _code = LintCode(
  name: 'entity_no_flutter_import',
  problemMessage: 'Entity 文件禁止导入 UI 层的包',
);

class EntityNoFlutterImport extends DartLintRule {
  const EntityNoFlutterImport() : super(code: _code);

  @override
  void run(CustomLintResolver resolver, DiagnosticReporter reporter, CustomLintContext context) {
    if (!isEntityFile(resolver.path)) return;

    context.registry.addImportDirective((node) {
      final uri = node.uri.stringValue ?? '';
      if (uri.startsWith('package:flutter/material') ||
          uri.startsWith('package:flutter/widgets') ||
          uri.startsWith('package:flutter/rendering') ||
          uri == 'dart:ui' ||
          uri.startsWith('package:foxy/page/') ||
          uri.startsWith('package:foxy/widget/') ||
          uri == 'package:signals_flutter/signals_flutter.dart') {
        reporter.atNode(node, _code);
      }
    });
  }
}
