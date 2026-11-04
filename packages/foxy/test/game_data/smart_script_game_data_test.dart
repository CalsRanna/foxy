import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/smart_script_entity.dart';

void main() {
  test('fromJson 接受 MySQL 整数坐标且 copyWith 不丢失联合字段', () {
    final source = const SmartScriptEntity(
      entryOrGuid: 1,
      sourceType: 0,
      id: 2,
      link: 3,
      eventType: 9,
      eventPhaseMask: 4,
      eventChance: 80,
      eventFlags: 0x101,
      eventParam1: 11,
      eventParam2: 12,
      eventParam3: 13,
      eventParam4: 14,
      eventParam5: 15,
      eventParam6: 16,
      actionType: 67,
      actionParam1: 21,
      actionParam2: 22,
      actionParam3: 23,
      actionParam4: 24,
      actionParam5: 25,
      actionParam6: 26,
      targetType: 28,
      targetParam1: 31,
      targetParam2: 1,
      targetParam3: 1,
      targetParam4: 34,
      targetX: 1,
      targetY: 2,
      targetZ: 3,
      targetO: 4,
      comment: 'all fields',
    );
    final copied = source.copyWith(id: 99);
    expect(copied.toJson(), {...source.toJson(), 'id': 99});

    final mysqlRow = {...source.toJson(), 'target_x': 1, 'target_y': 2};
    final decoded = SmartScriptEntity.fromJson(mysqlRow);
    expect(decoded.targetX, 1.0);
    expect(decoded.targetY, 2.0);
  });
}
