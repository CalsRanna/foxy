import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:path/path.dart' as p;

final _violations = <String>[];

void main() {
  final root = Directory.current.path;
  final dartFiles = <File>[];

  for (final dir in ['lib/entity', 'lib/repository', 'lib/page', 'lib/widget']) {
    final directory = Directory(p.join(root, dir));
    if (!directory.existsSync()) continue;
    for (final file in directory.listSync(recursive: true)) {
      if (file is File && file.path.endsWith('.dart') && !file.path.endsWith('.g.dart')) {
        dartFiles.add(file);
      }
    }
  }

  for (final file in dartFiles) {
    final source = file.readAsStringSync();
    final relativePath = p.relative(file.path, from: root);
    final result = parseString(content: source, featureSet: FeatureSet.latestLanguageVersion());

    if (result.errors.isNotEmpty) continue;

    final unit = result.unit;
    final visitor = _FoxyVisitor(relativePath, source);
    unit.accept(visitor);
  }

  if (_violations.isEmpty) {
    stdout.writeln('OK — 所有约束通过');
    return;
  }

  _violations.sort();
  for (final v in _violations) {
    stderr.writeln(v);
  }
  stderr.writeln('\n${_violations.length} 个违规');
  exit(1);
}

class _FoxyVisitor extends RecursiveAstVisitor<void> {
  final String path;
  final String source;
  final bool _isEntity;
  final bool _isRepository;
  final bool _isViewModel;
  final bool _isView;

  _FoxyVisitor(this.path, this.source)
    : _isEntity = (path.contains(RegExp(r'[/\\]entity[/\\]')) || p.basename(path).endsWith('_entity.dart')) &&
          !_isEntityUtility(path),
      _isRepository = p.basename(path).endsWith('_repository.dart'),
      _isViewModel = _checkViewModel(path),
      _isView = p.basename(path).endsWith('_view.dart');

  static final _entityUtilities = {
    'dbc_locale.dart',
    'dbc_locale_field_definition.dart',
  };

  static bool _isEntityUtility(String path) {
    return _entityUtilities.contains(p.basename(path));
  }

  static bool _checkViewModel(String path) {
    final name = p.basename(path);
    return name.contains('_view_model.dart') ||
        name.contains('collection_editor_view_model.dart') ||
        name.contains('single_editor_view_model.dart') ||
        name.contains('detail_view_model.dart') ||
        name.contains('list_view_model.dart') ||
        name.contains('read_view_model.dart') ||
        name.contains('workflow_view_model.dart') ||
        name.contains('state_view_model.dart');
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final className = node.name.lexeme;

    if (_isEntity && className.endsWith('Entity')) {
      for (final member in node.members) {
        if (member is FieldDeclaration) {
          _checkEntityField(member, className);
        }
      }
    }

    if (_isRepository && className.endsWith('Repository')) {
      for (final member in node.members) {
        if (member is MethodDeclaration) {
          _checkRepositoryMethod(member, className);
        }
      }
    }

    super.visitClassDeclaration(node);
  }

  void _checkEntityField(FieldDeclaration field, String className) {
    final type = field.fields.type;
    if (type == null) return;
    final typeName = _typeName(type);
    if (typeName == null) return;

    if (const {'List', 'Map', 'Set'}.contains(typeName)) {
      final line = _lineNumber(field.offset);
      _violations.add('$path:$line: entity_scalar_only — $className 字段禁止使用 $typeName 类型');
    }
  }

  void _checkRepositoryMethod(MethodDeclaration method, String className) {
    final methodName = method.name.lexeme;
    if ((methodName.startsWith('save') || methodName == 'insertAndGetId') &&
        !methodName.endsWith('Locales') &&
        !methodName.endsWith('Locale')) {
      final line = _lineNumber(method.name.offset);
      _violations.add('$path:$line: repository_no_save — $className 禁止手写 $methodName');
    }
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (_isEntity || _isViewModel || _isView) {
      if (node.methodName.name == 'generate') {
        final target = node.target;
        if (target is Identifier && target.name == 'List') {
          final line = _lineNumber(node.offset);
          _violations.add('$path:$line: no_collection_loops — 禁止使用 List.generate');
        }
      }
    }
    super.visitMethodInvocation(node);
  }

  @override
  void visitForStatement(ForStatement node) {
    if (_isEntity || _isViewModel || _isView) {
      final line = _lineNumber(node.offset);
      _violations.add('$path:$line: no_collection_loops — 禁止使用 for 循环');
    }
    super.visitForStatement(node);
  }

  @override
  void visitImportDirective(ImportDirective node) {
    final uri = node.uri.stringValue ?? '';

    if (_isEntity) {
      if (uri.startsWith('package:flutter/material') ||
          uri.startsWith('package:flutter/widgets') ||
          uri.startsWith('package:flutter/rendering') ||
          uri == 'dart:ui' ||
          uri.startsWith('package:foxy/page/') ||
          uri.startsWith('package:foxy/widget/') ||
          uri == 'package:signals_flutter/signals_flutter.dart') {
        final line = _lineNumber(node.offset);
        _violations.add('$path:$line: entity_no_flutter_import — Entity 禁止导入 $uri');
      }
    }

    if (_isViewModel && uri.contains('router_facade.dart')) {
      final line = _lineNumber(node.offset);
      _violations.add('$path:$line: viewmodel_no_router_facade — ViewModel 禁止导入 RouterFacade');
    }

    super.visitImportDirective(node);
  }

  @override
  void visitNamedExpression(NamedExpression node) {
    if (!_isView) {
      super.visitNamedExpression(node);
      return;
    }

    final label = node.name.label.name;
    if (label == 'flex') {
      final line = _lineNumber(node.offset);
      _violations.add('$path:$line: no_flex_in_view — View 禁止使用 flex:');
    } else if (label == 'readOnly') {
      final expression = node.expression;
      if (expression is BooleanLiteral && expression.value) {
        final line = _lineNumber(node.offset);
        _violations.add('$path:$line: no_readonly_in_view — View 禁止使用 readOnly: true');
      }
    }

    super.visitNamedExpression(node);
  }

  String? _typeName(TypeAnnotation type) {
    if (type is NamedType) return type.name.lexeme;
    return null;
  }

  int _lineNumber(int offset) {
    return '\n'.allMatches(source.substring(0, offset)).length + 1;
  }
}
