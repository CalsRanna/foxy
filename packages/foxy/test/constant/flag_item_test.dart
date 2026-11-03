import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/flag_item.dart';

void main() {
  const flags = [
    FlagItem(0x01, '人类'),
    FlagItem(0x02, '兽人'),
    FlagItem(0x04, '矮人'),
  ];

  test('掩码命中多个 flag 时按声明顺序展开为标签', () {
    expect(FlagItem.maskLabel(0x01 | 0x04, flags), '人类, 矮人');
  });

  test('未命中任何 flag 时回退为原始掩码', () {
    expect(FlagItem.maskLabel(0x00, flags), '0');
    expect(FlagItem.maskLabel(0x08, flags), '8');
  });

  test('空 flag 列表时回退为原始掩码', () {
    expect(FlagItem.maskLabel(5, const []), '5');
  });
}
