import 'dart:io';
import 'dart:typed_data';

import 'package:foxy_game_file/foxy_game_file.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:warcrafty/warcrafty.dart';

void main() {
  late Directory directory;

  setUp(() {
    directory = Directory.systemTemp.createTempSync('foxy_dbc_reader_');
  });

  tearDown(() => directory.deleteSync(recursive: true));

  String writeRaw(DbcSchema schema, ByteData record) {
    final header = ByteData(20)
      ..setUint32(0, 0x43424457, Endian.little)
      ..setUint32(4, 1, Endian.little)
      ..setUint32(8, schema.fieldCount, Endian.little)
      ..setUint32(12, record.lengthInBytes, Endian.little)
      ..setUint32(16, 1, Endian.little);
    final file = File(p.join(directory.path, '${schema.name}.dbc'));
    file.writeAsBytesSync([
      ...header.buffer.asUint8List(),
      ...record.buffer.asUint8List(),
      0,
    ]);
    return file.path;
  }

  test('DBC 写入再读取保留字段值、文件行顺序与行索引', () async {
    final schema = Definitions.spellDuration;
    final rows = [
      {'ID': 20, 'Duration': -1, 'DurationPerLevel': 5, 'MaxDuration': 2000},
      {'ID': 10, 'Duration': 50, 'DurationPerLevel': 0, 'MaxDuration': 500},
    ];
    await DbcFileWriter().write(
      schema: schema,
      rows: rows,
      outputDirectory: directory.path,
    );
    final reader = DbcFileReader(
      p.join(directory.path, '${schema.name}.dbc'),
      schema: schema,
    );
    expect(reader.recordCount, 2);
    expect(reader.records.map((record) => record.index), [0, 1]);
    expect(reader.records.map((record) => record.values), rows);
    expect(reader.readRecord(1).values['ID'], 10);
  });

  test('中文、空字符串、反斜杠和引号读取为原始文本', () async {
    final schema = Definitions.spellIcon;
    final names = ['', "中文\\图标'测试\n下一行", '重复', '重复'];
    final rows = [
      for (var index = 0; index < names.length; index++)
        {'ID': index + 1, 'TextureFilename': names[index]},
    ];
    await DbcFileWriter().write(
      schema: schema,
      rows: rows,
      outputDirectory: directory.path,
    );
    final reader = DbcFileReader(
      p.join(directory.path, '${schema.name}.dbc'),
      schema: schema,
    );
    expect(reader.records.map((record) => record.values), rows);
  });

  test('读取高位 uint32、字节、布尔值并保留跳过字段语义', () {
    const schema = DbcSchema(
      name: 'Typed',
      format: 'nubBlxd',
      fields: [
        Field(index: 0, name: 'ID', description: '', type: FieldType.id),
        Field(index: 1, name: 'Flags', description: '', type: FieldType.uint32),
        Field(index: 2, name: 'Byte', description: '', type: FieldType.uint8),
        Field(index: 3, name: 'Signed', description: '', type: FieldType.int8),
        Field(
          index: 4,
          name: 'Enabled',
          description: '',
          type: FieldType.boolean,
        ),
        Field(
          index: 5,
          name: 'Unused',
          description: '',
          type: FieldType.unused,
        ),
        Field(index: 6, name: 'Sort', description: '', type: FieldType.sort),
      ],
    );
    final bytes = ByteData(schema.recordSize)
      ..setInt32(0, 7, Endian.little)
      ..setUint32(4, 0xffffffff, Endian.little)
      ..setUint8(8, 255)
      ..setInt8(9, -1)
      ..setInt32(10, 1, Endian.little);
    final reader = DbcFileReader(writeRaw(schema, bytes), schema: schema);
    expect(reader.records.single.values, {
      'ID': 7,
      'Flags': 4294967295,
      'Byte': 255,
      'Signed': -1,
      'Enabled': true,
      'Sort': null,
    });
  });

  test('uint64 超出 Dart 有符号整数范围时保留字段定位错误', () {
    const schema = DbcSchema(
      name: 'Unsigned64',
      format: 'Q',
      fields: [
        Field(index: 0, name: 'Value', description: '', type: FieldType.uint64),
      ],
    );
    final reader = DbcFileReader(
      writeRaw(schema, ByteData(8)..setInt64(0, -1, Endian.little)),
      schema: schema,
    );
    expect(
      () => reader.records.toList(),
      throwsA(
        isA<DbcFileException>().having(
          (error) => error.message,
          'message',
          contains('uint64 field 0 has high bit set'),
        ),
      ),
    );
  });

  test('空 DBC 返回零条记录', () async {
    final schema = Definitions.spellDuration;
    await DbcFileWriter().write(
      schema: schema,
      rows: [],
      outputDirectory: directory.path,
    );
    final reader = DbcFileReader(
      p.join(directory.path, '${schema.name}.dbc'),
      schema: schema,
    );
    expect(reader.recordCount, 0);
    expect(reader.records, isEmpty);
  });

  test('打开文件时先执行头部容量校验', () {
    final file = File(p.join(directory.path, 'Oversized.dbc'));
    final bytes = ByteData(20)
      ..setUint32(0, 0x43424457, Endian.little)
      ..setInt32(4, 1 << 30, Endian.little)
      ..setInt32(8, 4, Endian.little)
      ..setInt32(12, 16, Endian.little);
    file.writeAsBytesSync(bytes.buffer.asUint8List());
    expect(
      () => DbcFileReader(file.path, schema: Definitions.spellDuration),
      throwsA(isA<DbcFileException>()),
    );
  });
}
