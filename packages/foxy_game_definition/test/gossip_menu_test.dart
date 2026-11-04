import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  test('Gossip option 类型、图标和语言枚举与当前 core 一致', () {
    expect(GossipMenuOptionConstants.gossipOptionTypes.keys.toSet(), {
      for (var value = 0; value <= 20; value++) value,
    });
    expect(GossipMenuOptionConstants.gossipOptionIcons.keys.toSet(), {
      for (var value = 0; value <= 13; value++) value,
      for (var value = 16; value <= 20; value++) value,
    });
    expect(GossipMenuOptionConstants.npcTextLanguages.keys.toSet(), {
      0,
      1,
      2,
      3,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      33,
      35,
      36,
      37,
      38,
    });
    expect(GossipMenuOptionConstants.gossipBooleanOptions, {0: '否', 1: '是'});
  });
}
