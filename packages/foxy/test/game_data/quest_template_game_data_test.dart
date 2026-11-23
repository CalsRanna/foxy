import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_quest_ender_entity.dart';
import 'package:foxy/entity/creature_quest_starter_entity.dart';
import 'package:foxy/entity/game_object_quest_ender_entity.dart';
import 'package:foxy/entity/game_object_quest_starter_entity.dart';

void main() {
  test('四张起止关系表都使用显式复合键字段', () {
    expect(const CreatureQuestStarterEntity().toJson().keys.toSet(), {
      'id',
      'quest',
    });
    expect(const CreatureQuestEnderEntity().toJson().keys.toSet(), {
      'id',
      'quest',
    });
    expect(const GameObjectQuestStarterEntity().toJson().keys.toSet(), {
      'id',
      'quest',
    });
    expect(const GameObjectQuestEnderEntity().toJson().keys.toSet(), {
      'id',
      'quest',
    });
  });
}
