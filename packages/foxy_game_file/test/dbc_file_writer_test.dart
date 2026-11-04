import 'dart:io';

import 'package:test/test.dart';
import 'package:foxy_game_file/foxy_game_file.dart';
import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';

void main() {
  late Directory directory;
  late DbcSchema schema;
  late DbcFileWriter util;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('foxy_dbc_export_test_');
    schema = Definitions.spellDuration;
    util = DbcFileWriter();
  });

  tearDown(() async {
    if (await directory.exists()) await directory.delete(recursive: true);
  });

  Map<String, dynamic> sampleRow({
    int id = 1,
    int duration = 1000,
    int durationPerLevel = 25,
    int maxDuration = 2000,
  }) {
    return {
      'ID': id,
      'Duration': duration,
      'DurationPerLevel': durationPerLevel,
      'MaxDuration': maxDuration,
    };
  }

  test('DbcFileWriter 写入后可以使用 warcrafty 回读', () async {
    await util.write(
      schema: schema,
      rows: [sampleRow()],
      outputDirectory: directory.path,
    );

    final path = p.join(directory.path, '${schema.name}.dbc');
    final loader = DbcLoader(path, schema.format);
    expect(loader.recordCount, 1);
    expect(loader.fieldCount, schema.format.length);
    expect(loader.getRecord(0).getInt(0), 1);
    expect(loader.getRecord(0).getInt(1), 1000);
  });

  test('DbcFileWriter 按传入行顺序写入,不重排 ID', () async {
    // Order-sensitive DBCs (Talent.dbc) require the file to keep the
    // original row order; the writer must never re-sort by ID.
    await util.write(
      schema: schema,
      rows: [sampleRow(id: 2), sampleRow(id: 1)],
      outputDirectory: directory.path,
    );

    final path = p.join(directory.path, '${schema.name}.dbc');
    final loader = DbcLoader(path, schema.format);
    expect(loader.recordCount, 2);
    expect(loader.getRecord(0).getInt(0), 2);
    expect(loader.getRecord(1).getInt(0), 1);
  });

  test('DbcFileWriter 遇到缺失字段时失败且不生成目标文件', () async {
    final target = File(p.join(directory.path, '${schema.name}.dbc'));

    await expectLater(
      util.write(
        schema: schema,
        rows: [
          {'ID': 1},
        ],
        outputDirectory: directory.path,
      ),
      throwsFormatException,
    );

    expect(await target.exists(), isFalse);
  });

  test('DbcFileWriter 校验失败时保留已有目标文件', () async {
    final target = File(p.join(directory.path, '${schema.name}.dbc'));
    await target.writeAsString('original');

    await expectLater(
      util.write(
        schema: schema,
        rows: [
          {'ID': 1},
        ],
        outputDirectory: directory.path,
      ),
      throwsFormatException,
    );

    expect(await target.readAsString(), 'original');
  });

  test('DbcFileWriter 对相同记录生成确定性文件', () async {
    final rows = [sampleRow()];
    final target = File(p.join(directory.path, '${schema.name}.dbc'));

    await util.write(
      schema: schema,
      rows: rows,
      outputDirectory: directory.path,
    );
    final first = await target.readAsBytes();

    await util.write(
      schema: schema,
      rows: rows,
      outputDirectory: directory.path,
    );
    final second = await target.readAsBytes();

    expect(second, first);
  });

  test('DbcFileWriter 目标文件已存在时成功覆盖', () async {
    final target = File(p.join(directory.path, '${schema.name}.dbc'));
    await util.write(
      schema: schema,
      rows: [sampleRow(duration: 1)],
      outputDirectory: directory.path,
    );
    final first = await target.readAsBytes();

    await util.write(
      schema: schema,
      rows: [sampleRow(duration: 999)],
      outputDirectory: directory.path,
    );
    final second = await target.readAsBytes();

    expect(second, isNot(equals(first)));
    final loader = DbcLoader(target.path, schema.format);
    expect(loader.getRecord(0).getInt(1), 999);
  });

  test('DbcFileWriter 拒绝将小数静默截断为整数', () async {
    await expectLater(
      util.write(
        schema: schema,
        rows: [
          {'ID': 1, 'Duration': 1.5, 'DurationPerLevel': 0, 'MaxDuration': 10},
        ],
        outputDirectory: directory.path,
      ),
      throwsFormatException,
    );
  });

  test('DbcFileWriter 拒绝超出 int32 范围的数值', () async {
    await expectLater(
      util.write(
        schema: schema,
        rows: [sampleRow(id: 2147483648)],
        outputDirectory: directory.path,
      ),
      throwsFormatException,
    );
  });

  test('DbcFileWriter 输出目录不存在时失败', () async {
    await expectLater(
      util.write(
        schema: schema,
        rows: [sampleRow()],
        outputDirectory: p.join(directory.path, 'missing_subdir'),
      ),
      throwsA(isA<FileSystemException>()),
    );
  });

  test('DbcFileWriter 支持中文、空字符串与重复字符串', () async {
    final icon = Definitions.spellIcon;
    final rows = [
      {'ID': 1, 'TextureFilename': ''},
      {'ID': 2, 'TextureFilename': '法术/图标_测试'},
      {'ID': 3, 'TextureFilename': '法术/图标_测试'},
    ];

    await util.write(schema: icon, rows: rows, outputDirectory: directory.path);

    final loader = DbcLoader(
      p.join(directory.path, '${icon.name}.dbc'),
      icon.format,
    );
    expect(loader.recordCount, 3);
    expect(loader.getRecord(0).getString(1), '');
    expect(loader.getRecord(1).getString(1), '法术/图标_测试');
    expect(loader.getRecord(2).getString(1), '法术/图标_测试');
  });

  test('normalizeValue: uint8 边界与越界', () {
    expect(util.normalizeValueForTest(0, format: 'b'), 0);
    expect(util.normalizeValueForTest(255, format: 'b'), 255);
    expect(
      () => util.normalizeValueForTest(256, format: 'b'),
      throwsFormatException,
    );
    expect(
      () => util.normalizeValueForTest(-1, format: 'b'),
      throwsFormatException,
    );
  });

  test('normalizeValue: bool 与 0/1', () {
    expect(util.normalizeValueForTest(true, format: 'l'), isTrue);
    expect(util.normalizeValueForTest(false, format: 'l'), isFalse);
    expect(util.normalizeValueForTest(1, format: 'l'), isTrue);
    expect(util.normalizeValueForTest(0, format: 'l'), isFalse);
    expect(
      () => util.normalizeValueForTest(2, format: 'l'),
      throwsFormatException,
    );
    expect(
      () => util.normalizeValueForTest('yes', format: 'l'),
      throwsFormatException,
    );
  });

  test('normalizeValue: 字符串禁止 NUL', () {
    expect(util.normalizeValueForTest('ok', format: 's'), 'ok');
    expect(
      () => util.normalizeValueForTest('a\x00b', format: 's'),
      throwsFormatException,
    );
  });

  test('导出阶段回调依次经过 writing/validating/committing', () async {
    final phases = <DbcExportPhase>[];
    await util.write(
      schema: schema,
      rows: [sampleRow()],
      outputDirectory: directory.path,
      onPhase: phases.add,
    );
    expect(phases, [
      DbcExportPhase.writing,
      DbcExportPhase.validating,
      DbcExportPhase.committing,
    ]);
  });

  group('copyDbcFiles', () {
    late Directory sourceDir;
    late Directory targetDir;

    setUp(() async {
      sourceDir = await Directory.systemTemp.createTemp('foxy_copy_src_');
      targetDir = await Directory.systemTemp.createTemp('foxy_copy_dst_');
    });

    tearDown(() async {
      if (await sourceDir.exists()) await sourceDir.delete(recursive: true);
      if (await targetDir.exists()) await targetDir.delete(recursive: true);
    });

    test('拷贝 .dbc 文件到目标目录并保留源文件', () async {
      final src = File(p.join(sourceDir.path, 'SpellDuration.dbc'))
        ..writeAsBytesSync([1, 2, 3]);
      File(p.join(sourceDir.path, 'notes.txt')).writeAsBytesSync([4]);

      final errors = await DbcFileWriter.copyDbcFiles(
        sourceDirectory: sourceDir.path,
        targetDirectory: targetDir.path,
      );

      expect(errors, isEmpty);
      final copied = File(p.join(targetDir.path, 'SpellDuration.dbc'));
      expect(await copied.exists(), isTrue);
      expect(copied.readAsBytesSync(), [1, 2, 3]);
      expect(await src.exists(), isTrue, reason: '源文件必须保留');
      // 非 .dbc 文件不拷贝。
      expect(File(p.join(targetDir.path, 'notes.txt')).existsSync(), isFalse);
      // 不残留 tmp/bak 中间文件。
      final leftovers = targetDir
          .listSync()
          .where((entity) => entity.path.contains('.foxy.'))
          .toList();
      expect(leftovers, isEmpty);
    });

    test('拷贝覆盖目标目录中已有的同名文件', () async {
      File(p.join(sourceDir.path, 'SpellDuration.dbc'))
          .writeAsBytesSync([1, 2, 3]);
      File(p.join(targetDir.path, 'SpellDuration.dbc'))
          .writeAsBytesSync([9, 9]);

      final errors = await DbcFileWriter.copyDbcFiles(
        sourceDirectory: sourceDir.path,
        targetDirectory: targetDir.path,
      );

      expect(errors, isEmpty);
      expect(
        File(p.join(targetDir.path, 'SpellDuration.dbc')).readAsBytesSync(),
        [1, 2, 3],
      );
    });

    test('isCancelled 为 true 时跳过拷贝', () async {
      File(p.join(sourceDir.path, 'A.dbc')).writeAsBytesSync([1]);
      File(p.join(sourceDir.path, 'B.dbc')).writeAsBytesSync([2]);

      final errors = await DbcFileWriter.copyDbcFiles(
        sourceDirectory: sourceDir.path,
        targetDirectory: targetDir.path,
        isCancelled: () => true,
      );

      expect(errors, isEmpty);
      expect(File(p.join(targetDir.path, 'A.dbc')).existsSync(), isFalse);
      expect(File(p.join(targetDir.path, 'B.dbc')).existsSync(), isFalse);
    });
  });
}
