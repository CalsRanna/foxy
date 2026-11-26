import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/condition_entity.dart';

void main() {
  test('参数1 按条件类型动态映射为标签', () {
    // The boolean select spec for condition 105 (current difficulty) shows yes or no.
    const boolean = BriefConditionEntity(
      conditionTypeOrReference: 105,
      conditionValue1: 1,
    );
    expect(boolean.conditionValue1Label, '是');
    // The race mask for condition 16 expands into flag labels.
    const flags = BriefConditionEntity(
      conditionTypeOrReference: 16,
      conditionValue1: 0x01 | 0x02,
    );
    expect(flags.conditionValue1Label, '人类, 兽人');
    // A numeric spec displays the raw number.
    const number = BriefConditionEntity(
      conditionTypeOrReference: 11,
      conditionValue1: 42,
    );
    expect(number.conditionValue1Label, '42');
    // Negative condition types are references and display the raw number.
    const reference = BriefConditionEntity(
      conditionTypeOrReference: -1,
      conditionValue1: 7,
    );
    expect(reference.conditionValue1Label, '7');
  });
}
