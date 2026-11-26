import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_quest_ender_entity.dart';
import 'package:foxy/entity/creature_quest_starter_entity.dart';
import 'package:foxy/entity/game_object_quest_ender_entity.dart';
import 'package:foxy/entity/game_object_quest_starter_entity.dart';

void main() {
  test(
    'All four quest starter and ender tables use explicit composite key fields',
    () {
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
    },
  );
}
