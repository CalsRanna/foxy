import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

final _cjk = RegExp(
  r'[\p{Script=Han}\u3000-\u303F\uFF00-\uFFEF]',
  unicode: true,
);
final _yamlScalarPrefix = RegExp(r'(?:\s|[!&]\S+|#[^\r\n]*)*');

typedef _Comment = ({int line, String text});

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
    final files = _git([
      'ls-files',
      '-z',
      '--cached',
      '--others',
      '--exclude-standard',
      '--',
      '*.dart',
      '*.yaml',
      '*.yml',
    ], workingDirectory: root).split('\u0000').where((path) => path.isNotEmpty);
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

Iterable<_Comment> _violations(Iterable<_Comment> comments) =>
    comments.where((comment) => _cjk.hasMatch(comment.text));

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
