import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/area_table_constants.dart';

void main() {

  test('AreaTeams 与 AreaFlags 对应当前 core 和 3.3.5a DBC', () {
    expect(AreaTableConstants.areaTeamOptions.keys.toList(), [0, 2, 4, 6]);
    expect(AreaTableConstants.areaFlagOptions.map((item) => item.value).toList(), [
      0x00000001, 0x00000002, 0x00000004, 0x00000008, 0x00000010,
      0x00000020, 0x00000040, 0x00000080, 0x00000100, 0x00000200,
      0x00000400, 0x00000800, 0x00001000, 0x00002000, 0x00004000,
      0x00008000, 0x00010000, 0x00020000, 0x00040000, 0x00080000,
      0x00100000, 0x00200000, 0x00400000, 0x00800000, 0x01000000,
      0x02000000, 0x04000000, 0x08000000, 0x20000000, 0x40000000,
    ]);
    expect(AreaTableConstants.areaTableKnownFlagMask, 0x6FFFFFFF);
  });

}
