import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  test('Dart checks comment tokens, including trailing and block comments', () {
    const source = r'''
/// 文档
const label = '// 中文界面'; // 行尾
const instructions = """
// 示例
## 助手提示词
""";
/* Block comment
   中文。 */
// 文件末尾
''';
    expect(_violations(_dartComments(source)).map((comment) => comment.line), [
      1,
      2,
      8,
      9,
    ]);
  });

  test('YAML checks hash comments outside quoted and block scalar data', () {
    const source = '''
name: "界面 #标题" # 行尾
id: ref#编号
run: |- # 块标题
  # 命令内容
  echo "中文"
description: '中文 #描述'
  # YAML 注释
# 独立注释
anchored: &note # 锚点注释
  >- # 折叠块标题
    # 数据内容
''';
    expect(_violations(_yamlComments(source)).map((comment) => comment.line), [
      1,
      3,
      7,
      8,
      9,
      10,
    ]);
  });

  test('Dart and YAML comments follow the English comment convention', () {
    final root = _git(['rev-parse', '--show-toplevel']).trimRight();
    final files = _trackedFiles(root, ['*.dart', '*.yaml', '*.yml']);
    final findings = <String>[];
    for (final path in files) {
      final file = File(p.join(root, path));
      if (!file.existsSync()) continue;
      final source = file.readAsStringSync();
      final comments = path.endsWith('.dart')
          ? _dartComments(source)
          : _yamlComments(source);
      for (final comment in _violations(comments)) {
        findings.add('$path:${comment.line}: ${comment.text.trim()}');
      }
    }
    expect(findings, isEmpty, reason: findings.join('\n'));
  });

  test(
    'Test description checks handle escapes, fragments, and interpolation',
    () {
      const source = r'''
void main() {
  group('\u4e2d', () {
    test('English test', () {
      expect('测试数据', '测试数据');
    });
    testWidgets('English prefix' '\u4e2d\u6587', (tester) async {});
    test('English ${fails ? '\u9519\u8bef' : 'result'}', () {});
  });
  for (final label in ['\u4e2d', 'English']) {
    test('$label variant', () {});
  }
}
''';
      expect(
        _dartTestDescriptionViolations(source).map((entry) => entry.line),
        [2, 6, 7, 9],
      );
    },
  );

  test('Dart test and group descriptions contain no Chinese text', () {
    final root = _git(['rev-parse', '--show-toplevel']).trimRight();
    final files = _trackedFiles(root, ['*.dart']).where(
      (path) =>
          p.posix.split(path).contains('test') || path.endsWith('_test.dart'),
    );
    final findings = <String>[];
    for (final path in files) {
      final file = File(p.join(root, path));
      if (!file.existsSync()) continue;
      for (final entry in _dartTestDescriptionViolations(
        file.readAsStringSync(),
      )) {
        findings.add('$path:${entry.line}: ${entry.text}');
      }
    }
    expect(findings, isEmpty, reason: findings.join('\n'));
  });
}

final _cjk = RegExp(
  r'[\p{Script=Han}\u3000-\u303F\uFF00-\uFFEF]',
  unicode: true,
);

final _yamlScalarPrefix = RegExp(r'(?:\s|[!&]\S+|#[^\r\n]*)*');

Iterable<_Comment> _dartComments(String source) sync* {
  final result = parseString(content: source, throwIfDiagnostics: false);
  for (
    Token? token = result.unit.beginToken;
    token != null;
    token = token.next
  ) {
    for (
      Token? comment = token.precedingComments;
      comment != null;
      comment = comment.next
    ) {
      final firstLine = result.lineInfo.getLocation(comment.offset).lineNumber;
      for (final (index, text) in LineSplitter.split(comment.lexeme).indexed) {
        yield (line: firstLine + index, text: text);
      }
    }
    if (token.isEof) break;
  }
}

Iterable<({int line, String text})> _dartTestDescriptionViolations(
  String source,
) {
  final result = parseString(content: source, throwIfDiagnostics: false);
  final findings = <({int line, String text})>[];
  result.unit.accept(
    _TestDescriptions((offset, value) {
      if (!_cjk.hasMatch(value)) return;
      findings.add((
        line: result.lineInfo.getLocation(offset).lineNumber,
        text: value,
      ));
    }),
  );
  return findings;
}

String _git(List<String> arguments, {String? workingDirectory}) {
  final result = Process.runSync(
    'git',
    arguments,
    workingDirectory: workingDirectory,
    stdoutEncoding: utf8,
  );
  expect(result.exitCode, 0, reason: '${result.stderr}');
  return result.stdout as String;
}

Iterable<String> _trackedFiles(String root, List<String> patterns) => _git([
  'ls-files',
  '-z',
  '--cached',
  '--others',
  '--exclude-standard',
  '--',
  ...patterns,
], workingDirectory: root).split('\u0000').where((path) => path.isNotEmpty);

Iterable<_Comment> _violations(Iterable<_Comment> comments) =>
    comments.where((comment) => _cjk.hasMatch(comment.text));

Iterable<_Comment> _yamlComments(String source) sync* {
  // Hide hash characters inside scalar values while preserving source lines.
  final masked = source.codeUnits.toList();
  for (final document in loadYamlDocuments(source)) {
    for (final scalar in _yamlScalars(document.contents)) {
      final span = scalar.span;
      // Skip anchors, tags, and any comments before the scalar value.
      var start = _yamlScalarPrefix
          .matchAsPrefix(source, span.start.offset)!
          .end;
      if (scalar.style == ScalarStyle.LITERAL ||
          scalar.style == ScalarStyle.FOLDED) {
        // The block scalar header can still have a real YAML comment.
        final headerEnd = source.indexOf('\n', start);
        if (headerEnd < 0) continue;
        start = headerEnd + 1;
      }
      for (var index = start; index < span.end.offset; index++) {
        if (masked[index] == 0x23) masked[index] = 0x20;
      }
    }
  }
  for (final (index, line) in LineSplitter.split(
    String.fromCharCodes(masked),
  ).indexed) {
    final hash = line.indexOf('#');
    if (hash >= 0) yield (line: index + 1, text: line.substring(hash));
  }
}

Iterable<YamlScalar> _yamlScalars(YamlNode node) sync* {
  if (node is YamlScalar) {
    yield node;
  } else if (node is YamlList) {
    for (final child in node.nodes) {
      yield* _yamlScalars(child);
    }
  } else if (node is YamlMap) {
    for (final entry in node.nodes.entries) {
      yield* _yamlScalars(entry.key as YamlNode);
      yield* _yamlScalars(entry.value);
    }
  }
}

typedef _Comment = ({int line, String text});

class _DescriptionText extends RecursiveAstVisitor<void> {
  final void Function(int, String) onText;

  _DescriptionText(this.onText);

  @override
  void visitInterpolationExpression(InterpolationExpression node) {
    final value = node.expression;
    if (value is SimpleIdentifier) {
      for (var parent = node.parent; parent != null; parent = parent.parent) {
        if (parent
            case ForStatement(
              forLoopParts: ForEachPartsWithDeclaration(
                :final loopVariable,
                iterable: ListLiteral(:final elements),
              ),
            )
            when loopVariable.name.lexeme == value.name) {
          for (final label in elements.whereType<SimpleStringLiteral>()) {
            onText(label.offset, label.value);
          }
          break;
        }
      }
    }
    super.visitInterpolationExpression(node);
  }

  @override
  void visitInterpolationString(InterpolationString node) =>
      onText(node.offset, node.value);

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) =>
      onText(node.offset, node.value);
}

class _TestDescriptions extends RecursiveAstVisitor<void> {
  static const _registrations = {'test', 'testWidgets', 'testGoldens', 'group'};

  final void Function(int, String) onText;

  _TestDescriptions(this.onText);

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final arguments = node.argumentList.arguments;
    if (_registrations.contains(node.methodName.name) && arguments.length > 1) {
      arguments.first.argumentExpression.accept(_DescriptionText(onText));
    }
    super.visitMethodInvocation(node);
  }
}
