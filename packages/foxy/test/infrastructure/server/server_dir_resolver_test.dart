import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/server/server_dir_resolver.dart';
import 'package:path/path.dart' as p;

void main() {
  late Directory tempDir;
  late String root;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_server_resolver_');
    root = tempDir.path;
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  Directory dir(String relative) =>
      Directory(p.join(root, relative))..createSync(recursive: true);

  File dbc(String relative) =>
      File(p.join(root, relative))..createSync(recursive: true);

  /// Expected path based on how directory traversal returns paths.
  /// Appends the segments to the root and normalizes the result to preserve
  /// the forward slashes returned by discovery on Windows.
  String expected(String relative) => p.normalize('$root/$relative');

  test('标准位置 data/dbc 命中', () async {
    dbc('data/dbc/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), expected('data/dbc'));
  });

  test('备选位置 dbc 命中', () async {
    dbc('dbc/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), expected('dbc'));
  });

  test('深层目录递归命中', () async {
    dbc('x/y/data/dbc/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), expected('x/y/data/dbc'));
  });

  test('跳过 src/deps 等无关目录', () async {
    dbc('src/common/Spell.dbc');
    dbc('deps/engine/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), isNull);
  });

  test('data/dbc 存在但为空 → 继续递归搜索其他位置', () async {
    dir('data/dbc');
    dbc('custom/dbc/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), expected('custom/dbc'));
  });

  test('超过最大深度返回 null', () async {
    // The root is depth zero and the limit is six, so traversal stops at g.
    dbc('a/b/c/d/e/f/g/h/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), isNull);
  });

  test('无任何 .dbc 文件返回 null', () async {
    dir('data');
    dir('bin');
    expect(await ServerDirResolver.findDbcDir(root), isNull);
  });

  test('返回第一个含 .dbc 的目录(先浅后深)', () async {
    dbc('a/Spell.dbc');
    dbc('a/b/deep/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), expected('a'));
  });
}
