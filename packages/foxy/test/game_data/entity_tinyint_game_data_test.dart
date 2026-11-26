import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';

/// H1 regression: laconic_mysql decodes tinyint(1) columns into Dart bool,
/// so the generated entity's fromJson must tolerate both bool and num;
/// otherwise reading real data throws TypeError (creature_onkill_reputation
/// crashes on load).
void main() {
  group('CreatureOnKillReputationEntity.fromJson accepts both tinyint(1) representations', () {
    test('Accepts the boolean tinyint(1) value decoded by the driver without a TypeError', () {
      final entity = CreatureOnKillReputationEntity.fromJson({
        'creature_id': 1,
        'TeamDependent': true,
        'IsTeamAward1': false,
        'RewOnKillRepValue1': 5,
      });
      expect(entity.teamDependent, 1);
      expect(entity.isTeamAward1, false);
    });

    test('Accepts numeric values from older drivers and the text protocol', () {
      final entity = CreatureOnKillReputationEntity.fromJson({
        'creature_id': 1,
        'TeamDependent': 1,
        'IsTeamAward1': 0,
      });
      expect(entity.teamDependent, 1);
      expect(entity.isTeamAward1, false);
    });

    test('Missing fields use their defaults', () {
      final entity = CreatureOnKillReputationEntity.fromJson({
        'creature_id': 1,
      });
      expect(entity.teamDependent, 0);
    });

    test('Serialization writes boolean values as numeric 1 and 0', () {
      final entity = CreatureOnKillReputationEntity.fromJson({
        'creature_id': 1,
        'TeamDependent': true,
      });
      final json = entity.toJson();
      expect(json['TeamDependent'], 1);
      expect(json['IsTeamAward1'], isA<int>());
    });
  });
}
