import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/condition_entity.dart';

void main() {
  test('参数1 按条件类型动态映射为标签', () {
    // 布尔 select 规格（105 检查当前难度）映射为 是/否。
    const boolean = BriefConditionEntity(
      conditionTypeOrReference: 105,
      conditionValue1: 1,
    );
    expect(boolean.conditionValue1Label, '是');
    // flags 规格（16 种族掩码）展开为标签列表。
    const flags = BriefConditionEntity(
      conditionTypeOrReference: 16,
      conditionValue1: 0x01 | 0x02,
    );
    expect(flags.conditionValue1Label, '人类, 兽人');
    // number 规格回退为原始数字。
    const number = BriefConditionEntity(
      conditionTypeOrReference: 11,
      conditionValue1: 42,
    );
    expect(number.conditionValue1Label, '42');
    // 负数类型（引用）回退为原始数字。
    const reference = BriefConditionEntity(
      conditionTypeOrReference: -1,
      conditionValue1: 7,
    );
    expect(reference.conditionValue1Label, '7');
  });
}
