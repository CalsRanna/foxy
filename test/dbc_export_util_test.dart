import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/util/dbc_export_util.dart';
import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';

void main() {
  late Directory directory;
  late DbcDefinition definition;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('foxy_dbc_export_test_');
    definition = dbcDefinitionByTable['dbc_spell_duration']!;
  });

  tearDown(() async {
    if (await directory.exists()) await directory.delete(recursive: true);
  });

  test('DbcExportUtil 写入后可以使用 warcrafty 回读', () async {
    final rows = [
      {'ID': 1, 'Duration': 1000, 'DurationPerLevel': 25, 'MaxDuration': 2000},
    ];

    await DbcExportUtil().write(
      definition: definition,
      rows: rows,
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
      DbcExportUtil().write(
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
      DbcExportUtil().write(
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
    final rows = [
      {'ID': 1, 'Duration': 1000, 'DurationPerLevel': 25, 'MaxDuration': 2000},
    ];
    final util = DbcExportUtil();
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

  test('DbcExportUtil 拒绝将小数静默截断为整数', () async {
    await expectLater(
      DbcExportUtil().write(
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
      DbcExportUtil().write(
        definition: definition,
        rows: [
          {
            'ID': 2147483648,
            'Duration': 1,
            'DurationPerLevel': 0,
            'MaxDuration': 10,
          },
        ],
        outputDirectory: directory.path,
      ),
      throwsFormatException,
    );
  });
}
