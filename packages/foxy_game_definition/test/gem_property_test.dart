import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  test('颜色值使用 GemProperties 专属 SocketColor 组合', () {
    expect(GemPropertyConstants.gemPropertyColorOptions.keys.toSet(), {
      0x01,
      0x02,
      0x04,
      0x08,
      0x06,
      0x0a,
      0x0c,
      0x0e,
    });
    expect(
      GemPropertyConstants.gemPropertyColorOptions,
      containsPair(0x01, '多彩'),
    );
    expect(
      GemPropertyConstants.gemPropertyColorOptions,
      containsPair(0x06, '橙色（红色 + 黄色）'),
    );
    expect(
      GemPropertyConstants.gemPropertyColorOptions,
      containsPair(0x0e, '棱彩（红色 + 黄色 + 蓝色）'),
    );
    expect(GemPropertyConstants.gemPropertyColorOptions, isNot(contains(0)));
    expect(GemPropertyConstants.gemPropertyColorOptions, isNot(contains(3)));
    expect(GemPropertyConstants.gemPropertyColorOptions, isNot(contains(15)));
  });
}
