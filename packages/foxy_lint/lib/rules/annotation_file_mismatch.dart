import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:path/path.dart' as p;

/// A class carrying a `@Foxy*` codegen annotation must live in a file whose
/// name matches the layer's `generate_for` glob
/// (`**_entity.dart` / `**_repository.dart` / `**_view_model.dart`).
///
/// The builders only run on files matching those globs, so a class that
/// lands in a differently-named file is silently skipped — no code is
/// generated and no error is raised. This rule turns that silence into a
/// diagnostic.
class AnnotationFileMismatch extends AnalysisRule {
  static const LintCode code = LintCode(
    'annotation_file_mismatch',
    'Classes annotated with {0} must live in a {1} file (the generator '
        'glob), or the builder silently skips them.',
    correctionMessage:
        'Move the class to a file matching the glob, e.g. '
            '<snake_case>_entity.dart.',
    severity: DiagnosticSeverity.WARNING,
  );

  AnnotationFileMismatch()
      : super(
          name: 'annotation_file_mismatch',
          description:
              'Annotated classes must live in the file pattern the code '
                  'generator scans.',
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

/// Annotation name → (expected file-name suffix, glob shown in the message).
///
/// Mirrors the `generate_for` globs in `packages/foxy/build.yaml`: the
/// generators scan `lib/entity/**_entity.dart`, `lib/repository/**
/// _repository.dart` and `lib/view_model/**_view_model.dart`.
const _expectedFileName = <String, (String, String)>{
  'FoxyBriefEntity': ('_entity.dart', '**_entity.dart'),
  'FoxyFullEntity': ('_entity.dart', '**_entity.dart'),
  'FoxyRepository': ('_repository.dart', '**_repository.dart'),
  'FoxyListViewModel': ('_view_model.dart', '**_view_model.dart'),
  'FoxyDetailViewModel': ('_view_model.dart', '**_view_model.dart'),
  'FoxyLinkedListViewModel': ('_view_model.dart', '**_view_model.dart'),
  'FoxyLinkedDetailViewModel': ('_view_model.dart', '**_view_model.dart'),
};

class _Visitor extends SimpleAstVisitor<void> {
  final AnnotationFileMismatch rule;

  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    for (final metadata in node.metadata) {
      final expectation = _expectedFileName[metadata.name.name];
      if (expectation == null) continue;
      final (suffix, glob) = expectation;
      final fileName = p.basename(context.definingUnit.file.path);
      if (fileName.endsWith(suffix)) return;
      rule.reportAtNode(node, arguments: [metadata.name.name, glob]);
    }
  }
}
