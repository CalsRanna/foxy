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

  Directory dir(String relative) => Directory(p.join(root, relative))
    ..createSync(recursive: true);

  File dbc(String relative) => File(p.join(root, relative))
    ..createSync(recursive: true);

  test('标准位置 data/dbc 命中', () async {
    dbc('data/dbc/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), p.join(root, 'data', 'dbc'));
  });

  test('备选位置 dbc 命中', () async {
    dbc('dbc/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), p.join(root, 'dbc'));
  });

  test('深层目录递归命中', () async {
    dbc('x/y/data/dbc/Spell.dbc');
    expect(
      await ServerDirResolver.findDbcDir(root),
      p.join(root, 'x', 'y', 'data', 'dbc'),
    );
  });

  test('跳过 src/deps 等无关目录', () async {
    dbc('src/common/Spell.dbc');
    dbc('deps/engine/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), isNull);
  });

  test('data/dbc 存在但为空 → 继续递归搜索其他位置', () async {
    dir('data/dbc');
    dbc('custom/dbc/Spell.dbc');
    expect(
      await ServerDirResolver.findDbcDir(root),
      p.join(root, 'custom', 'dbc'),
    );
  });

  test('超过最大深度返回 null', () async {
    // a/b/c/d/e/f/g/h 为 8 层(根目录第 0 层,最大深度 6):g 之后不再深入
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
    expect(await ServerDirResolver.findDbcDir(root), p.join(root, 'a'));
  });
}
