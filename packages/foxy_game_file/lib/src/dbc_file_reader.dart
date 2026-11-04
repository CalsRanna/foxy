import 'package:foxy_game_file/src/dbc_file_exception.dart';
import 'package:foxy_game_file/src/dbc_header_guard.dart';
import 'package:warcrafty/warcrafty.dart';

class DbcFileReader {
  final DbcSchema schema;
  final DbcLoader _loader;

  DbcFileReader(String path, {required this.schema})
    : _loader = _open(path, schema);

  int get recordCount => _loader.recordCount;

  Iterable<DbcFileRecord> get records sync* {
    for (var index = 0; index < recordCount; index++) {
      yield readRecord(index);
    }
  }

  DbcFileRecord readRecord(int index) {
    final record = _loader.getRecord(index);
    return (
      index: record.index,
      values: {
        for (final field in schema.fields)
          if (!field.type.isSkip)
            field.name: _readValue(record, field.index, field.type),
      },
    );
  }

  static DbcLoader _open(String path, DbcSchema schema) {
    DbcHeaderGuard.assertPayloadSafe(path);
    return DbcLoader(path, schema.format);
  }

  static Object? _readValue(DbcRecord record, int index, FieldType type) {
    return switch (type) {
      FieldType.string => record.getString(index),
      FieldType.float => record.getFloat(index),
      FieldType.int32 || FieldType.id => record.getInt(index),
      FieldType.uint32 => record.getUint(index),
      FieldType.int64 => record.getInt64(index),
      FieldType.uint64 => _uint64(record, index),
      FieldType.int16 || FieldType.uint16 => record.getInt16(index),
      FieldType.int8 => record.getInt8(index),
      FieldType.uint8 => record.getUint8(index),
      FieldType.boolean => record.getInt(index) != 0,
      FieldType.sort || FieldType.unused || FieldType.unusedByte => null,
    };
  }

  static int _uint64(DbcRecord record, int index) {
    final value = record.getInt64(index);
    if (value < 0) {
      throw DbcFileException(
        'uint64 field $index has high bit set (value ≥ 2^63), '
        'which exceeds the signed 64-bit storage limit',
      );
    }
    return value;
  }
}

typedef DbcFileRecord = ({int index, Map<String, Object?> values});
