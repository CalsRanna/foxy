import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  test('种族职业 ID 与掩码分别对应 SharedDefines', () {
    expect(PlayerCreateInfoConstants.playerRaceOptions.keys.toList(), [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      10,
      11,
    ]);
    expect(PlayerCreateInfoConstants.playerClassOptions.keys.toList(), [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      11,
    ]);
    expect(
      PlayerCreateInfoConstants.playerCreateRaceMaskFlags
          .map((item) => item.value)
          .toList(),
      [1, 2, 4, 8, 16, 32, 64, 128, 512, 1024],
    );
    expect(
      PlayerCreateInfoConstants.playerCreateClassMaskFlags
          .map((item) => item.value)
          .toList(),
      [1, 2, 4, 8, 16, 32, 64, 128, 256, 1024],
    );
    expect(PlayerCreateInfoConstants.raceBit(10), 512);
    expect(PlayerCreateInfoConstants.classBit(11), 1024);
    expect(PlayerCreateInfoConstants.playerCreatePlayableRaceMask, 1791);
    expect(PlayerCreateInfoConstants.playerCreatePlayableClassMask, 1535);
  });

  test('动作类型只包含 Player ActionButtonType', () {
    expect(
      PlayerCreateInfoConstants.playerActionButtonTypeOptions.keys.toSet(),
      {0, 1, 32, 64, 65, 128},
    );
  });
}
