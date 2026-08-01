import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_action_entity.dart';
import 'package:foxy/entity/player_create_info_cast_spell_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_item_entity.dart';
import 'package:foxy/entity/player_create_info_skill_entity.dart';
import 'package:foxy/entity/player_create_info_spell_custom_entity.dart';

void main() {
  test('六张 playercreateinfo 表 Entity 精确覆盖 31 个物理列', () {
    expect(const PlayerCreateInfoEntity().toJson().keys.toSet(), {
      'race', 'class', 'map', 'zone', 'position_x', 'position_y', 'position_z', 'orientation',
    });
    expect(const PlayerCreateInfoActionEntity().toJson().keys.toSet(), {
      'race', 'class', 'button', 'action', 'type',
    });
    expect(const PlayerCreateInfoItemEntity().toJson().keys.toSet(), {
      'race', 'class', 'itemid', 'amount', 'Note',
    });
    expect(const PlayerCreateInfoSkillEntity().toJson().keys.toSet(), {
      'raceMask', 'classMask', 'skill', 'rank', 'comment',
    });
    expect(const PlayerCreateInfoSpellCustomEntity().toJson().keys.toSet(), {
      'racemask', 'classmask', 'Spell', 'Note',
    });
    expect(const PlayerCreateInfoCastSpellEntity().toJson().keys.toSet(), {
      'raceMask', 'classMask', 'spell', 'note',
    });
  });

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
