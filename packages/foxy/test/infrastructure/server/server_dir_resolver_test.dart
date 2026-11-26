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

  test('Finds the standard data/dbc location', () async {
    dbc('data/dbc/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), expected('data/dbc'));
  });

  test('Finds the alternative dbc location', () async {
    dbc('dbc/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), expected('dbc'));
  });

  test('Finds DBC files in deeper directories', () async {
    dbc('x/y/data/dbc/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), expected('x/y/data/dbc'));
  });

  test('Skips unrelated directories such as src and deps', () async {
    dbc('src/common/Spell.dbc');
    dbc('deps/engine/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), isNull);
  });

  test('Continues searching when data/dbc exists but is empty', () async {
    dir('data/dbc');
    dbc('custom/dbc/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), expected('custom/dbc'));
  });

  test('Returns null beyond the maximum search depth', () async {
    // The root is depth zero and the limit is six, so traversal stops at g.
    dbc('a/b/c/d/e/f/g/h/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), isNull);
  });

  test('Returns null when no .dbc files exist', () async {
    dir('data');
    dir('bin');
    expect(await ServerDirResolver.findDbcDir(root), isNull);
  });

  test('Returns the first directory containing .dbc files, searching shallow directories first', () async {
    dbc('a/Spell.dbc');
    dbc('a/b/deep/Spell.dbc');
    expect(await ServerDirResolver.findDbcDir(root), expected('a'));
  });
}
