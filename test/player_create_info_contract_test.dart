import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/player_create_info_constants.dart';

void main() {

  test('种族职业 ID 与掩码分别对应 SharedDefines', () {
    expect(kPlayerRaceOptions.keys.toList(), [1, 2, 3, 4, 5, 6, 7, 8, 10, 11]);
    expect(kPlayerClassOptions.keys.toList(), [1, 2, 3, 4, 5, 6, 7, 8, 9, 11]);
    expect(kPlayerCreateRaceMaskFlags.map((item) => item.value).toList(), [
      1, 2, 4, 8, 16, 32, 64, 128, 512, 1024,
    ]);
    expect(kPlayerCreateClassMaskFlags.map((item) => item.value).toList(), [
      1, 2, 4, 8, 16, 32, 64, 128, 256, 1024,
    ]);
    expect(playerCreateRaceBit(10), 512);
    expect(playerCreateClassBit(11), 1024);
    expect(kPlayerCreatePlayableRaceMask, 1791);
    expect(kPlayerCreatePlayableClassMask, 1535);
  });

  test('动作类型只包含 Player ActionButtonType', () {
    expect(kPlayerActionButtonTypeOptions.keys.toSet(), {0, 1, 32, 64, 65, 128});
  });

}
