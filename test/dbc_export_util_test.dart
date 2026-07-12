import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/util/dbc_export_util.dart';
import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';

void main() {
  late Directory directory;
  late DbcDefinition definition;
  late DbcExportUtil util;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('foxy_dbc_export_test_');
    definition = dbcDefinitionByTable['dbc_spell_duration']!;
    util = DbcExportUtil();
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

  test('DbcExportUtil 写入后可以使用 warcrafty 回读', () async {
    await util.write(
      definition: definition,
      rows: [sampleRow()],
      outputDirectory: directory.path,
    );

    final path = p.join(directory.path, definition.fileName);
    final loader = DbcLoader(path, definition.schema.format);
    expect(loader.recordCount, 1);
    expect(loader.fieldCount, definition.schema.format.length);
    expect(loader.getRecord(0).getInt(0), 1);
    expect(loader.getRecord(0).getInt(1), 1000);
  });

  test('DbcExportUtil 遇到缺失字段时失败且不生成目标文件', () async {
    final target = File(p.join(directory.path, definition.fileName));

    await expectLater(
      util.write(
        definition: definition,
        rows: [
          {'ID': 1},
        ],
        outputDirectory: directory.path,
      ),
      throwsFormatException,
    );

    expect(await target.exists(), isFalse);
  });

  test('DbcExportUtil 校验失败时保留已有目标文件', () async {
    final target = File(p.join(directory.path, definition.fileName));
    await target.writeAsString('original');

    await expectLater(
      util.write(
        definition: definition,
        rows: [
          {'ID': 1},
        ],
        outputDirectory: directory.path,
      ),
      throwsFormatException,
    );

    expect(await target.readAsString(), 'original');
  });

  test('DbcExportUtil 对相同记录生成确定性文件', () async {
    final rows = [sampleRow()];
    final target = File(p.join(directory.path, definition.fileName));

    await util.write(
      definition: definition,
      rows: rows,
      outputDirectory: directory.path,
    );
    final first = await target.readAsBytes();

    await util.write(
      definition: definition,
      rows: rows,
      outputDirectory: directory.path,
    );
    final second = await target.readAsBytes();

    expect(second, first);
  });

  test('DbcExportUtil 目标文件已存在时成功覆盖', () async {
    final target = File(p.join(directory.path, definition.fileName));
    await util.write(
      definition: definition,
      rows: [sampleRow(duration: 1)],
      outputDirectory: directory.path,
    );
    final first = await target.readAsBytes();

    await util.write(
      definition: definition,
      rows: [sampleRow(duration: 999)],
      outputDirectory: directory.path,
    );
    final second = await target.readAsBytes();

    expect(second, isNot(equals(first)));
    final loader = DbcLoader(target.path, definition.schema.format);
    expect(loader.getRecord(0).getInt(1), 999);
  });

  test('DbcExportUtil 拒绝将小数静默截断为整数', () async {
    await expectLater(
      util.write(
        definition: definition,
        rows: [
          {'ID': 1, 'Duration': 1.5, 'DurationPerLevel': 0, 'MaxDuration': 10},
        ],
        outputDirectory: directory.path,
      ),
      throwsFormatException,
    );
  });

  test('DbcExportUtil 拒绝超出 int32 范围的数值', () async {
    await expectLater(
      util.write(
        definition: definition,
        rows: [sampleRow(id: 2147483648)],
        outputDirectory: directory.path,
      ),
      throwsFormatException,
    );
  });

  test('DbcExportUtil 输出目录不存在时失败', () async {
    await expectLater(
      util.write(
        definition: definition,
        rows: [sampleRow()],
        outputDirectory: p.join(directory.path, 'missing_subdir'),
      ),
      throwsA(isA<FileSystemException>()),
    );
  });

  test('DbcExportUtil 支持中文、空字符串与重复字符串', () async {
    final icon = dbcDefinitionByTable['dbc_spell_icon']!;
    final rows = [
      {'ID': 1, 'TextureFilename': ''},
      {'ID': 2, 'TextureFilename': '法术/图标_测试'},
      {'ID': 3, 'TextureFilename': '法术/图标_测试'},
    ];

    await util.write(
      definition: icon,
      rows: rows,
      outputDirectory: directory.path,
    );

    final loader = DbcLoader(
      p.join(directory.path, icon.fileName),
      icon.schema.format,
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
      definition: definition,
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
}
