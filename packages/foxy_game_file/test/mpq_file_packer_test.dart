import 'dart:io';

import 'package:foxy_game_file/foxy_game_file.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:warcrafty/warcrafty.dart';

void main() {
  late Directory temp;
  late Directory source;
  late String target;

  setUp(() {
    temp = Directory.systemTemp.createTempSync('foxy_mpq_packer_');
    source = Directory(p.join(temp.path, 'source'))..createSync();
    target = p.join(temp.path, 'patch.mpq');
  });

  tearDown(() => temp.deleteSync(recursive: true));

  test('打包合法 DBC 后可通过 MPQ 读取接口取回相同字节', () async {
    await DbcFileWriter().write(
      schema: Definitions.spellDuration,
      rows: const [
        {'ID': 1, 'Duration': -1, 'DurationPerLevel': 0, 'MaxDuration': 10},
      ],
      outputDirectory: source.path,
    );
    File(p.join(source.path, 'notes.txt')).writeAsStringSync('ignored');
    final packed = await MpqFilePacker.packDbcFiles(
      directory: source.path,
      mpqFilePath: target,
      isCancelled: () => false,
    );
    expect(packed, 1);
    final archive = WarcraftyMpqSource(target);
    try {
      expect(archive.files, contains(r'DBFilesClient\SpellDuration.dbc'));
      expect(archive.files, isNot(contains(r'DBFilesClient\notes.txt')));
      expect(
        archive.extract(r'DBFilesClient\SpellDuration.dbc'),
        File(p.join(source.path, 'SpellDuration.dbc')).readAsBytesSync(),
      );
    } finally {
      archive.close();
    }
  });

  test('按文件名排序打包并替换已有目标', () async {
    File(target).writeAsStringSync('old archive');
    File(p.join(source.path, 'B.dbc')).writeAsBytesSync([2]);
    File(p.join(source.path, 'A.dbc')).writeAsBytesSync([1]);
    final progress = <(String, int, int)>[];
    final packed = await MpqFilePacker.packDbcFiles(
      directory: source.path,
      mpqFilePath: target,
      isCancelled: () => false,
      onProgress: (file, completed, total, _, _) =>
          progress.add((file, completed, total)),
    );
    expect(packed, 2);
    expect(progress, [('A.dbc', 1, 2), ('B.dbc', 2, 2)]);
    final archive = WarcraftyMpqSource(target);
    try {
      expect(archive.extract(r'DBFilesClient\A.dbc'), [1]);
      expect(archive.extract(r'DBFilesClient\B.dbc'), [2]);
    } finally {
      archive.close();
    }
    expect(
      temp.listSync().where((file) => file.path.contains('.foxy.')),
      isEmpty,
    );
  });

  test('中途取消保留已有目标并清理临时文件', () async {
    File(target).writeAsStringSync('original');
    File(p.join(source.path, 'A.dbc')).writeAsBytesSync([1]);
    File(p.join(source.path, 'B.dbc')).writeAsBytesSync([2]);
    var cancelled = false;
    final packed = await MpqFilePacker.packDbcFiles(
      directory: source.path,
      mpqFilePath: target,
      isCancelled: () => cancelled,
      onProgress: (_, _, _, _, _) => cancelled = true,
    );
    expect(packed, 1);
    expect(File(target).readAsStringSync(), 'original');
    expect(
      temp.listSync().where((file) => file.path.contains('.foxy.')),
      isEmpty,
    );
  });

  test('空目录不生成归档', () async {
    expect(
      await MpqFilePacker.packDbcFiles(
        directory: source.path,
        mpqFilePath: target,
        isCancelled: () => false,
      ),
      0,
    );
    expect(File(target).existsSync(), isFalse);
  });

  test('源目录不存在时抛文件异常', () async {
    await expectLater(
      MpqFilePacker.packDbcFiles(
        directory: p.join(temp.path, 'missing'),
        mpqFilePath: target,
        isCancelled: () => false,
      ),
      throwsA(isA<FileSystemException>()),
    );
  });
}
